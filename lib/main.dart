

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_assessment/core/config/di.dart';
import 'package:technical_assessment/core/utils/routes/routes_generator.dart';
import 'package:technical_assessment/core/utils/routes/routes_name.dart';
import 'package:technical_assessment/core/utils/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesGenerator.onGenerator,
      initialRoute: RoutesName.login,
    );
  }
}
