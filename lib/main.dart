import 'package:dmart_android_flutter/configs/dio.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/presentations/views/home_view.dart';
import 'package:dmart_android_flutter/presentations/views/login_view.dart';
import 'package:dmart_android_flutter/utils/constants/spaces.dart';
import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Widget wrapper(Widget child) {
  return SafeArea(child: child);
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    return box.hasData("token")
        ? wrapper(const HomeView())
        : wrapper(const LoginView());
  }
}

void main() async {
  await GetStorage.init();
  await AppLocalizations.setLang();
  addInterceptors();
  GetStorage box = GetStorage();
  String? lang = box.read("lang");

  PlatformDispatcher.instance.onError = (error, stack) {
    DmartAPIS.submit(SPACES.applications.name, 'log', 'logs', {
      "error": {
        "class": error.toString(),
        "stack": stack.toString(),
      }
    });
    return true;
  };

  runApp(
    GetMaterialApp(
      locale: Locale(lang ?? "en"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizationsDelegate()
      ],
      supportedLocales: const [Locale('en'), Locale('ar')],
      home: const MainWidget(),
    ),
  );
}
