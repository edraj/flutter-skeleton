import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/utils/helpers/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController with CacheManager {
  TextEditingController msisdn = TextEditingController();
  TextEditingController password = TextEditingController();

  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  Future<LoginResponseModel> login(String shortname, String password) async {
    return await DmartAPIS.login(shortname, password);
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}
