import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' show parse;
// import 'package:html/dom.dart';

import '../constants.dart';
import '../models/course.dart';
import '../utils/utils.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  Future<CourseModel> get fetchCourses async {
    final _response = await http.get("$baseUrl/3361").catchError((e) => null);
    if (_response?.statusCode == 200) {
      return courseModelFromMap(_response.body);
    }
    return null;
  }

  Future _fetch;

  @override
  void initState() {
    _fetch = fetchCourses;
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
              'Courses',
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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: FutureBuilder(
            future: _fetch,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              CourseModel _course = snapshot.data;
              final _content = _course?.content?.rendered ?? "";
              return Column(
                children: <Widget>[
                  Text(
                    _course?.title?.rendered ?? "",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Expanded(
                    child: EasyWebView(
                      src: _content,
                      isMarkdown: true,
                      onLoaded: () {},
                      // style: GoogleFonts.comfortaa(),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
