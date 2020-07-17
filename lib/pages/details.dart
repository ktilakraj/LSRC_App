// import 'package:easy_web_view/easy_web_view.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart';
import 'package:lsrc/models/notification.dart';
import 'package:lsrc/services/api.dart';
// import 'package:pdf_flutter/pdf_flutter.dart';

import '../utils/utils.dart';
import '../widgets/webview.dart';

class DetailsPage extends StatefulWidget {
  final String content;
  final String title;
  final int id;

  const DetailsPage({Key key, this.content, this.title, this.id})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future _fetch;
  @override
  void initState() {
    _fetch = ApiProvider.fetchDetails(widget.id);
    super.initState();
  }

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
              Utils.unescapeHtml(widget.title ?? ""),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            child: FutureBuilder(
                future: _fetch,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  final NotificationModel _model =
                      snapshot.data ?? NotificationModel();
                  if (_model.content?.rendered?.isNotEmpty ?? false) {
                    var document = parse(_model.content.rendered);
                    final _list = document.getElementsByTagName("embed");
                    if (_list.isNotEmpty) {
                      final _link = _list[0].attributes["src"];
                      if (_link.contains(".pdf"))
                        return Center(
                            child: _PDFWidget(
                          url: _link,
                        ));
                    }
                  }
                  if (_model.link?.contains(".pdf") ?? false) {
                    return Center(
                      child: _PDFWidget(url: _model.link),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                    // child: EasyWebView(
                    //   src: widget.content,
                    //   isHtml: true, widgetsTextSelectable: true,
                    //   onLoaded: () {},
                    //   // style: GoogleFonts.comfortaa(),
                    // ),
                    child: CustomWebView(
                      content: _model?.content?.rendered ?? '',
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _PDFWidget extends StatefulWidget {
  final String url;

  const _PDFWidget({Key key, this.url}) : super(key: key);
  @override
  __PDFWidgetState createState() => __PDFWidgetState();
}

class __PDFWidgetState extends State<_PDFWidget> {
  Future _fetchFile;
  PDFDocument document;
  Future<PDFDocument> fetchFile(String url) async {
    return await PDFDocument.fromURL(url);
  }

  @override
  void initState() {
    _fetchFile = fetchFile(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _fetchFile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.data != null) document = snapshot.data;
          return Visibility(
            visible: document != null,
            child: PDFViewer(
              showPicker: false,
              document: document,
            ),
          );
        });
  }
}
