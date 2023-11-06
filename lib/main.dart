import 'package:dmart_android_flutter/presentations/views/home_view.dart';
import 'package:dmart_android_flutter/presentations/views/login_view.dart';
import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:dmart_android_flutter/utils/enums/cache_manager_key.dart';
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
    return box.hasData(CacheManagerKey.TOKEN.toString())
        ? wrapper(const HomeView())
        : wrapper(const LoginView());
  }
}

void main() async {
  await GetStorage.init();
  await AppLocalizations.setLang();
  GetStorage box = GetStorage();
  String? lang = box.read("lang");

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
