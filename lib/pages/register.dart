import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lsrc/utils/utils.dart';
import 'package:string_validator/string_validator.dart';

import '../constants.dart';
import '../models/auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<AuthModel> register(
      {String email,
      String pass,
      String name,
      String program,
      String year,
      String mobileNo}) async {
    final _response = await http.post("$authUrl/register.php", body: {
      "email": email,
      "pass": pass,
      "name": name,
      "contact": mobileNo,
      "year": year,
      "course": program
    }).catchError((e) => null);
    if (_response?.statusCode == 200) {
      return authModelFromMap(_response.body);
    }
    return null;
  }

  TextEditingController _yearController;

  String _email;
  String _pass;
  String _mobileNo;
  String _programName;
  String _name;
  String _selectedYear;
  bool loading = false;

  final _key = GlobalKey<FormState>();

  static const List<CourseDetails> _coursesList = [
    CourseDetails("JC ARTS", "JUNIOR ARTS"),
    CourseDetails("JC COM", "JUNIOR COMMERCE"),
    CourseDetails("BCOM", "BACHELOR OF COMMERCE"),
    CourseDetails("BA", "BACHELOR OF ARTS"),
    CourseDetails("BAF", "BACHELOR OF COMMERCE (ACCOUNTING & FINANCE)"),
    CourseDetails("BBI", "BACHELOR OF COMMERCE (BANKING & INSURANCE)"),
    CourseDetails("BFM", "BACHELOR OF COMMERCE (FINANCIAL MARKETS)"),
    CourseDetails("BMS", "BACHELOR OF MANAGEMENT STUDIES"),
    CourseDetails("BAMMC/BMM",
        "BACHELOR OF ARTS IN MASS MEDIA & COMMUNICATION / BACHELOR IN MASS MEDIA"),
    CourseDetails("BSC.IT", "BACHELOR OF SCIENCE IN INFORMATION TECHNOLOGY"),
    CourseDetails("MCOM ACC", "MASTER OF COMMERCE IN ACCOUNTANCY"),
    CourseDetails("MCOM B/F", "MASTER OF COMMERCE IN BANKING & FINANCE"),
    CourseDetails("MCOM BM", "MASTER OF COMMERCE IN BUSINESS MANAGEMENT"),
  ];

  List<DropdownMenuItem<String>> getItems() {
    List<DropdownMenuItem<String>> _items = [];
    for (final _course in _coursesList)
      _items
          .add(DropdownMenuItem(value: _course.id, child: Text(_course.name)));
    return _items;
  }

  void updateLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void initState() {
    _yearController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
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
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Register",
                    style: GoogleFonts.comfortaa().copyWith(fontSize: 24)),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  onSaved: (value) => _name = value,
                  validator: (value) {
                    if (value.isEmpty) return 'Enter name';
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Name',
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
                TextFormField(
                  onSaved: (value) => _pass = value,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) return 'Enter password';
                    return null;
                  },
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
                TextFormField(
                  onSaved: (value) => _mobileNo = value,
                  validator: (value) {
                    if (value.length < 8) return 'Enter valid number';
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Phone No.',
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
                  onSaved: (value) => _selectedYear = value,
                  validator: (value) {
                    if (value.length < 4) return 'Enter valid year';
                    final _year = int.parse(value);
                    if (_year < 1980 || _year > DateTime.now().year)
                      return 'Enter valid year';
                    return null;
                  },
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color:
                            Theme.of(context).errorColor, // or any other color
                      ),
                      hintText: 'Admission year',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                      )),
                      disabledBorder: OutlineInputBorder(
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
                DropdownButtonFormField<String>(
                    isExpanded: true,
                    items: getItems(),
                    value: _programName,
                    validator: (String newValue) {
                      if (newValue?.isEmpty ?? true)
                        return "Select a valid Programme";
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Select Programme',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                        )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 2,
                        ))),
                    onChanged: (value) {
                      setState(() {
                        _programName = value;
                      });
                    }),
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
                                  if (_key.currentState.validate()) {}
                                  if (_key.currentState.validate()) {
                                    updateLoading(true);
                                    _key.currentState.save();
                                    register(
                                            email: _email,
                                            pass: _pass,
                                            mobileNo: _mobileNo,
                                            name: _name,
                                            program: _programName,
                                            year: _selectedYear)
                                        .then((value) {
                                      Utils.unfocus(context);
                                      updateLoading(false);
                                      if (value == null)
                                        throw Exception("Error occured");
                                      Utils.showSnackBar(
                                          context, value.message);
                                      if (value.message ==
                                          "Registration successful")
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          Navigator.pop(context);
                                        });
                                    }).catchError((e) {
                                      updateLoading(false);
                                      Utils.showSnackBar(context,
                                          "Error occured, try again later");
                                    });
                                  }
                                },
                                child: Text(
                                  'REGISTER',
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

class CourseDetails {
  final String id;
  final String name;

  const CourseDetails(this.id, this.name);
}
