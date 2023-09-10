import 'package:dio/dio.dart';
import 'package:dmart_android_flutter/configs/dio.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';

Future<LoginResponseModel?> loginRequest(Map<String, dynamic> data) async {
  try {
    dynamic response = await dio.post("/user/login", data: data);
    return LoginResponseModel.fromJson(response.data);
  } on DioException catch (e) {
    final response = e.response;
    if (response != null && response.data != null) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}