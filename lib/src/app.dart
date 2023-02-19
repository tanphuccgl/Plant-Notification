import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'feature/account/account_bloc.dart';
import 'feature/home/home_page.dart';
import 'feature/notification/notification_bloc.dart';
import 'feature/store/store_page.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return AnimatedBuilder(
            animation: settingsController,
            builder: (BuildContext context, Widget? child) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => GetIt.I<AccountBloc>(),
                  ),
                  BlocProvider(
                    create: (_) => NotificationBloc(),
                  ),
                ],
                child: BlocBuilder<AccountBloc, AccountState>(
                  buildWhen: (p, c) => false,
                  builder: (context, _) {
                    return MaterialApp(
                      navigatorKey: MyApp.navigatorKey,
                      restorationScopeId: 'app',
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: const [
                        Locale('en', ''), // English, no country code
                      ],
                      builder: BotToastInit(),
                      onGenerateTitle: (BuildContext context) =>
                          AppLocalizations.of(context)!.appTitle,
                      theme: ThemeData(
                          useMaterial3: true,
                          colorSchemeSeed: Colors.green.withOpacity(0.3)),
                      darkTheme: ThemeData.dark(),
                      themeMode: settingsController.themeMode,
                      onGenerateRoute: (RouteSettings routeSettings) {
                        return MaterialPageRoute<void>(
                          settings: routeSettings,
                          builder: (BuildContext context) {
                            switch (routeSettings.name) {
                              case SettingsView.routeName:
                                return SettingsView(
                                    controller: settingsController);
                              case StorePage.routeName:
                                return const StorePage();
                              case HomePage.routeName:
                              default:
                                return const HomePage();
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        });
  }
}
