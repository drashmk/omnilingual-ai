import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:chat/app_lifecycle/app_lifecycle.dart';
import 'package:chat/pages/home_page.dart';
import 'package:chat/providers/main_provider.dart';
import 'package:chat/providers/settings_provider.dart';
import 'package:chat/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
    );
  });
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => MainProvider()),
          Provider(create: (context) => SettingsProvider()),
        ],
        child: Builder(builder: (context) {
          return AdaptiveTheme(
              debugShowFloatingThemeButton: false,
              initial: savedThemeMode ?? AdaptiveThemeMode.system,
              light: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                colorScheme: MaterialTheme.lightScheme().toColorScheme(),
              ),
              dark: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                colorScheme: MaterialTheme.darkScheme().toColorScheme(),
              ),
              builder: (theme, darkTheme) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Omnilingual AI',
                    theme: theme,
                    darkTheme: darkTheme,
                    home: const HomePage(title: 'Omnilingual AI'),
                  ));
        }),
      ),
    );
  }
}
