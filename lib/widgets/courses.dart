import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/courselist.dart';
import '../services/api.dart';
import '../utils/utils.dart';

class CoursesDropDown extends StatefulWidget {
  final String initialValue;
  final bool enabled;
  final ValueChanged<String> onChanged;

  const CoursesDropDown(
      {Key key, this.initialValue, this.enabled = true, this.onChanged})
      : super(key: key);
  @override
  _CoursesDropDownState createState() => _CoursesDropDownState();
}

class _CoursesDropDownState extends State<CoursesDropDown> {
  String _value;
  Future _fetch;

  List<DropdownMenuItem<String>> getItems(List<CourseListModel> coursesList) {
    List<DropdownMenuItem<String>> _items = [];
    for (final _course in coursesList)
      _items.add(DropdownMenuItem(
          value: _course.courseCode,
          child: Text(
            _course.courseName,
          )));
    return _items;
  }

  String fetchCourseName(String id) =>
      coursesList.firstWhere((e) => e.id == id, orElse: () => null)?.name ?? id;

  @override
  void initState() {
    _fetch = ApiProvider.fetchCourseList();
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.unfocus(context),
      child: FutureBuilder(
          future: _fetch,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            final _courseList = List<CourseListModel>.from(snapshot.data ?? []);
            return DropdownButtonFormField<String>(
                onTap: () => Utils.unfocus(context),
                isExpanded: true,
                items: getItems(_courseList),
                itemHeight: 50,
                isDense: false,
                value: _value,
                validator: (String newValue) {
                  if (newValue?.isEmpty ?? true)
                    return "Select a valid Programme";
                  return null;
                },
                disabledHint: Text(fetchCourseName(widget?.initialValue ?? '')),
                decoration: InputDecoration(
                    enabled: widget.enabled,
                    labelText: 'Select Programme',
                    disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.grey[300])),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 2,
                    ))),
                onChanged: widget.enabled
                    ? (value) {
                        widget.onChanged(value);
                        setState(() {
                          _value = value;
                        });
                      }
                    : null);
          }),
    );
  }
}
