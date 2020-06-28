import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  final String content;
  final String title;

  const DetailsPage({Key key, this.content, this.title}) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
      body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Column(
            children: <Widget>[
              Text(
                widget?.title ?? "",
                // style: GoogleFonts.comfortaa(
                //     textStyle: Theme.of(context).textTheme.headline6),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                  child: EasyWebView(
                    src: widget.content,
                    isMarkdown: true,
                    onLoaded: () {},
                    // style: GoogleFonts.comfortaa(),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
