import 'package:flutter/material.dart';
import 'package:quotes/features/set_data/presentation/pages/se_users_data.dart';

class Routes {
  static const String setUsersData = '/';
}

class AppRoutes {
  static Route onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.setUsersData:
        return MaterialPageRoute(
          builder: (context) => SetUsersData(),
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
