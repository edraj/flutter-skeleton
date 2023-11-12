import 'package:dmart_android_flutter/domain/models/base/response_entry.dart';
import 'package:dmart_android_flutter/domain/models/base/retrieve_entry_request.dart';
import 'package:dmart_android_flutter/domain/models/easer_arabic.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/utils/enums/base/resource_type.dart';
import 'package:dmart_android_flutter/utils/helpers/snackbars.dart';
import 'package:get/get.dart';

class EserArabicDetailController extends GetxController {
  late Rx<ResponseEntry?> record = Rx<ResponseEntry?>(null);
  Rx<bool> isLoading = true.obs;
  Rx<EserArabic?> poetry = Rx<EserArabic?>(null);

  final String shortname;

  EserArabicDetailController(this.shortname);

  void loadRecord() async {
    isLoading.value = true;
    update();

    try {
      RetrieveEntryRequest request = RetrieveEntryRequest(
          spaceName: "eser",
          subpath: "arabic",
          shortname: shortname,
          retrieveJsonPayload: true,
          retrieveAttachments: true,
          resourceType: ResourceType.content);
      ResponseEntry response = await DmartAPIS.retrieveEntry(request);
      poetry.value = EserArabic.fromJson(response.payload?.body);
      record.value = response;
    } on Exception catch (e) {
      Snackbars.error("Fetch Error!", "Unable to fetch home items.");
    }

    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadRecord();
  }
}
