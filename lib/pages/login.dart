import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lsrc/utils/utils.dart';

import '../constants.dart';
import '../models/auth.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<AuthModel> login(String email, String pass) async {
    final _response = await http.post("$authUrl/login.php",
        body: {"email": email, "pass": pass}).catchError((e) => null);
    if (_response?.statusCode == 200) {
      return authModelFromMap(_response.body);
    }
    return null;
  }

  String _email;
  String _pass;
  bool loading = false;
  final _key = GlobalKey<FormState>();

  void updateLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: SvgPicture.asset(
                "assets/back.svg",
                height: 16,
                width: 16,
                fit: BoxFit.fill,
              ),
              onPressed: () => Navigator.pop(context)),
          automaticallyImplyLeading: false,
          title: Text(''),
        ),
        body: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Log in",
                    style: GoogleFonts.comfortaa().copyWith(fontSize: 24)),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onSaved: (value) => _email = value,
                  validator: (value) {
                    if (value.isEmpty) return 'Enter email';
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onSaved: (value) => _pass = value,
                  validator: (value) {
                    if (value.isEmpty) return 'Enter password';
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      ))),
                ),
                SizedBox(height: 25),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Builder(
                        builder: (context) => loading
                            ? Center(child: CircularProgressIndicator())
                            : RaisedButton(
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: BorderSide(
                                        color: const Color(0xff071DBD))),
                                onPressed: () {
                                  if (_key.currentState.validate()) {
                                    updateLoading(true);
                                    _key.currentState.save();
                                    login(_email, _pass).then((value) {
                                      Utils.unfocus(context);
                                      updateLoading(false);
                                      if (value == null)
                                        throw Exception("Error occured");
                                      Utils.showSnackBar(
                                          context, value.message);
                                      if (value.userId != null)
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => HomePage()));
                                        });
                                    }).catchError((e) {
                                      updateLoading(false);
                                      Utils.showSnackBar(context,
                                          "Error occured, try again later");
                                    });
                                  }
                                },
                                child: Text(
                                  'LOG IN',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.black,
                              ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
