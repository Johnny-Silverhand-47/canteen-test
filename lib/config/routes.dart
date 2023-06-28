import 'package:canteen_test/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/login/login_screen.dart';

class AppRoutes {
  static const init = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(
        builder: (context) => const AppInit(),
      );

    case AppRoutes.home:
      return MaterialPageRoute(builder: (context) => const HomeScreen());

    case AppRoutes.login:
      return MaterialPageRoute(builder: (context) => const LoginScreen());

    default:
      return MaterialPageRoute(
        builder: (context) => const AppInit(),
      );
  }
}
