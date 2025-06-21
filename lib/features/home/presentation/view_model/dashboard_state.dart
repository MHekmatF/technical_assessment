import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';

class DashboardState {
  final UserModel? user;
  final DateTime currentTime;
  final bool isCheckIn;
  final String? ocrName;
  final String? ocrId;
  final String? message; // For error or success messages
  final bool isLoading;

  DashboardState({
    this.user,
    required this.currentTime,
    this.isCheckIn = false,
    this.ocrName,
    this.ocrId,
    this.message,
    this.isLoading = false,
  });

  DashboardState copyWith({
    UserModel? user,
    DateTime? currentTime,
    bool? isCheckIn,
    String? ocrName,
    String? ocrId,
    String? message,
    bool? isLoading,
  }) {
    return DashboardState(
      user: user ?? this.user,
      currentTime: currentTime ?? this.currentTime,
      isCheckIn: isCheckIn ?? this.isCheckIn,
      ocrName: ocrName ?? this.ocrName,
      ocrId: ocrId ?? this.ocrId,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
