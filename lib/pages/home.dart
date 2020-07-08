import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lsrc/pages/about.dart';
import 'package:lsrc/pages/course.dart';
import 'package:lsrc/pages/event.dart';
import 'package:lsrc/pages/notification.dart';
import 'package:lsrc/pages/profile.dart';

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
        return _NoticeTabPage();
      case 1:
        return CoursePage();
      case 2:
        return AboutUsPage();
      case 3:
        return ProfilePage();
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
          selectedItemColor: Color(0xffdc5013),
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xff071dbd),
          type: BottomNavigationBarType.fixed,
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
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.event),
            //     title: Text(
            //       'Events',
            //     )),
            BottomNavigationBarItem(
                icon: Icon(Icons.school),
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
      initialIndex: widget.index ?? 0,
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
              height: 50,
              color: Colors.grey[300],
              child: TabBar(
                labelColor: Colors.black,
                controller: _controller,
                labelStyle: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(color: Colors.white),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.white,
                indicatorWeight: 0,
                tabs: <Widget>[
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(LineIcons.bullhorn),
                        SizedBox(width: 10),
                        Text('Notice Board')
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.event),
                        SizedBox(width: 10),
                        Text('Events')
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
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
