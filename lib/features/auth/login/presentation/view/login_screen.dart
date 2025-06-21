import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_assessment/core/config/di.dart';
import 'package:technical_assessment/core/utils/helper/sized_box_helper.dart';
import 'package:technical_assessment/core/utils/validator.dart';
import 'package:technical_assessment/features/auth/login/domain/usecase/login_usecase.dart';
import 'package:technical_assessment/features/auth/login/domain/usecase/save_user_usecase.dart';
import 'package:technical_assessment/features/auth/login/presentation/view_model/login_cubit.dart';
import 'package:technical_assessment/features/auth/login/presentation/view_model/login_state.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              LoginCubit(getIt<LoginUseCase>(), getIt<SaveUserUsecase>()),
      child: Builder(
        builder: (context) {
          final loginCubit = context.read<LoginCubit>();

          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Form(
                  key: loginCubit.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      responsiveHeight(context,0.10),
                      CircleAvatar(
                        radius: 80,
                        // controls size of the circle
                        backgroundColor: Colors.blueAccent,
                        // or any color you want for the circle
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          // icon color contrasting with background
                          size: 150, // size inside the circle
                        ),
                      ),
                      responsiveHeight(context,0.02),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff171717),
                        ),
                      ),

                      responsiveHeight(context,0.04),
                      TextFormField(
                        controller: loginCubit.emailController,style: TextStyle(color: Color(0xff171717)),
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Color(0xff171717)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(width: 1, color: Color(0xff171717)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(width: 1, color: Color(0xff171717)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(width: 1, color: Color(0xff171717)),
                          ),
                        ),
                        validator: (value) => Validator.validateEmail(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      responsiveHeight(context,0.02),
                      TextFormField(style: TextStyle(color: Color(0xff171717)),
                        controller: loginCubit.passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: "Paswword",
                          labelStyle: TextStyle(color: Color(0xff171717)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(width: 1, color: Color(0xff171717)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(width: 1, color: Color(0xff171717)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(width: 1, color: Color(0xff171717)),
                          ),
                        ),
                        validator: (value) => Validator.validatePassword(value),
                      ),

                      responsiveHeight(context,0.02),
                      BlocListener<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginLoading) {
                            showDialog(
                              context: context,
                              builder:
                                  (context) =>
                                      Center(child: CircularProgressIndicator(color: Colors.white,)),
                            );
                          } else if (state is LoginSuccess) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Logged in Successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushReplacementNamed(context, '/home');

                          } else if (state is LoginFailure) {
                            Navigator.pop(context);
                
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.blueAccent,
                            ),
                            foregroundColor: WidgetStatePropertyAll(
                              Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (loginCubit.formKey.currentState?.validate() ?? false) {
                              loginCubit.login();

                            }
                          },
                          child: Text("Login"),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
