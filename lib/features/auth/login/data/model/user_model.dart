import 'package:hive/hive.dart';
import 'package:technical_assessment/features/auth/login/domain/entity/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String password;

  UserModel({
    required this.id,
    required this.username,
    required this.password,
  });

  // mapper from domain
  factory UserModel.fromEntity(User user) {
    return UserModel(id: user.id, username: user.username, password: user.password);
  }

  // mapper to domain
  User toEntity() {
    return User(id: id, username: username, password: password);
  }
}
