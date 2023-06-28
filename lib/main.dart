import 'package:canteen_test/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return MaterialApp(
      title: 'E Canteen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        textTheme: textTheme,
        scaffoldBackgroundColor: AppColors.white,
        useMaterial3: true,
      ),
      onGenerateRoute: generateRoute,
    );
  }
}

class AppInit extends StatefulWidget {
  const AppInit({Key? key}) : super(key: key);

  @override
  State<AppInit> createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      // child: curretnScreen(data.state),
      child: LoginScreen(),
    );
  }

  // Widget curretnScreen(AuthState state) {
  //   switch (state) {
  //     case AuthState.initialize:
  //       return const SplashScreen();
  //     case AuthState.authenticated:
  //       return const HomeScreen();
  //     case AuthState.unauthenticated:
  //       return const OnboardScreen();
  //     default:
  //       return const OnboardScreen();
  //   }
  // }
}
