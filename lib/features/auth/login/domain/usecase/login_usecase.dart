import 'package:injectable/injectable.dart';
import 'package:technical_assessment/features/auth/login/domain/repository_contract/login_repository.dart';
@injectable

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(String username, String password) {
    return repository.login(username, password);
  }
}
