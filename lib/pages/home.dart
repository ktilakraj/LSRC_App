import 'package:flutter/material.dart';
import 'package:lsrc/pages/about.dart';
import 'package:lsrc/pages/event.dart';
import 'package:lsrc/pages/notification.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _bucket = PageStorageBucket();

  Widget getPage(int index) {
    switch (index) {
      case 0:
      case 2:
        final _index = index == 0 ? 0 : 1;
        return _NoticeTabPage(
          index: _index,
          key: ValueKey(_index),
        );
      case 3:
        return AboutUsPage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(bucket: _bucket, child: getPage(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).primaryColor),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          // selectedLabelStyle: TextStyle(color: Colors.black),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_library),
              title: Text(
                'Courses',
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.event),
                title: Text(
                  'Events',
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.info),
                title: Text(
                  'About',
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile')),
          ],
        ));
  }
}

class _NoticeTabPage extends StatefulWidget {
  final int index;

  const _NoticeTabPage({Key key, this.index}) : super(key: key);
  @override
  __NoticeTabPageState createState() => __NoticeTabPageState();
}

class __NoticeTabPageState extends State<_NoticeTabPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    _controller = TabController(
      length: 2,
      initialIndex: widget.index,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar:
        body: Column(
          children: <Widget>[
            Container(
              height: 40,
              color: Colors.grey[300],
              child: TabBar(
                labelColor: Colors.black,
                controller: _controller,
                labelStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(color: Colors.white),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    text: 'Notice Board',
                  ),
                  Tab(
                    text: 'Events',
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                    controller: _controller,
                    children: [NotificationPage(), EventPage()]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
