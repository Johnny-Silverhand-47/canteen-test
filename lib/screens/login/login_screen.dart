import 'package:canteen_test/networking/controllers/login_controller.dart';
import 'package:canteen_test/theme/images.dart';
import 'package:canteen_test/utils/build_context.dart';
import 'package:canteen_test/utils/validators.dart';
import 'package:canteen_test/widgets/custom_button.dart';
import 'package:canteen_test/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';
import '../../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  double _screenHeight = 0.0;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

   LoginController? _loginController;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final data = <String, dynamic>{
        'username': _phoneController.text,
        'password': _passwordController.text,
        'store_id': '10',
      };
      await _loginController!.login(data);
    }
  }

  @override
  void initState(){
    _loginController = Get.put(LoginController(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              _backGround(),
              _foreGround(_loginController!.status.value),
            ],
          ),
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

  Widget _foreGround(Status status) {
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
                  controller: _phoneController,
                  labelText: 'Mobile number',
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  suffix: Icon(
                    Icons.done_rounded,
                    color: _phoneController.text.isNotEmpty
                        ? AppColors.tick
                        : AppColors.label,
                  ),
                  validator: requiredValidator(),
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  controller: _passwordController,
                  labelText: 'Password',
                  validator: requiredValidator(),
                  maxLines: 1,
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
                CustomButton.primary(
                  text: 'Login',
                  width: 185,
                  isloading: status==Status.loading,
                  onTap: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
