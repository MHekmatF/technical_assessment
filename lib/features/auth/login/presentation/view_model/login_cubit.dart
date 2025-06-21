import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';
import 'package:technical_assessment/features/auth/login/domain/usecase/login_usecase.dart';
import 'package:technical_assessment/features/auth/login/domain/usecase/save_user_usecase.dart';
import 'package:technical_assessment/features/auth/login/presentation/view_model/login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  final SaveUserUsecase saveUserUsecase;

  LoginCubit(this.loginUseCase, this.saveUserUsecase) : super(LoginInitial());
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> login() async {
    emit(LoginLoading());
    await Future.delayed(Duration(seconds: 2));
    final result =   await saveUserUsecase(UserModel(id: 0, username: emailController.text, password: passwordController.text));

    if (result) {
      try {
        await loginUseCase(emailController.text, passwordController.text);

        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure("Invalid credentials "));
      }
    } else {
      emit(LoginFailure("Failed to save user"));
    }
  }


}
