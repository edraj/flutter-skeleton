import 'package:dmart_android_flutter/domain/models/base/displayname.dart';
import 'package:dmart_android_flutter/domain/models/base/profile/permission.dart';
import 'package:dmart_android_flutter/domain/models/base/profile/profile_response.dart';
import 'package:dmart_android_flutter/domain/models/base/request/action_reponse.dart';
import 'package:dmart_android_flutter/domain/models/base/request/action_request.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/presentations/views/login_view.dart';
import 'package:dmart_android_flutter/utils/enums/base/request_type.dart';
import 'package:dmart_android_flutter/utils/enums/base/resource_type.dart';
import 'package:dmart_android_flutter/utils/helpers/snackbars.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  String shortname = "";
  Displayname displayname = Displayname();
  String? msisdn = "";
  String? email = "";
  Map<String, dynamic>? body = {};
  Map<String, Permission> permissions = {};

  void cleanUp() {
    shortname = "";
    displayname = Displayname();
    msisdn = "";
    email = "";
    body = {};
    permissions = {};

    update();
  }

  void setupProfile(
    String shortname,
    Displayname displayName,
    String? msisdn,
    String? email,
    Map<String, dynamic>? profileBody,
    Map<String, Permission> userPermissions,
  ) {
    this.shortname = shortname;
    this.displayname = displayName;
    this.msisdn = msisdn;
    this.email = email;
    this.body = profileBody;
    this.permissions = userPermissions;

    update();
  }

  Future<void> getProfile() async {
    ProfileResponse? profileResponse = await DmartAPIS.getProfile();

    if (profileResponse == null) {
      Get.off(() => const LoginView());
      return;
    }
    var attributes = profileResponse.records?[0].attributes;
    if (profileResponse.records?[0] == null || attributes == null) {
      Get.off(const LoginView());
      return;
    }

    setupProfile(
      profileResponse.records?[0].shortname ?? "",
      attributes.displayname,
      attributes.msisdn,
      attributes.email,
      attributes.payload,
      attributes.permissions,
    );
  }

  Future<void> updateProfile(
      String shortname, Map<String, dynamic> userAttributes) async {
    ActionRequestRecord actionRequestRecord = ActionRequestRecord(
      shortname: shortname,
      resourceType: ResourceType.user,
      subpath: "users",
      attributes: userAttributes,
    );
    ActionRequest actionRequest = ActionRequest(
      spaceName: "management",
      requestType: RequestType.update,
      records: [actionRequestRecord],
    );
    ActionResponse? result = await DmartAPIS.request(actionRequest);

    if (result == null) {
      Snackbars.error(
        "Can't update the profile.",
        result?.error?.message ?? "",
      );
    } else {
      Snackbars.success("Updated Successfully", "");
      await getProfile();
    }
  }

  Future<void> logout() async {
    await DmartAPIS.logout();
    await GetStorage().remove("token");
    cleanUp();
    Get.off(() => const LoginView());
  }
}
