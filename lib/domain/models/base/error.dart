class ErrorModel {
  String? type;
  int? code;
  String? message;
  List<Map<String, dynamic>>? info;

  ErrorModel({
    this.type,
    this.code,
    this.message,
    this.info,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      type: json['type'],
      code: json['code'],
      message: json['message'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'code': code,
      'message': message,
      'info': info,
    };
  }
}
