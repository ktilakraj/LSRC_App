import 'package:flutter/material.dart';

import '../constants.dart';
import '../main.dart';
import '../models/profile.dart';
import '../services/api.dart';
import '../services/hive.dart';
import '../utils/utils.dart';
import '../widgets/courses.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future _fetch;
  TextEditingController _yearController;

  String _mobileNo;
  String _programName;
  String _name;
  String _selectedYear;
  bool loading = false;
  bool edit = false;

  final _key = GlobalKey<FormState>();

  void updateLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  void updateEdit(bool value) {
    setState(() {
      edit = value;
    });
  }

  void fetch() => _fetch = ApiProvider.fetchProfile;

  @override
  void initState() {
    fetch();
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
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Center(
            child: Text(
              'Profile',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black),
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => Visibility(
          visible: !loading,
          replacement: CircularProgressIndicator(),
          child: FloatingActionButton(
            onPressed: !edit
                ? () {
                    updateEdit(true);
                  }
                : () {
                    if (_key.currentState.validate()) {
                      updateLoading(true);
                      _key.currentState.save();
                      ApiProvider.editProfile(
                              contact: _mobileNo,
                              name: _name,
                              course: _programName,
                              year: _selectedYear)
                          .then((value) {
                        Utils.unfocus(context);
                        updateLoading(false);
                        if (value == null) throw Exception("Error occured");
                        Utils.showSnackBar(context, value.message);
                        if (value.code == 200) {
                          fetch();
                          updateEdit(false);
                        }
                      }).catchError((e) {
                        updateLoading(false);
                        Utils.showSnackBar(
                            context, "Error occured, try again later");
                      });
                    }
                  },
            child: Icon(edit ? Icons.save : Icons.edit),
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
            future: _fetch,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              ProfileModel _profile = snapshot.data;
              if (_profile == null) return Text('Unable to fetch Profile');
              _yearController.text = _profile?.studAdmYear;
              return Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            Row(
                              children: [
                                Container(width: 100, child: Text('Name')),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: _profile?.studName,
                                    onSaved: (value) => _name = value,
                                    validator: (value) {
                                      if (value.isEmpty) return 'Enter name';
                                      return null;
                                    },
                                    enabled: edit,
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
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text('Contact'),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onSaved: (value) => _mobileNo = value,
                                    validator: (value) {
                                      if (value.length < 8)
                                        return 'Enter valid number';
                                      return null;
                                    },
                                    initialValue: _profile?.studContact,
                                    enabled: edit,
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
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text('Year'),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onSaved: (value) => _selectedYear = value,
                                    validator: (value) {
                                      if (value.length < 4)
                                        return 'Enter valid year';
                                      final _year = int.parse(value);
                                      if (_year < 1980 ||
                                          _year > DateTime.now().year)
                                        return 'Enter valid year';
                                      return null;
                                    },
                                    enabled: edit,
                                    controller: _yearController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        errorStyle: TextStyle(
                                          color: Theme.of(context)
                                              .errorColor, // or any other color
                                        ),
                                        hintText: 'Admission year',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          width: 2,
                                        )),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          width: 2,
                                        ))),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CoursesDropDown(
                                enabled: edit,
                                initialValue: _profile?.studCourse,
                                onChanged: (value) => _programName = value),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      RaisedButton(
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: defaultColor,
                          onPressed: () async {
                            await UserProvider.logOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SplashPage()));
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                ),
              );
            }),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: <Widget>[
        //     SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        //     CircleAvatar(
        //       radius: 40,
        //       backgroundColor: Colors.black,
        //       child: Icon(
        //         Icons.person,
        //         size: 50,
        //       ),
        //     ),
        //     SizedBox(height: 20),
        //     // TextField(),
        //     Text(
        //       'Your Name',
        //       style: TextStyle(fontSize: 30),
        //     ),
        //     SizedBox(height: 20),
        //     Text("STUDENT ID"),
        //     SizedBox(height: 20),
        //     Text("MOBILE NO"),
        //     SizedBox(height: 10),
        //     RaisedButton(
        //         onPressed: () {},
        //         child: Text(
        //           "Save",
        //           style: TextStyle(color: Colors.white),
        //         )),
        //   ],
        // ),
      ),
    );
  }
}
