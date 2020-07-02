// import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lsrc/utils/utils.dart';

class DetailsPage extends StatefulWidget {
  final String content;
  final String title;

  const DetailsPage({Key key, this.content, this.title}) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  InAppWebViewController webView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: SvgPicture.asset(
              "assets/back.svg",
              height: 16,
              width: 16,
              fit: BoxFit.fill,
            ),
            onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          Center(
            child: Text(
              'Notice Board',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black),
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 5),
            child: Text(
              widget?.title ?? "",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
              // child: EasyWebView(
              //   src: widget.content,
              //   isHtml: true, widgetsTextSelectable: true,
              //   onLoaded: () {},
              //   // style: GoogleFonts.comfortaa(),
              // ),
              child: InAppWebView(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
