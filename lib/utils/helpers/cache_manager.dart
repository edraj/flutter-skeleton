import 'package:dmart_android_flutter/utils/enums/cache_manager_key.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
  }
}
