import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dmart_android_flutter/domain/controllers/authentication_controller.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/presentations/widgets/edit_field.dart';
import 'package:dmart_android_flutter/utils/constants/language_change_svg.dart';
import 'package:get/get.dart';
import 'package:dmart_android_flutter/utils/constants/regex.dart';
import 'package:dmart_android_flutter/utils/helpers/advance_text_editing_controller.dart';
import 'package:dmart_android_flutter/utils/constants/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = Get.put(AuthenticationController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _msisdnController = AdvanceTextEditingController();
  final _passwordController = AdvanceTextEditingController();

  bool isFormValid() {
    _key.currentState?.validate();
    return _msisdnController.isValidated && _passwordController.isValidated;
  }

  void handleLogin() {
    if (isFormValid()) {
      _controller.login(LoginRequestModel(
        msisdn: _msisdnController.text,
        password: _passwordController.text,
      ));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF57CDC6), // #57CDC6 in CSS
            Color(0xFF3393E2), // #3393E2 in CSS
          ],
          stops: [0.0, 0.9062], // 0% and 90.62% in CSS
        ),
      ),
      padding: const EdgeInsets.all(24.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              languageChangeSVG(),
            ],
          ),
          const SizedBox(height: 20),
          SvgPicture.asset(
            'assets/images/login/logo.svg',
            semanticsLabel: 'Logo',
            height: 63,
            width: 208,
          ),
          const SizedBox(height: 32),
          const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'KanunAR',
              fontWeight: FontWeight.w300,
              fontSize: 22.0,
            ),
          ),
          const SizedBox(height: 32),
          Form(
            key: _key,
            child: Column(
              children: [
                EditField(
                  controller: _msisdnController,
                  palceholder: 'MSISDN',
                  maxLength: 10,
                  prefix: SizedBox(
                    width: 64,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          right:
                              BorderSide(color: secondaryColor ?? Colors.grey),
                        )),
                        padding: const EdgeInsets.only(right: 8),
                        margin: const EdgeInsets.only(right: 8),
                        child: const Text(
                          "+964",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'KanunAR',
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  validationFunction: (value) {
                    if (value.isEmpty) {
                      print("err MSISDN");
                      return 'MSISDN is required.';
                    } else if (!msisdnREGEX.hasMatch(value)) {
                      return 'Wrong format.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                EditField(
                  controller: _passwordController,
                  palceholder: 'Password',
                  obscureText: true,
                  validationFunction: (value) {
                    if (value.isEmpty) {
                      print("err Password");
                      return 'Password is required.';
                    } else if (!passwordREGEX.hasMatch(value)) {
                      return 'Wrong format.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(onPressed: handleLogin, child: const Text("Login"))
        ],
      ),
    );
  }
}
