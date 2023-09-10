class ErrorModel {
  String? type;
  int? code;
  String? message;
  List<Map<String, dynamic>>? info;

  ErrorModel({this.type, this.code, this.message, this.info});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    code = json['code'];
    message = json['message'];
    print(json['info']);
    info = json['info'];
  }
}