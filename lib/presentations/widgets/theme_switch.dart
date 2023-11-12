import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  void switchTheme() {
    Get.changeTheme(
      Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => switchTheme(),
      child: Icon(
        Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
