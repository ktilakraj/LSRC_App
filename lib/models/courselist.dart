// To parse this JSON data, do
//
//     final courseListModel = courseListModelFromMap(jsonString);

import 'dart:convert';

List<CourseListModel> courseListModelFromMap(String str) => List<CourseListModel>.from(json.decode(str).map((x) => CourseListModel.fromMap(x)));

String courseListModelToMap(List<CourseListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CourseListModel {
    CourseListModel({
        this.courseId,
        this.courseName,
        this.courseCode,
    });

    final String courseId;
    final String courseName;
    final String courseCode;

    CourseListModel copyWith({
        String courseId,
        String courseName,
        String courseCode,
    }) => 
        CourseListModel(
            courseId: courseId ?? this.courseId,
            courseName: courseName ?? this.courseName,
            courseCode: courseCode ?? this.courseCode,
        );

    factory CourseListModel.fromMap(Map<String, dynamic> json) => CourseListModel(
        courseId: json["course_id"] == null ? null : json["course_id"],
        courseName: json["course_name"] == null ? null : json["course_name"],
        courseCode: json["course_code"] == null ? null : json["course_code"],
    );

    Map<String, dynamic> toMap() => {
        "course_id": courseId == null ? null : courseId,
        "course_name": courseName == null ? null : courseName,
        "course_code": courseCode == null ? null : courseCode,
    };
}
