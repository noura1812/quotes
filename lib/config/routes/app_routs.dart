import 'package:flutter/material.dart';
import 'package:quotes/features/tabs_screens/presentation/pages/test_screen.dart';

class Routes {
  static const String testScreen = '/';
}

class AppRoutes {
  static Route onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.testScreen:
        return MaterialPageRoute(
          builder: (context) => TestScreen(),
        );
      default:
        {
          return MaterialPageRoute(
            builder: (context) => unDefineRoute(),
          );
        }
    }
  }

  static Widget unDefineRoute() => const Scaffold(
        body: Center(
          child: Text('unDefinedRoute'),
        ),
      );
}
