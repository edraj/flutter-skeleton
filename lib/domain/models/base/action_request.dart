import 'package:dmart_android_flutter/utils/enums/base/request_type.dart';
import 'package:dmart_android_flutter/utils/enums/base/resource_type.dart';

class ActionRequest {
  final String spaceName;
  final RequestType requestType;
  final List<_ActionRequestRecord> records;

  ActionRequest({
    required this.spaceName,
    required this.requestType,
    required this.records,
  });

  Map<String, dynamic> toJson() {
    return {
      'space_name': spaceName,
      'request_type': requestType.toString(),
      'records': records.map((record) => record.toJson()).toList(),
    };
  }
}

class _ActionRequestRecord {
  final ResourceType resourceType;
  final String shortname;
  final String subpath;
  final Map<String, dynamic> attributes;
  final Map<ResourceType, List<dynamic>>? attachments;

  _ActionRequestRecord({
    required this.resourceType,
    required this.shortname,
    required this.subpath,
    required this.attributes,
    this.attachments,
  });

  factory _ActionRequestRecord.fromJson(Map<String, dynamic> json) {
    return _ActionRequestRecord(
      resourceType: ResourceType.values.byName(json['resource_type']),
      shortname: json['shortname'],
      subpath: json['subpath'],
      attributes: Map<String, dynamic>.from(json['attributes']),
      attachments: json['attachments'] != null
          ? Map<ResourceType, List<dynamic>>.from(json['attachments'])
          : null,
    );
  }

  toJson() {
    return {
      "resourceType": resourceType,
      "shortname": shortname,
      "subpath": subpath,
      "attributes": attributes
    };
  }
}
