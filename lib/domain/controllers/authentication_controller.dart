import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/domain/repositories/login.dart';
import 'package:dmart_android_flutter/utils/helpers/cache_manager.dart';

class AuthenticationController extends GetxController with CacheManager {
  TextEditingController msisdn = TextEditingController();
  TextEditingController password = TextEditingController();

  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login(LoginRequestModel body) async {
    LoginResponseModel? response = await loginRequest(body.toJson());
    if(response!=null){
      // print(response.token);
      // print(response.error?.message);
    } else {
      // print("smtg went wrong badly");
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
