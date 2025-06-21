import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dashboard_state.dart';
import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';

class DashboardCubit extends Cubit<DashboardState> {
  late Timer _timer;
  final Box<UserModel> userBox;
  final double officeLat = 25.276987;
  final double officeLng = 55.296249;

  DashboardCubit(this.userBox)
      : super(DashboardState(currentTime: DateTime.now(), isLoading: true)) {
    getEmployeeInfo();
  }

  void getEmployeeInfo() {
    final UserModel? user = userBox.values.isNotEmpty ? userBox.values.last : null;

    if (user == null) {
      emit(state.copyWith(message: "No user found", isLoading: false));
      return;
    }

    emit(state.copyWith(user: user, currentTime: DateTime.now(), isLoading: false));

    // Timer to update time every second WITHOUT overwriting OCR or other fields
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(currentTime: DateTime.now()));
    });
  }

  Future<void> checkIn() async {
    emit(state.copyWith(isLoading: true, message: null));

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      final requestResult = await Geolocator.requestPermission();
      if (requestResult == LocationPermission.denied || requestResult == LocationPermission.deniedForever) {
        emit(state.copyWith(message: "Location permission denied", isLoading: false));
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      double distanceInMeters = Geolocator.distanceBetween(
        officeLat,
        officeLng,
        position.latitude,
        position.longitude,
      );

      const allowedRadius = 100;

      if (distanceInMeters <= allowedRadius) {
        emit(state.copyWith(
          isCheckIn: true,
          message: "Checked in successfully!",
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isCheckIn: false,
          message: "error ,You are not within the office area!",
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(message: "error Failed to get location: ${e.toString()}", isLoading: false));
    }
  }

  Future<XFile?> pickImage() async {
    final status = await Permission.storage.request();

    if (!status.isGranted) {
      emit(state.copyWith(message: "error Storage permission denied"));
      return null;
    }

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    return pickedImage;
  }

  Future<Map<String, String>> extractIdData(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    final fullText = recognizedText.text;
    print("Detected Text: $fullText");

    final nameRegex = RegExp(r'Name\s*[:\-]?\s*(\w+\s*\w*)', caseSensitive: false);
    final idRegex = RegExp(r'(\d{3}-\d{4}-\d{7}-\d)', caseSensitive: false);

    final nameMatch = nameRegex.firstMatch(fullText);
    final idMatch = idRegex.firstMatch(fullText);

    await textRecognizer.close();

    return {
      'name': nameMatch?.group(1) ?? '',
      'id': idMatch?.group(1) ?? '',
    };
  }


  Future<void> handleIdExtraction(String imagePath) async {
    emit(state.copyWith(isLoading: true, message: null));

    final extracted = await extractIdData(imagePath);

    if ((extracted['name']?.isEmpty ?? true) && (extracted['id']?.isEmpty ?? true)) {
      // No data extracted — show error message
      emit(state.copyWith(
        isLoading: false,
        message: "error No valid ID or Name found in the uploaded photo.",
        ocrName: null,
        ocrId: null,
      ));
      return;
    }

    // Data extracted successfully
    emit(state.copyWith(
      ocrName: extracted['name'],
      ocrId: extracted['id'],
      isLoading: false,
      message: "ID data extracted successfully.",
    ));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
