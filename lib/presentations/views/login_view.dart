import 'package:dmart_android_flutter/domain/controllers/authentication_controller.dart';
import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/presentations/views/home_view.dart';
import 'package:dmart_android_flutter/presentations/widgets/edit_field.dart';
import 'package:dmart_android_flutter/utils/constants/language_change_svg.dart';
import 'package:dmart_android_flutter/utils/constants/regex.dart';
import 'package:dmart_android_flutter/utils/helpers/advance_text_editing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = Get.put(AuthenticationController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _shortnameController = AdvanceTextEditingController();
  final _passwordController = AdvanceTextEditingController();

  bool isFormValid() {
    _key.currentState?.validate();
    return _shortnameController.isValidated && _passwordController.isValidated;
  }

  Future<void> handleLogin() async {
    if (isFormValid()) {
      LoginResponseModel result = await _controller.login(
        _shortnameController.text,
        _passwordController.text,
      );
      if (result.status == Status.success) {
        _controller.saveToken(result.token!);
        Get.to(const HomeView());
      } else {
        Get.snackbar(
          "Invalid cred",
          result.error?.message ?? "",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
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
                      controller: _shortnameController,
                      palceholder: 'shortname',
                      maxLength: 10,
                      validationFunction: (value) {
                        if (value.isEmpty) {
                          return 'shortname is required.';
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
        ),
      ),
    );
  }
}
