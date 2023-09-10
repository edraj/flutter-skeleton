import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dmart_android_flutter/presentations/views/home_view.dart';
import 'package:dmart_android_flutter/presentations/views/login_view.dart';
import 'package:dmart_android_flutter/utils/enums/cache_manager_key.dart';

Widget wrapper(Widget child){
  return SafeArea(child: child);
}

void main() async {
  await GetStorage.init();

  GetStorage box = GetStorage();

  runApp(
    GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () {
            return Scaffold(resizeToAvoidBottomInset:false, body: box.hasData(CacheManagerKey.TOKEN.toString()) ? wrapper(const HomeView()) : wrapper(const LoginView()),);
          },
        )
      ],
    ),
  );
}
