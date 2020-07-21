import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lsrc/services/api.dart';

import '../constants.dart';
import '../models/notification.dart';
import '../utils/utils.dart';
import 'details.dart';

class DetailsListPage extends StatefulWidget {
  final DetailType type;

  const DetailsListPage({Key key, @required this.type}) : super(key: key);
  @override
  _DetailsListPageState createState() => _DetailsListPageState();
}

class _DetailsListPageState extends State<DetailsListPage> {
  Future _fetch;
  Completer _refreshCompleter;
  List<NotificationModel> _detailsList = [];
  bool refresh = false;

  Future fetchDetailsList(DetailType type) {
    switch (type) {
      case DetailType.notification:
        return ApiProvider.fetchNotifcations;
      case DetailType.event:
        return ApiProvider.fetchEvents;
      case DetailType.examination:
        return ApiProvider.fetchExaminations;
      default:
        return null;
    }
  }

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
    _fetch = fetchDetailsList(widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        setState(() {
          _fetch = fetchDetailsList(widget.type);
          refresh = true;
        });
        return _refreshCompleter?.future;
      },
      child: FutureBuilder(
          future: _fetch,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && !refresh)
              return Center(child: CircularProgressIndicator());
            if (snapshot.connectionState == ConnectionState.done) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer<void>();
            }
            if (snapshot.data != null) _detailsList = snapshot.data;
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                itemCount: _detailsList.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetailsPage(
                                      type: widget.type,
                                      content: _detailsList[index]
                                          ?.content
                                          ?.rendered,
                                      id: _detailsList[index].id,
                                      title:
                                          _detailsList[index]?.title?.rendered,
                                    )));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        child: Text(
                          Utils.unescapeHtml(
                              _detailsList[index]?.title?.rendered ?? ""),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ));
          }),
    );
  }
}
