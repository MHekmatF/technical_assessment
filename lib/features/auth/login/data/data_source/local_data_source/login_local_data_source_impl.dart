import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:technical_assessment/features/auth/login/data/data_source/local_data_source/login_loacl_data_source.dart';
import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';

@Injectable(as: LoginLoaclDataSource)
class LoginLocalDataSourceImpl implements LoginLoaclDataSource {
  final Box<UserModel> box;

  LoginLocalDataSourceImpl(this.box);

  Future<bool> saveUser(UserModel user) async {
    try {
      final newId = box.keys.isEmpty
          ? 1
          : box.keys.cast<int>().reduce((a, b) => a > b ? a : b) + 1;

      final newUser = UserModel(
        id: newId,
        username: user.username,
        password: user.password,
      );

      await box.put(newId, newUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    final user = box.values.firstWhere(
      (u) => u.username == username && u.password == password,
      orElse: () => UserModel(id: 0, username: '', password: ''),
    );
    return user.username.isNotEmpty;
  }
}
