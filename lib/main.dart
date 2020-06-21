import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/login.dart';
import 'pages/register.dart';

void main() {
  runApp(MyApp());
}

const _defaultColor = Color(0xff071DBD);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSRC',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: _defaultColor,
          scaffoldBackgroundColor: Colors.white),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/bg.png",
                      ),
                      fit: BoxFit.fill)),
              child: Image.asset("assets/logo.png"),
            ),
          ),
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 10,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: OutlineButton(
                        color: _defaultColor,
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginPage()));
                        },
                        child: Text('LOG IN'))),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 3,
                    child: RaisedButton(
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: _defaultColor,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RegisterPage()));
                        },
                        child: Text(
                          'REGISTER',
                          style: TextStyle(color: Colors.white),
                        ))),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 10,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
