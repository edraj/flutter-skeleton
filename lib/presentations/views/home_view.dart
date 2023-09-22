import 'package:dmart_android_flutter/domain/controllers/authentication_controller.dart';
import 'package:dmart_android_flutter/domain/models/base/profile_response.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String username = "";

  Future<void> getCurrentUserProfile() async {
    ProfileResponse? result = await DmartAPIS.getProfile();
    setState(() {
      username = result?.records[0].attributes.displayname.en ?? "";
    });
  }

  @override
  void initState() {
    super.initState();

    getCurrentUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: const Color(0xFF008dff),
          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.center,
          child: Center(
            child: Text(
              "Welcome\n$username",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'KanunAR',
                fontWeight: FontWeight.w300,
                fontSize: 56.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
