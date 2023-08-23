import 'package:canteen_test/screens/home/home_screen.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../screens/login/login_screen.dart';

class AppRoutes {
  static const init = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
}
final getPages = [
  GetPage(name: AppRoutes.init, page: () => const AppInit()),
  GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
  GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
];
