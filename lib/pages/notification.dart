import 'package:flutter/material.dart';

import '../models/notification.dart';
import '../services/api.dart';
import '../utils/utils.dart';
import 'details.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future _fetch;

  @override
  void initState() {
    _fetch = ApiProvider.fetchNotifcations;
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
          return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
              itemCount: _notifications.length,
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DetailsPage(
                                    content: _notifications[index]
                                        ?.content
                                        ?.rendered,
                                    id: _notifications[index].id,
                                    title:
                                        _notifications[index]?.title?.rendered,
                                  )));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 2),

                      // leading: Image.asset("assets/notification.png"),
                      child: Text(
                        Utils.unescapeHtml(
                            _notifications[index]?.title?.rendered ?? ""),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      // subtitle: Text(Utils.removeAllHtmlTags(
                      //     _notifications[index].content.rendered)),
                    ),
                  ));
        });
  }
}
