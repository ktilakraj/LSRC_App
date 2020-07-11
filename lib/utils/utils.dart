import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  // static String removeAllHtmlTags(String htmlText) {
  //   RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  //   return htmlText.replaceAll(exp, '');
  // }

  static String unescapeHtml(String htmlText) {
    final unescape = new HtmlUnescape();
    return unescape.convert(htmlText);
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

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
