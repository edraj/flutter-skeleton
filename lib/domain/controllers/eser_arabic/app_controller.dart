import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  Future<void> showGreeting(BuildContext context) async {
    // QueryRequest query = QueryRequest(
    //   resourceType: ResourceType.content,
    //   spaceName: SPACES.applications.name,
    //   subpath: 'configurations',
    //   shortname: 'greeting',
    // );
    // var (response, _) = await DmartAPIS.publicQuery(query);
    // if (response == null) {
    //   return;
    // }

    // Map<String, String> body = response.records[0].attributes.payload?.body;
    // showBasicDialog(context, body["title"]!, body["message"]!);
  }
}
