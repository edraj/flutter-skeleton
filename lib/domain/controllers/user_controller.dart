import 'package:dmart_android_flutter/domain/models/base/permission.dart';
import 'package:get/get.dart';
import 'package:dmart_android_flutter/utils/helpers/cache_manager.dart';

class UserController extends GetxController with CacheManager {
  Map<String, Permission> permissions = {};
}