import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'services/hive.dart';

void main() async {
  final _loggedIn = await UserProvider.isLoggedIn;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runZonedGuarded(
      () async => runApp(MyApp(
            loggedIn: _loggedIn,
          )),
      Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  const MyApp({Key key, this.loggedIn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'L. S. Raheja College of Arts & Commerce',
      theme: ThemeData(
          textTheme: GoogleFonts.comfortaaTextTheme(
            Theme.of(context).textTheme,
          ),
          brightness: Brightness.light,
          buttonColor: defaultColor,
          primaryColor: defaultColor,
          accentColor: defaultColor,
          scaffoldBackgroundColor: Colors.white),
      home: loggedIn ? HomePage() : SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/bg.jpg",
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
                        color: defaultColor,
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
                        color: defaultColor,
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
