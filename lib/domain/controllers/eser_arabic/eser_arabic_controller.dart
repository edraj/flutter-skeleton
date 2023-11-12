import 'package:dmart_android_flutter/domain/models/base/query/query_request.dart';
import 'package:dmart_android_flutter/domain/models/base/query/query_response.dart';
import 'package:dmart_android_flutter/domain/models/base/query/response_record.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/utils/enums/base/query_type.dart';
import 'package:dmart_android_flutter/utils/enums/base/sort_type.dart';
import 'package:dmart_android_flutter/utils/helpers/snackbars.dart';
import 'package:get/get.dart';

class EserArabicController extends GetxController {
  late RxList<ResponseRecord> records = <ResponseRecord>[].obs;
  Rx<bool> isLoading = true.obs;

  void loadItems() async {
    isLoading.value = true;
    update();

    try {
      QueryRequest query = QueryRequest(
        spaceName: "eser",
        subpath: "arabic",
        type: QueryType.search,
        search: '',
        exactSubpath: true,
        sortBy: "created_at",
        sortType: SortyType.ascending,
      );
      ApiQueryResponse response = await DmartAPIS.query(query);
      if (response.status == Status.success) {
        records.value = response.records;
      } else {
        Snackbars.error("Fetch Error!", "Unable to fetch home items.");
      }
    } catch (e) {}

    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }
}
