import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/injection_container.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/themes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();

  static void setLocale(BuildContext context, Locale locale) {
    _AppState? state = context.findAncestorStateOfType<_AppState>();
    state?.setLocale(locale);
  }
}

class _AppState extends State<App> {
  Locale? _locale;

  void _initLang() {
    final lang = sl<SharedPreferences>().getString('lang');
    _locale = Locale(lang ?? 'ar');
  }

  @override
  void initState() {
    super.initState();
    _initLang();
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App',
            // localizationsDelegates: AppLocalizations.localizationsDelegates,
            // supportedLocales: AppLocalizations.supportedLocales,
            locale: _locale,
            theme: Themes.light,
            initialRoute: Routes.home,
            navigatorKey: sl<GlobalKey<NavigatorState>>(),
            onGenerateRoute: sl<AppRouter>().generateRoute,
          );
        },
      ),
    );
  }
}
