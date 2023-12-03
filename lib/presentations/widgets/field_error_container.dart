import 'package:flutter/widgets.dart';

class FieldErrorContainer extends StatelessWidget {
  final String message;

  const FieldErrorContainer({super.key, this.message = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: const Color(0xFFF55858),
        ),
        color: const Color(0xFFFFF2F2),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'IBMPlexSansArabic',
              // Assuming you have imported the custom font
              fontWeight: FontWeight.w500,
              color: Color(0xFFF55858),
            ),
          ),
        ],
      ),
    );
  }
}
