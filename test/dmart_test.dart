import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/utils/enums/base/user_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Login", () {
    test('success login', () async {
      LoginResponseModel response = await DmartAPIS.login(
        "dmart",
        "Password1234",
      );
      expect(response.status, Status.success);
      expect(response.type, UserType.web);
      expect(response.records?[0].shortname, "dmart");
    });
    test('failed login', () async {
      LoginResponseModel response = await DmartAPIS.login(
        "dmart",
        "Password12344",
      );
      expect(response.status, Status.failed);
      expect(response.error?.message, "Invalid username or password [2]");
      expect(response.error?.code, 14);
    });
  });
}
