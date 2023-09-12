import 'package:dmart_android_flutter/domain/models/base/api_response.dart';
import 'package:dmart_android_flutter/domain/models/base/error.dart';
import 'package:dmart_android_flutter/domain/models/base/response_record.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/utils/enums/base/resource_type.dart';

class ActionResponse extends ApiResponse {
  final List<_ActionResponseRecord> records;

  ActionResponse({
    required Status status,
    ErrorModel? error,
    required this.records,
  }) : super(status: status, error: error);

  factory ActionResponse.fromJson(Map<String, dynamic> json) {
    return ActionResponse(
      status: json['status'] == 'success' ? Status.success : Status.failed,
      error: json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
      records: (json['records'] as List<dynamic>)
          .map((record) => _ActionResponseRecord.fromJson(record))
          .toList(),
    );
  }
}

class _ActionResponseRecord extends ResponseRecord {
  final _ActionResponseAttachments attachments;

  _ActionResponseRecord({
    required ResourceType resourceType,
    required String uuid,
    required String shortname,
    required String subpath,
    required ResponseRecordAttributes attributes,
    required this.attachments,
  }) : super(
          resourceType: resourceType,
          uuid: uuid,
          shortname: shortname,
          subpath: subpath,
          attributes: attributes,
        );

  factory _ActionResponseRecord.fromJson(Map<String, dynamic> json) {
    return _ActionResponseRecord(
      resourceType: json['resource_type'],
      uuid: json['uuid'],
      shortname: json['shortname'],
      subpath: json['subpath'],
      attributes: json['attributes'],
      attachments: _ActionResponseAttachments.fromJson(
        Map<String, dynamic>.from(json['attachments']),
      ),
    );
  }
}

class _ActionResponseAttachments {
  final List<_ActionResponseRecord> media;
  final List<_ActionResponseRecord> json;

  _ActionResponseAttachments({
    required this.media,
    required this.json,
  });

  factory _ActionResponseAttachments.fromJson(Map<String, dynamic> json) {
    return _ActionResponseAttachments(
      media: (json['media'] as List<dynamic>)
          .map((mediaRecord) => _ActionResponseRecord.fromJson(mediaRecord))
          .toList(),
      json: (json['json'] as List<dynamic>)
          .map((jsonRecord) => _ActionResponseRecord.fromJson(jsonRecord))
          .toList(),
    );
  }
}
