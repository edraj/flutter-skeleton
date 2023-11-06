import 'dart:ui';

import 'package:dmart_android_flutter/utils/helpers/cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController with CacheManager {
  Rx<String> selectedLanguage = "en".obs;
// Rx<TextDirection> textDirection = TextDirection.ltr.obs;

// void setDirection() {
//   final box = GetStorage();
//   String? lang = box.read("lang");
//
//   if(lang==null){
//     textDirection.value = TextDirection.ltr;
//     return;
//   }
//
//   switch(lang){
//     case "en":  textDirection.value = TextDirection.ltr; break;
//     case "ar":  textDirection.value = TextDirection.rtl; break;
//     default:  textDirection.value = TextDirection.ltr; break;
//   }
// }
}
