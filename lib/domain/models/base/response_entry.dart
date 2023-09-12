import 'package:dmart_android_flutter/domain/models/base/meta_extended.dart';
import 'package:dmart_android_flutter/domain/models/base/payload.dart';
import 'package:dmart_android_flutter/domain/models/base/translation.dart';

class ResponseEntry extends MetaExtended {
  final String uuid;
  final String shortname;
  final String subpath;
  final bool is_active;
  final Translation displayname;
  final Translation description;
  final Set<String> tags;
  final String created_at;
  final String updated_at;
  final String owner_shortname;
  final Payload? payload;
  final Map<String, dynamic>? attachments;
  final String workflow_shortname;
  final String state;

  ResponseEntry({
    required String email,
    required String msisdn,
    required bool is_email_verified,
    required bool is_msisdn_verified,
    required bool force_password_change,
    required String password,
    required bool is_open,
    required this.uuid,
    required this.shortname,
    required this.subpath,
    required this.is_active,
    required this.displayname,
    required this.description,
    required this.tags,
    required this.created_at,
    required this.updated_at,
    required this.owner_shortname,
    this.payload,
    this.attachments,
    required this.workflow_shortname,
    required this.state,
  }) : super(
    email: email,
    msisdn: msisdn,
    is_email_verified: is_email_verified,
    is_msisdn_verified: is_msisdn_verified,
    force_password_change: force_password_change,
    password: password,
    workflow_shortname: workflow_shortname,
    state: state,
    is_open: is_open,
  );

  factory ResponseEntry.fromJson(Map<String, dynamic> json) {
    return ResponseEntry(
      email: json['email'],
      msisdn: json['msisdn'],
      is_email_verified: json['is_email_verified'],
      is_msisdn_verified: json['is_msisdn_verified'],
      force_password_change: json['force_password_change'],
      password: json['password'],
      workflow_shortname: json['workflow_shortname'],
      state: json['state'],
      is_open: json['is_open'],
      uuid: json['uuid'],
      shortname: json['shortname'],
      subpath: json['subpath'],
      is_active: json['is_active'],
      displayname: Translation.fromJson(
        Map<String, dynamic>.from(json['displayname']),
      ),
      description: Translation.fromJson(
        Map<String, dynamic>.from(json['description']),
      ),
      tags: Set<String>.from(json['tags'] ?? []),
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      owner_shortname: json['owner_shortname'],
      payload: json['payload'] != null
          ? Payload.fromJson(Map<String, dynamic>.from(json['payload']))
          : null,
      attachments: json['attachments'] != null
          ? Map<String, dynamic>.from(json['attachments'])
          : null,
    );
  }
}
