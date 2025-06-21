
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:technical_assessment/core/config/di.config.dart';
import 'package:technical_assessment/features/auth/login/data/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;


@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
}

