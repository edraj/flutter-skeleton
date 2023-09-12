import 'package:dmart_android_flutter/utils/enums/base/content_type.dart';
import 'package:dmart_android_flutter/utils/enums/base/validation_status.dart';

class Payload {
  final ContentType content_type;
  final String? schema_shortname;
  final String checksum;
  final dynamic body; // Can be String or Map<String, dynamic>
  final String last_validated;
  final ValidationStatus validation_status;

  Payload({
    required this.content_type,
    this.schema_shortname,
    required this.checksum,
    required this.body,
    required this.last_validated,
    required this.validation_status,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      content_type: ContentType.values.byName(json['content_type']),
      schema_shortname: json['schema_shortname'],
      checksum: json['checksum'],
      body: json['body'], // This assumes 'body' can be both String or Map
      last_validated: json['last_validated'],
      validation_status: ValidationStatus.values.byName(json['validation_status']),
    );
  }
}


