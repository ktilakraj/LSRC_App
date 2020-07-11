import 'package:flutter/material.dart';
import 'package:lsrc/widgets/webview.dart';

import '../models/about.dart';
import '../services/api.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  Future _fetch;

  @override
  void initState() {
    _fetch = ApiProvider.fetchInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Center(
            child: Text(
              'About Us',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black),
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: FutureBuilder(
            future: _fetch,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              AboutModel _about = snapshot.data;
              // final _content =
              //     Utils.removeAllHtmlTags(_about?.content?.rendered ?? "");
              // return SingleChildScrollView(
              //   child: Text(
              //     _content,
              //     // style: GoogleFonts.comfortaa(),
              //   ),
              // );
              return CustomWebView(
                content: _about?.content?.rendered ?? "",
              );
            }),
      ),
    );
  }
}
