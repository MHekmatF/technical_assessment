import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';

abstract class LoginLoaclDataSource {
  Future<bool> login(String username, String password);
  Future<bool> saveUser(UserModel user);
}