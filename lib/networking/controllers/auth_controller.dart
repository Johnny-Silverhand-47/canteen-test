import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/user_model.dart';

class AuthController extends GetxController with CacheManager {
  String _message = '';
  String get message => _message;
  RxBool isLogged = false.obs;//This bool is used to set and validate user authentication

  Future<void> authenticate(UserModel user) async {//To authenticate user user after successful login
    UserData().userModel = user;
    final res = await saveUser(user);
    isLogged.value = res;
  }

  Future<void> unAuthenticate() async {
    UserData().userModel = UserModel();
    await deleteUser();
    isLogged.value = false;
  }

  Future<void> checkAuthentication() async {//To validate user when opening app
    try {
      final user = await getUser();
      if (user != null) {
        UserData().userModel = user;
        isLogged.value = true;
      } else {
        isLogged.value = false;
      }
    } catch (e) {
      _message = e.toString();
      isLogged.value = false;
    }
  }
}

mixin CacheManager {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> saveUser(UserModel userModel) async {//Stores usermodel in secure storage after json encoding
    try {
      final userString = json.encode(userModel.toJson());
      await secureStorage.write(key: 'user', value: userString);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteUser() async {
    await secureStorage.deleteAll();
  }

  Future<UserModel?> getUser() async {//Retrieves user model json and decoding back to user model class
    final userString = await secureStorage.read(key: 'user') ?? '';
    return userString != ''
        ? UserModel.fromJson(json.decode(userString) as Map<String, dynamic>)
        : null;
  }
}
