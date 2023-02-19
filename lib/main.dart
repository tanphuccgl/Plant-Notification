import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/feature/account/account_bloc.dart';
import 'src/feature/account/user_local.dart';
import 'src/feature/notification/notification_service.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initial();
  GetIt.I.registerLazySingleton(() => AccountBloc());
  await UserPref.init();

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));
}
