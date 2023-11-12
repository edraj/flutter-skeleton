class MetaExtended {
  final String? email;
  final String? msisdn;
  final bool? is_email_verified;
  final bool? is_msisdn_verified;
  final bool? force_password_change;
  final String? password;
  final String? workflow_shortname;
  final String? state;
  final bool? is_open;

  MetaExtended({
    this.email,
    this.msisdn,
    this.is_email_verified,
    this.is_msisdn_verified,
    this.force_password_change,
    this.password,
    this.workflow_shortname,
    this.state,
    this.is_open,
  });

  factory MetaExtended.fromJson(Map<String, dynamic> json) {
    return MetaExtended(
      email: json['email'],
      msisdn: json['msisdn'],
      is_email_verified: json['is_email_verified'],
      is_msisdn_verified: json['is_msisdn_verified'],
      force_password_change: json['force_password_change'],
      password: json['password'],
      workflow_shortname: json['workflow_shortname'],
      state: json['state'],
      is_open: json['is_open'],
    );
  }
}
