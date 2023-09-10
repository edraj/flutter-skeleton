import 'package:dmart_android_flutter/domain/models/base/records.dart';

class BaseResponse {
  String? status;
  List<Record>? records;

  BaseResponse({this.status, this.records});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['records'] != null) {
      records = <Record>[];
      json['records'].forEach((v) {
        records!.add(Record.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}