import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static void showSnackBar(BuildContext context, String message) {
    final _snack = SnackBar(
      content: Text(
        message ?? "",
        // style: GoogleFonts.comfortaa(),
      ),
      duration: const Duration(seconds: 2),
    );
    Scaffold.of(context).showSnackBar(_snack);
  }

  static void unfocus(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
