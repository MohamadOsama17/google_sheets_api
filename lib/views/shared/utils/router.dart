import 'package:flutter/material.dart';
import 'package:google_sheet_task/views/screens/landing/landing_screen.dart';
import 'package:google_sheet_task/views/screens/splash/splash_screen.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: RouteSettings(
            name: AppRoutes.initialRoute,
          ),
        );
      case AppRoutes.landing:
        return MaterialPageRoute(
          builder: (_) => LandingScreen(),
          settings: RouteSettings(
            name: AppRoutes.landing,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route Defained for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static BuildContext dialogContext = navKey.currentState.overlay.context;

  static Route createRoute(
      {@required Widget screen, String routeName, dynamic args}) {
    return MaterialPageRoute(
      builder: (_) => screen,
      settings: RouteSettings(
        arguments: args,
        name: routeName,
      ),
    );
  }

  static Future pushNamed(String route, {dynamic args}) {
    return navKey.currentState.pushNamed(route, arguments: args);
  }

  static pop({dynamic args}) {
    return navKey.currentState.pop();
  }

  static Future pushNamedAndRemoveUntil(String route,
      {dynamic args, String route2}) {
    return navKey.currentState.pushNamedAndRemoveUntil(
      route,
      route2 != null ? ModalRoute.withName(route2) : (_) => false,
      arguments: args,
    );
  }

  static Future popAndPush(String route, {dynamic args}) {
    return navKey.currentState.popAndPushNamed(route, arguments: args);
  }

  static Future pushReplacementNamed(String route, {dynamic args}) {
    return navKey.currentState.pushReplacementNamed(
      route,
      arguments: args,
    );
  }

  static void popUntil(String route, {dynamic args}) {
    return navKey.currentState.popUntil(ModalRoute.withName(route));
  }
}

class AppRoutes {
  static const String initialRoute = '/';
  static const String landing = 'landingScreen';
}
