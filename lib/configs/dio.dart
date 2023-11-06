import 'package:dio/dio.dart';

final options = BaseOptions(
  baseUrl: 'https://api.dmart.cc',
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
);

final dio = Dio(options);
