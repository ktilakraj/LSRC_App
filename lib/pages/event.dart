import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/event.dart';
import 'details.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Future<List<EventModel>> get fetchEvents async {
    final _response =
        await http.get("$baseUrl?categories=42").catchError((e) => null);
    if (_response?.statusCode == 200) {
      return eventModelFromMap(_response.body);
    }
    return null;
  }

  Future _fetch;

  @override
  void initState() {
    _fetch = fetchEvents;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetch,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          List<EventModel> _events = snapshot.data ?? [];
          return ListView.builder(
              itemCount: _events.length,
              itemBuilder: (context, index) => ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailsPage(
                                  content: _events[index]?.content?.rendered,
                                  title: _events[index]?.title?.rendered,
                                ))),
                    leading: Image.asset("assets/notification.png"),
                    title: Text(_events[index].title.rendered),
                    // subtitle: Text(removeAllHtmlTags(
                    //     _notifications[index].content.rendered)),
                  ));
        });
  }
}
