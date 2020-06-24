import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lsrc/constants.dart';
import 'package:lsrc/utils/utils.dart';
import '../models/notification.dart';
import 'details.dart';

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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DetailsPage(
                                    content: _notifications[index]
                                        ?.content
                                        ?.rendered,
                                    title:
                                        _notifications[index]?.title?.rendered,
                                  )));
                    },
                    leading: Image.asset("assets/notification.png"),
                    title: Text(_notifications[index]?.title?.rendered ?? ""),
                    // subtitle: Text(Utils.removeAllHtmlTags(
                    //     _notifications[index].content.rendered)),
                  ));
        });
  }
}
