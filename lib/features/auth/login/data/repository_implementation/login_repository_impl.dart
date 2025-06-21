

import 'package:injectable/injectable.dart';
import 'package:technical_assessment/features/auth/login/data/data_source/local_data_source/login_loacl_data_source.dart';
import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';
import 'package:technical_assessment/features/auth/login/domain/repository_contract/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginLoaclDataSource loginLoaclDataSource;

  LoginRepositoryImpl(this.loginLoaclDataSource);

  @override
  Future<bool> login(String username, String password) {
    return loginLoaclDataSource.login(username, password);
  }

  @override
  Future<bool> saveUser(UserModel user) {
return loginLoaclDataSource.saveUser(user);
  }
}
