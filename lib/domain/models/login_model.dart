import 'package:dmart_android_flutter/domain/models/base/error.dart';
import 'package:dmart_android_flutter/domain/models/base/base_response.dart';
import 'package:dmart_android_flutter/domain/models/base/displayname.dart';
import 'package:dmart_android_flutter/domain/models/base/records.dart';

class LoginRequestModel {
  String msisdn;
  String password;

  LoginRequestModel({required this.msisdn, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msisdn'] = msisdn;
    data['password'] = password;
    return data;
  }
}

class LoginResponseModel extends BaseResponse {
  String? token;
  String? type;
  Displayname? displayname;
  ErrorModel? error;

  LoginResponseModel({this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if(status=="failed"){
      error = ErrorModel.fromJson(json['error']);
      return;
    }

    records = json['records'];
    if (records != null && records!.isNotEmpty) {
      Record? record = Record.fromJson(json['records'][0]);
      LoginAttributes? attribute = LoginAttributes.fromJson(record.attributes);
      token = attribute.accessToken;
      type = attribute.type;
      displayname = attribute.displayname;
    }
  }
}

class LoginAttributes {
  String? accessToken;
  String? type;
  Displayname? displayname;

  LoginAttributes({this.accessToken, this.type, this.displayname});

  LoginAttributes.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    type = json['type'];
    displayname = json['displayname'] != null
        ? Displayname.fromJson(json['displayname'])
        : null;
  }
}