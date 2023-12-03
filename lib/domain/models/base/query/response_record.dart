import 'package:dmart_android_flutter/domain/models/base/payload.dart';
import 'package:dmart_android_flutter/domain/models/base/translation.dart';
import 'package:dmart_android_flutter/utils/enums/base/resource_type.dart';

class ResponseRecord {
  final ResourceType resourceType;
  final String uuid;
  final String shortname;
  final String subpath;
  final ResponseRecordAttributes attributes;

  ResponseRecord({
    required this.resourceType,
    required this.uuid,
    required this.shortname,
    required this.subpath,
    required this.attributes,
  });

  factory ResponseRecord.fromJson(Map<String, dynamic> json) {
    return ResponseRecord(
      resourceType: ResourceType.values.byName(json['resource_type']),
      uuid: json['uuid'],
      shortname: json['shortname'],
      subpath: json['subpath'],
      attributes: ResponseRecordAttributes.fromJson(
        Map<String, dynamic>.from(json['attributes']),
      ),
    );
  }
}

class ResponseRecordAttributes {
  final bool is_active;
  Translation? displayname;
  Translation? description;
  final Set<String> tags;
  final String created_at;
  final String updated_at;
  final String owner_shortname;
  final Payload? payload;

  ResponseRecordAttributes({
    required this.is_active,
    this.displayname,
    this.description,
    required this.tags,
    required this.created_at,
    required this.updated_at,
    required this.owner_shortname,
    this.payload,
  });

  factory ResponseRecordAttributes.fromJson(Map<String, dynamic> json) {
    ResponseRecordAttributes responseRecordAttributes =
        ResponseRecordAttributes(
      is_active: json['is_active'],
      tags: Set<String>.from(json['tags'] ?? []),
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      owner_shortname: json['owner_shortname'],
      payload: json['payload'] != null
          ? Payload.fromJson(Map<String, dynamic>.from(json['payload']))
          : null,
    );

    if (json['displayname'] != null) {
      responseRecordAttributes.displayname = Translation.fromJson(
        Map<String, dynamic>.from(json['displayname']),
      );
    }

    if (json['description'] != null) {
      responseRecordAttributes.description = Translation.fromJson(
        Map<String, dynamic>.from(json['description'] ?? {}),
      );
    }

    return responseRecordAttributes;
  }
}
