import 'package:dmart_android_flutter/domain/models/base/status.dart';
import 'package:dmart_android_flutter/domain/models/login_model.dart';
import 'package:dmart_android_flutter/domain/repositories/dmart_apis.dart';
import 'package:dmart_android_flutter/presentations/views/home_view.dart';
import 'package:dmart_android_flutter/presentations/widgets/edit_field.dart';
import 'package:dmart_android_flutter/presentations/widgets/language_change.dart';
import 'package:dmart_android_flutter/presentations/widgets/theme_switch.dart';
import 'package:dmart_android_flutter/utils/constants/regex.dart';
import 'package:dmart_android_flutter/utils/helpers/advance_text_editing_controller.dart';
import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:dmart_android_flutter/utils/helpers/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _shortnameController = AdvanceTextEditingController();
  final _passwordController = AdvanceTextEditingController();

  bool isFormValid() {
    _key.currentState?.validate();
    return _shortnameController.isValidated && _passwordController.isValidated;
  }

  List<Color> backgroundColorsLight = [
    const Color(0xB025282F),
    const Color(0xFF25282F),
  ];

  List<Color> backgroundColorsDark = [
    const Color(0xFF25282F),
    const Color(0xB025282F),
  ];

  Future<void> handleLogin() async {
    if (isFormValid()) {
      LoginResponseModel result = await DmartAPIS.login(
        LoginRequestModel(
          shortname: _shortnameController.text,
          password: _passwordController.text,
        ),
      );
      if (result.status == Status.success) {
        await GetStorage().write("token", result.token);
        Get.off(() => const HomeView());
      } else {
        Snackbars.error("Invalid credentials", result.error?.message ?? "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("theme is ${Theme.of(context).brightness}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: Theme.of(context).brightness == Brightness.dark
                  ? backgroundColorsDark
                  : backgroundColorsLight,
              stops: const [0.0, 0.95],
            ),
          ),
          padding: const EdgeInsets.all(24.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ThemeSwitch(),
                  LanguageChange(triggerUpdate: () {
                    setState(() {});
                    _key = GlobalKey<FormState>();
                  }),
                ],
              ),
              // const SizedBox(height: 8),
              Image.asset('assets/images/edraj_logo.png', scale: 1.5),
              Text(
                language["login"],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'KanunAR',
                  fontWeight: FontWeight.w300,
                  fontSize: 44.0,
                ),
              ),
              const SizedBox(height: 64),
              Form(
                key: _key,
                child: Expanded(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EditField(
                        controller: _shortnameController,
                        palceholder: language["shortname"],
                        maxLength: 10,
                        textInputAction: TextInputAction.next,
                        validationFunction: (value) {
                          if (value.isEmpty) {
                            return language["shortname_is_required"];
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      EditField(
                        controller: _passwordController,
                        palceholder: language["password"],
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        validationFunction: (value) {
                          if (value.isEmpty) {
                            return language["password_is_required"];
                          } else if (!passwordREGEX.hasMatch(value)) {
                            return language["wrong_format"];
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: handleLogin,
                          child: Text(language["login"]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
