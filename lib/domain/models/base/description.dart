class Description {
  String? en;
  String? ar;
  String? kd;

  Description({this.en, this.ar, this.kd});

  Description.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
    kd = json['kd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    data['kd'] = kd;
    return data;
  }
}