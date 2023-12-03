import 'package:dmart_android_flutter/domain/models/base/displayname.dart';
import 'package:dmart_android_flutter/domain/models/base/profile/permission.dart';
import 'package:dmart_android_flutter/domain/models/base/request/action_request.dart';
import 'package:dmart_android_flutter/domain/models/create_user_model.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/presentations/views/home_view/index.dart';
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

  Future<void> login(String shortname, String password) async {
    LoginRequestModel loginRequestModel = LoginRequestModel(
      shortname: shortname,
      password: password,
    );
    var (response, error) = await DmartAPIS.login(loginRequestModel);
    if (response != null) {
      await GetStorage().write("token", response.token);
      Get.off(() => const HomeView());
    } else {
      Snackbars.error("Invalid credentials", error?.message ?? "");
    }
  }

  Future<void> register(CreateUserAttributes attributes) async {
    CreateUserRequestModel createUserRequestModel =
        CreateUserRequestModel(attributes: attributes);
    var (response, error) = await DmartAPIS.createUser(createUserRequestModel);
    if (response != null) {
      Snackbars.success("Account Created", "");
      Get.off(() => const LoginView());
    } else {
      Snackbars.error("Something went wrong", error?.message ?? "");
    }
  }

  void _cleanUp() {
    shortname = "";
    displayname = Displayname();
    msisdn = "";
    email = "";
    body = {};
    permissions = {};

    update();
  }

  void _setupProfile(
    String shortname,
    Displayname displayName,
    String? msisdn,
    String? email,
    Map<String, dynamic>? profileBody,
    Map<String, Permission> userPermissions,
  ) {
    this.shortname = shortname;
    displayname = displayName;
    this.msisdn = msisdn;
    this.email = email;
    body = profileBody;
    permissions = userPermissions;

    update();
  }

  Future<void> getProfile() async {
    var (profileResponse, _) = await DmartAPIS.getProfile();

    if (profileResponse == null) {
      Get.off(() => const LoginView());
      return;
    }
    var attributes = profileResponse.records?[0].attributes;
    if (profileResponse.records?[0] == null || attributes == null) {
      Get.off(const LoginView());
      return;
    }

    _setupProfile(
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
    var (result, error) = await DmartAPIS.request(actionRequest);

    if (result == null) {
      Snackbars.error(
        "Can't update the profile.",
        error?.message ?? "",
      );
    } else {
      Snackbars.success("Updated Successfully", "");
      await getProfile();
    }
  }

  Future<void> logout() async {
    await DmartAPIS.logout();
    await GetStorage().remove("token");
    _cleanUp();
    Get.off(() => const LoginView());
  }
}
