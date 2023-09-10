import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget languageChangeSVG(){
  return SvgPicture.asset(
    'assets/images/lang.svg',
    semanticsLabel: 'Language change',
    height: 32, width: 32,
  );
}