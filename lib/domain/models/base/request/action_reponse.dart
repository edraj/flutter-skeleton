import 'package:dmart_android_flutter/domain/models/base/api_response.dart';
import 'package:dmart_android_flutter/domain/models/base/error.dart';
import 'package:dmart_android_flutter/domain/models/base/query/response_record.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/utils/enums/base/resource_type.dart';

class ActionResponse extends ApiResponse {
  List<_ActionResponseRecord>? records;

  ActionResponse({
    required Status status,
    ErrorModel? error,
    this.records,
  }) : super(status: status, error: error);

  factory ActionResponse.fromJson(Map<String, dynamic> json) {
    ActionResponse actionResponse = ActionResponse(
      status: json['status'] == 'success' ? Status.success : Status.failed,
      error: json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
    );
    if (json['records'] != null) {
      actionResponse.records = (json['records'] as List<dynamic>)
          .map((record) => _ActionResponseRecord.fromJson(record))
          .toList();
    }

    return actionResponse;
  }
}

class _ActionResponseRecord extends ResponseRecord {
  late final _ActionResponseAttachments? attachments;

  _ActionResponseRecord({
    required ResourceType resourceType,
    required String uuid,
    required String shortname,
    required String subpath,
    required ResponseRecordAttributes attributes,
  }) : super(
          resourceType: resourceType,
          uuid: uuid,
          shortname: shortname,
          subpath: subpath,
          attributes: attributes,
        );

  factory _ActionResponseRecord.fromJson(Map<String, dynamic> json) {
    var _actionResponseRecord = _ActionResponseRecord(
      resourceType: ResourceType.values.byName(json['resource_type']),
      uuid: json['uuid'],
      shortname: json['shortname'],
      subpath: json['subpath'],
      attributes: ResponseRecordAttributes.fromJson(json['attributes']),
    );
    if (json['attachments'] != null) {
      _actionResponseRecord.attachments = _ActionResponseAttachments.fromJson(
        Map<String, dynamic>.from(json['attachments']),
      );
    }
    return _actionResponseRecord;
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
