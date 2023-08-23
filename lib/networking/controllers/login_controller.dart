import 'package:canteen_test/config/routes.dart';
import 'package:canteen_test/networking/controllers/auth_controller.dart';
import 'package:canteen_test/networking/services.dart';
import 'package:canteen_test/widgets/custom_flush_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';

class LoginController extends GetxController {
  LoginController({required this.context});
  final BuildContext context;
  final LoginService _loginService = Get.put(LoginService());
  final AuthController _authController = Get.put(AuthController());
  String _message = '';
  String get message => _message;

  final Rx<Status> _status= Status.initialized.obs;
  Rx<Status> get status => _status;

  @override
  void onInit(){
    super.onInit();
    ever(_status, (value) {
      if(value==Status.success){
        Get.offAllNamed(AppRoutes.home);//Redirecting to home screen
      }if(value==Status.error){
        AppMessenger.of(context).error(message);
      }
    });
  }

  Future<void> login(Map<String, dynamic> data) async {
    if (_status.value == Status.loading) return;
    try {
      _status.value = Status.loading;
      final res = await _loginService.login(data);
      _authController.authenticate(res!);//authenticating user with the login response
      _status.value = Status.success;
    } catch (e) {
      _message = e.toString();
      _status.value = Status.error;
    }
  }
}