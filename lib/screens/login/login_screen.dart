import 'package:canteen_test/config/routes.dart';
import 'package:canteen_test/theme/images.dart';
import 'package:canteen_test/utils/build_context.dart';
import 'package:canteen_test/utils/validators.dart';
import 'package:canteen_test/widgets/custom_button.dart';
import 'package:canteen_test/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../theme/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  double _screenHeight = 0.0;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  void _login() {
    Navigator.pushNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _backGround(),
            _foreGround(),
          ],
        ),
      ),
    );
  }

  Widget _backGround() {
    return SingleChildScrollView(
      child: SizedBox(
        height: _screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              AppImages.loginTop,
              width: MediaQuery.of(context).size.width,
            ),
            Image.asset(
              AppImages.loginBottom,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }

  Widget _foreGround() {
    final textStyle = Theme.of(context).textTheme;
    return SizedBox(
      height: _screenHeight,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsive(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: _screenHeight * (0.2)),
                Text(
                  'Welcome',
                  style: textStyle.headlineMedium!.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4),
                ),
                SizedBox(height: _screenHeight * (0.11)),
                CustomTextfield(
                  controller: _emailController,
                  labelText: 'Email Address',
                  suffix: Icon(
                    Icons.done_rounded,
                    color: _emailController.text.isNotEmpty
                        ? AppColors.tick
                        : AppColors.label,
                  ),
                  validator: MultiValidator([
                    requiredValidator(),
                    emailValidator,
                  ]),
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  controller: _passwordController,
                  labelText: 'Password',
                  validator: requiredValidator(),
                  obscureText: _hidePassword,
                  suffix: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        _hidePassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        color: AppColors.label,
                        size: 16,
                      ),
                      Icon(
                        Icons.done_rounded,
                        color: _passwordController.text.isNotEmpty
                            ? AppColors.tick
                            : AppColors.label,
                      )
                    ],
                  ),
                  onSuffixTap: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
                const SizedBox(height: 43),
                CustomButton.primary(text: 'Login', width: 185, onTap: _login)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
