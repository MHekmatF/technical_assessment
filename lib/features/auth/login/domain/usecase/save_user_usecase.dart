import 'package:injectable/injectable.dart';
import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';
import 'package:technical_assessment/features/auth/login/domain/repository_contract/login_repository.dart';
@injectable

class SaveUserUsecase {
  final LoginRepository repository;

  SaveUserUsecase(this.repository);

  Future<bool> call(UserModel user) {
    return repository.saveUser(user);
  }
}
