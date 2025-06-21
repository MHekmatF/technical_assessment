import 'package:injectable/injectable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';

@module
abstract class HiveModule {
  @preResolve
  Future<Box<UserModel>> get userBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    return await Hive.openBox<UserModel>('userBox');
  }
}
