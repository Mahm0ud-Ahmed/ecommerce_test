import 'package:ecommerce_test/src/presentation/view/pages/home/home_page.dart';
import 'package:flutter/material.dart';

import 'src/core/config/injector.dart';
import 'src/core/config/l10n/generated/l10n.dart';
import 'src/core/services/setting_service.dart';

void main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final setting = SettingService();
    return ListenableBuilder(
      listenable: setting,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: S.current.app_name,
        theme: setting.theme.theme,
        darkTheme: setting.theme.theme,
        themeMode: SettingService.stateMod,
        locale: setting.locale,
        localizationsDelegates: const [
          S.delegate,
          AppLocalizationDelegate(),
        ],
        home: const HomePage(),
      ),
    );
  }
}
