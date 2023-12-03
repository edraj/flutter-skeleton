import 'package:dmart_android_flutter/domain/models/base/api_response.dart';
import 'package:dmart_android_flutter/domain/models/base/error.dart';
import 'package:dmart_android_flutter/domain/models/base/query/response_record.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';

class ApiQueryResponse extends ApiResponse {
  final List<ResponseRecord> records;
  final ApiQueryResponseAttributes attributes;

  ApiQueryResponse({
    required Status status,
    ErrorModel? error,
    required this.records,
    required this.attributes,
  }) : super(status: status, error: error);

  factory ApiQueryResponse.fromJson(Map<String, dynamic> json) {
    return ApiQueryResponse(
      status: json['status'] == 'success' ? Status.success : Status.failed,
      error: json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
      records: (json['records'] as List<dynamic>)
          .map((record) => ResponseRecord.fromJson(record))
          .toList(),
      attributes: ApiQueryResponseAttributes.fromJson(
        Map<String, dynamic>.from(json['attributes']),
      ),
    );
  }
}

class ApiQueryResponseAttributes {
  final int total;
  final int returned;

  ApiQueryResponseAttributes({
    required this.total,
    required this.returned,
  });

  factory ApiQueryResponseAttributes.fromJson(Map<String, dynamic> json) {
    return ApiQueryResponseAttributes(
      total: json['total'],
      returned: json['returned'],
    );
  }
}
