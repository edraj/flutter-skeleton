import 'package:dio/dio.dart';
import 'package:dmart_android_flutter/presentations/views/login_view.dart';
import 'package:dmart_android_flutter/utils/helpers/snackbars.dart';
import 'package:get/get.dart' as get_x;
import 'package:get_storage/get_storage.dart';

const baseUrl = 'https://api.dmart.cc';

final options = BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
);

final Dio dio = Dio(options);

void addInterceptors() {
  dio.interceptors.add(LogInterceptor(
    request: true,
    responseBody: true,
    requestBody: true,
    responseHeader: false,
    requestHeader: true,
    error: true,
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onResponse: (Response response, ResponseInterceptorHandler handler) {
      return handler.next(response);
    },
    onError: (DioException e, ErrorInterceptorHandler handler) {
      if (e.response?.statusCode == 401 &&
          e.response?.data["error"]["type"] == "jwtauth") {
        Snackbars.warning("Session Expired", "Please login again.",
            suppress: true);
        GetStorage().remove("token");
        get_x.Get.off(() => const LoginView());
      }
      return handler.next(e);
    },
  ));
}
