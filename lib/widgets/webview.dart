import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../utils/utils.dart';

class CustomWebView extends StatefulWidget {
  final String content;

  const CustomWebView({Key key, this.content}) : super(key: key);

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      shouldOverrideUrlLoading: (controller, request) async {
        Utils.launchURL(request.url);
        return ShouldOverrideUrlLoadingAction.CANCEL;
      },
      initialData: InAppWebViewInitialData(data: widget.content),
      initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(textZoom: 250),
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            debuggingEnabled: true,
          )),
      onWebViewCreated: (InAppWebViewController controller) {
        webView = controller;
      },
    );
  }
}
