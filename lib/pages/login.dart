import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class LoginPage extends StatelessWidget {
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
        body: Padding(
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
                    child: RaisedButton(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(color: const Color(0xff071DBD))),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => HomePage()));
                      },
                      child: Text(
                        'LOG IN',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
