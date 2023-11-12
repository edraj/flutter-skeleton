import 'dart:ffi';

import 'package:dmart_android_flutter/presentations/views/language_change_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LanguageChange extends StatefulWidget {
  Void? Function()? triggerUpdate;

  LanguageChange({
    super.key,
    required this.triggerUpdate,
  });

  @override
  State<LanguageChange> createState() => _LanguageChangeState();
}

class _LanguageChangeState extends State<LanguageChange> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.to(() => const LanguageChangeView());
        widget.triggerUpdate!();
      },
      child: SvgPicture.asset(
        'assets/images/lang.svg',
        semanticsLabel: 'Language change',
        height: 32,
        width: 32,
      ),
    );
  }
}
