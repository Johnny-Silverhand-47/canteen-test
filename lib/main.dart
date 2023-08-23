import 'package:canteen_test/networking/controllers/auth_controller.dart';
import 'package:canteen_test/screens/home/home_screen.dart';
import 'package:canteen_test/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'config/routes.dart';
import 'theme/colors.dart';
import 'theme/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E Canteen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        textTheme: textTheme,
        scaffoldBackgroundColor: AppColors.white,
        useMaterial3: true,
      ),
      home: const AppInit(),
      getPages: getPages,
    );
  }
}

class AppInit extends StatefulWidget {
  const AppInit({Key? key}) : super(key: key);

  @override
  State<AppInit> createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  final AuthController _authController = Get.put(AuthController());
  Future<void> initAuthSettings() async {
    await _authController.checkAuthentication();
  }

  @override
  void initState() {
    initAuthSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Obx(
        () => _authController.isLogged.value
            ? const HomeScreen()
            : const LoginScreen(),
      ),
    );
  }
}
