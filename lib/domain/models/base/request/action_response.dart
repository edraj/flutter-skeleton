import 'package:dmart_android_flutter/domain/models/base/api_response.dart';
import 'package:dmart_android_flutter/domain/models/base/error.dart';
import 'package:dmart_android_flutter/domain/models/base/query/response_record.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/utils/enums/base/resource_type.dart';

class ActionResponse extends ApiResponse {
  List<ActionResponseRecord>? records;

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
          .map((record) => ActionResponseRecord.fromJson(record))
          .toList();
    }

    return actionResponse;
  }
}

class ActionResponseRecord extends ResponseRecord {
  late final ActionResponseAttachments? attachments;

  ActionResponseRecord({
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

  factory ActionResponseRecord.fromJson(Map<String, dynamic> json) {
    var actionResponseRecord = ActionResponseRecord(
      resourceType: ResourceType.values.byName(json['resource_type']),
      uuid: json['uuid'],
      shortname: json['shortname'],
      subpath: json['subpath'],
      attributes: ResponseRecordAttributes.fromJson(json['attributes']),
    );
    if (json['attachments'] != null) {
      actionResponseRecord.attachments = ActionResponseAttachments.fromJson(
        Map<String, dynamic>.from(json['attachments']),
      );
    }
    return actionResponseRecord;
  }
}

class ActionResponseAttachments {
  final List<ActionResponseRecord> media;
  final List<ActionResponseRecord> json;

  ActionResponseAttachments({
    required this.media,
    required this.json,
  });

  factory ActionResponseAttachments.fromJson(Map<String, dynamic> json) {
    return ActionResponseAttachments(
      media: (json['media'] as List<dynamic>)
          .map((mediaRecord) => ActionResponseRecord.fromJson(mediaRecord))
          .toList(),
      json: (json['json'] as List<dynamic>)
          .map((jsonRecord) => ActionResponseRecord.fromJson(jsonRecord))
          .toList(),
    );
  }
}
