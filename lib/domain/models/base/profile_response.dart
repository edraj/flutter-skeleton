import 'package:dmart_android_flutter/domain/models/base/api_response.dart';
import 'package:dmart_android_flutter/domain/models/base/error.dart';
import 'package:dmart_android_flutter/domain/models/base/permission.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/models/base/translation.dart';
import 'package:dmart_android_flutter/utils/enums/base/language.dart';

class ProfileResponse extends ApiResponse {
  final List<_ProfileResponseRecord> records;

  ProfileResponse({
    required Status status,
    ErrorModel? error,
    required this.records,
  }) : super(status: status, error: error);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json['status'] == 'success' ? Status.success : Status.failed,
      error: json['error'] != null ? ErrorModel.fromJson(json['error']) : null,
      records: (json['records'] as List<dynamic>)
          .map((record) => _ProfileResponseRecord.fromJson(record))
          .toList(),
    );
  }
}

class _ProfileResponseRecord extends ApiResponseRecord {
  @override
  final _ProfileResponseRecordAttributes attributes;

  _ProfileResponseRecord({
    required String resourceType,
    required String shortname,
    String? branchName,
    required String subpath,
    required this.attributes,
  }) : super(
          resourceType: resourceType,
          subpath: subpath,
          shortname: shortname,
        );

  factory _ProfileResponseRecord.fromJson(Map<String, dynamic> json) {
    return _ProfileResponseRecord(
      resourceType: json['resource_type'],
      shortname: json['shortname'],
      branchName: json['branch_name'],
      subpath: json['subpath'],
      attributes: _ProfileResponseRecordAttributes.fromJson(
        Map<String, dynamic>.from(json['attributes']),
      ),
    );
  }
}

class _ProfileResponseRecordAttributes {
  final String email;
  final Translation displayname;
  final String type;
  final Language language;
  final bool isEmailVerified;
  final bool isMsisdnVerified;
  final bool forcePasswordChange;
  final Map<String, Permission> permissions;

  _ProfileResponseRecordAttributes({
    required this.email,
    required this.displayname,
    required this.type,
    required this.language,
    required this.isEmailVerified,
    required this.isMsisdnVerified,
    required this.forcePasswordChange,
    required this.permissions,
  });

  factory _ProfileResponseRecordAttributes.fromJson(Map<String, dynamic> json) {
    return _ProfileResponseRecordAttributes(
      email: json['email'],
      displayname: Translation.fromJson(
        Map<String, dynamic>.from(json['displayname']),
      ),
      type: json['type'],
      language: Language.values.byName(json['language']),
      isEmailVerified: json['is_email_verified'],
      isMsisdnVerified: json['is_msisdn_verified'],
      forcePasswordChange: json['force_password_change'],
      permissions: Map<String, Permission>.from(
        json['permissions'].map(
          (key, value) => MapEntry(key, Permission.fromJson(value)),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'displayname': displayname.toJson(),
      'type': type,
      'language': language.toString(),
      'is_email_verified': isEmailVerified,
      'is_msisdn_verified': isMsisdnVerified,
      'force_password_change': forcePasswordChange,
      'permissions':
          permissions.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}
