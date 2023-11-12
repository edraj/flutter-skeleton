import 'package:dmart_android_flutter/domain/models/base/error.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';

class ApiResponse<T> {
  final Status status;
  final ErrorModel? error;

  ApiResponse({
    required this.status,
    this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] == 'success' ? Status.success : Status.failed,
      error: json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
    );
  }
}
