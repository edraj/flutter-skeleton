import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/presentations/views/home_view.dart';
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

  void login(LoginRequestModel body) async {
    LoginResponseModel response =
        await DmartAPIS.login(body.shortname, body.password);
    if (response.status == Status.success) {
      Get.to(const HomeView());
      // print(response.error?.message);
    } else {
      // print("smtg went wrong badly");
      Get.snackbar(
        "Invalid cred",
        response.error?.message ?? "",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error),
      );
    }
    // isLogged.value = true;
    //Token is cached
    // await saveToken(token);
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}
