import 'package:dmart_android_flutter/utils/enums/base/content_type.dart';
import 'package:dmart_android_flutter/utils/enums/base/validation_status.dart';

class Payload {
  final ContentType content_type;
  final String? schema_shortname;
  final String? checksum;
  final dynamic body; // Can be String or Map<String, dynamic>
  final String? last_validated;
  ValidationStatus? validation_status = null;

  Payload({
    required this.content_type,
    this.schema_shortname,
    required this.checksum,
    required this.body,
    required this.last_validated,
    this.validation_status,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    Payload payload = Payload(
      content_type: ContentType.values.byName(json['content_type']),
      schema_shortname: json['schema_shortname'],
      checksum: json['checksum'],
      body: json['body'],
      last_validated: json['last_validated'],
    );
    if (json['validation_status'] != null) {
      payload.validation_status = ValidationStatus.values.byName(
        json['validation_status'],
      );
    }

    return payload;
  }
}
