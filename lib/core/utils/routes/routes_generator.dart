import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_assessment/core/utils/routes/routes_name.dart';
import 'package:technical_assessment/features/auth/login/presentation/view/login_screen.dart';
import 'package:technical_assessment/features/home/presentation/view/home_screen.dart';

class RoutesGenerator {
  static Route<dynamic>? onGenerator(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
          settings: settings,
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: settings,
        );

      default:
        return null;
    }
  }
}
