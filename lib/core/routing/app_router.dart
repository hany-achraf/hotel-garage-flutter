import 'package:flutter/material.dart';

// import '../../features/auth/ui/pages/otp_page.dart';
// import '../../features/auth/ui/pages/forgot_password_page.dart';
// import '../../features/auth/ui/pages/reset_password_page.dart';
// import '../../features/auth/ui/pages/signin_page.dart';
// import '../../features/auth/ui/pages/signup_page.dart';
import '../../features/auth/ui/pages/login_page.dart';
import '../../features/home/ui/pages/home_page.dart';
// import '../../features/notifications/ui/pages/notifications_page.dart';
import '../../features/visit/ui/pages/end_visit_page.dart';
import '../../features/visit/ui/pages/new_visit_page.dart';
import '../../features/visit/ui/pages/qr_scanner_page.dart';
import 'middleware_map.dart';
import 'middlewares/logged_in_middleware.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final middlewares = routeMiddlewares[settings.name] ?? [];

    for (final middleware in middlewares) {
      if (!middleware(settings)) {
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (middleware == loggedinMiddleware) {
              return const LoginPage();
            }
            return const SizedBox();
          },
        );
      }
    }

    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginPage(),
        );
      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );
      case Routes.qrScanner:
        final redirect = settings.arguments as String?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => QrScannerPage(redirect: redirect!),
        );
      case Routes.newVisitPage:
        final qrCode = settings.arguments as String?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => NewVisitPage(qrCode: qrCode!),
        );
      case Routes.endVisitPage:
        final qrCode = settings.arguments as String?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => EndVisitPage(qrCode: qrCode!),
        );
      // case Routes.notifications:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (_) => const NotificationsPage(),
      //   );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
