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

class ApiResponseRecord {
  final String resourceType;
  final String shortname;
  final String? branchName;
  final String subpath;

  ApiResponseRecord({
    required this.resourceType,
    required this.shortname,
    this.branchName,
    required this.subpath,
  });

  factory ApiResponseRecord.fromJson(Map<String, dynamic> json) {
    return ApiResponseRecord(
      resourceType: json['resource_type'],
      shortname: json['shortname'],
      branchName: json['branch_name'],
      subpath: json['subpath'],
    );
  }
}
