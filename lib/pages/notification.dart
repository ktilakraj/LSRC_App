import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lsrc/constants.dart';
import '../models/notification.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<List<NotificationModel>> get fetchNotifcations async {
    final _response =
        await http.get("$baseUrl?categories=41").catchError((e) => null);
    if (_response?.statusCode == 200) {
      return notificationApiModelFromMap(_response.body);
    }
    return null;
  }

  Future _fetch;

  @override
  void initState() {
    _fetch = fetchNotifcations;
    super.initState();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetch,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          List<NotificationModel> _notifications = snapshot.data ?? [];
          return ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (context, index) => ListTile(
                    leading: Image.asset("assets/notification.png"),
                    title: Text(_notifications[index].title.rendered),
                    // subtitle: Text(removeAllHtmlTags(
                    //     _notifications[index].content.rendered)),
                  ));
        });
  }
}
