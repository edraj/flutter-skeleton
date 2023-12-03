import 'package:dmart_android_flutter/domain/controllers/user_controller.dart';
import 'package:dmart_android_flutter/presentations/views/register_view.dart';
import 'package:dmart_android_flutter/presentations/widgets/edit_field.dart';
import 'package:dmart_android_flutter/presentations/widgets/language_change.dart';
import 'package:dmart_android_flutter/presentations/widgets/theme_switch.dart';
import 'package:dmart_android_flutter/utils/constants/regex.dart';
import 'package:dmart_android_flutter/utils/helpers/advance_text_editing_controller.dart';
import 'package:dmart_android_flutter/utils/helpers/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  UserController userController = Get.put(UserController());

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
      await userController.login(
        _shortnameController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
                  Get.isDarkMode ? backgroundColorsDark : backgroundColorsLight,
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
                    return null;
                  }),
                ],
              ),
              // const SizedBox(height: 8),
              Image.asset('assets/images/edraj_logo.png', scale: 1.5),
              Text(
                language["login"],
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'IBMPlexSansArabic',
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
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: ElevatedButton(
                          onPressed: handleLogin,
                          child: Text(language["login"],
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => const RegisterView());
                  },
                  child: Text(language["register"],
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
