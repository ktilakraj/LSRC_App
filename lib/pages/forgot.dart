import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:string_validator/string_validator.dart';

import '../services/api.dart';
import '../utils/utils.dart';

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  String _email;
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
                Text("Forgot Password",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 24)),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onSaved: (value) => _email = value,
                  validator: (value) {
                    if (!isEmail(value)) return 'Enter valid email';
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
                                onPressed: () async {
                                  Utils.unfocus(context);
                                  if (_key.currentState.validate()) {
                                    updateLoading(true);
                                    _key.currentState.save();
                                    ApiProvider.forgotPassword(_email)
                                        .then((value) async {
                                      updateLoading(false);
                                      if (value == null)
                                        throw Exception("Error occured");
                                      Utils.showSnackBar(context, value);
                                    }).catchError((e) {
                                      updateLoading(false);
                                      Utils.showSnackBar(context,
                                          "Error occured, try again later");
                                    });
                                  }
                                },
                                child: Text(
                                  'Send Email',
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
