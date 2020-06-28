// To parse this JSON data, do
//
//     final profileModel = profileModelFromMap(jsonString);

import 'dart:convert';

ProfileModel profileModelFromMap(String str) => ProfileModel.fromMap(json.decode(str));

String profileModelToMap(ProfileModel data) => json.encode(data.toMap());

class ProfileModel {
    ProfileModel({
        this.studId,
        this.studName,
        this.studEmail,
        this.studPass,
        this.studContact,
        this.studCourse,
        this.studAdmYear,
        this.studStatus,
    });

    final String studId;
    final String studName;
    final String studEmail;
    final String studPass;
    final String studContact;
    final String studCourse;
    final String studAdmYear;
    final String studStatus;

    ProfileModel copyWith({
        String studId,
        String studName,
        String studEmail,
        String studPass,
        String studContact,
        String studCourse,
        String studAdmYear,
        String studStatus,
    }) => 
        ProfileModel(
            studId: studId ?? this.studId,
            studName: studName ?? this.studName,
            studEmail: studEmail ?? this.studEmail,
            studPass: studPass ?? this.studPass,
            studContact: studContact ?? this.studContact,
            studCourse: studCourse ?? this.studCourse,
            studAdmYear: studAdmYear ?? this.studAdmYear,
            studStatus: studStatus ?? this.studStatus,
        );

    factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        studId: json["stud_id"] == null ? null : json["stud_id"],
        studName: json["stud_name"] == null ? null : json["stud_name"],
        studEmail: json["stud_email"] == null ? null : json["stud_email"],
        studPass: json["stud_pass"] == null ? null : json["stud_pass"],
        studContact: json["stud_contact"] == null ? null : json["stud_contact"],
        studCourse: json["stud_course"] == null ? null : json["stud_course"],
        studAdmYear: json["stud_adm_year"] == null ? null : json["stud_adm_year"],
        studStatus: json["stud_status"] == null ? null : json["stud_status"],
    );

    Map<String, dynamic> toMap() => {
        "stud_id": studId == null ? null : studId,
        "stud_name": studName == null ? null : studName,
        "stud_email": studEmail == null ? null : studEmail,
        "stud_pass": studPass == null ? null : studPass,
        "stud_contact": studContact == null ? null : studContact,
        "stud_course": studCourse == null ? null : studCourse,
        "stud_adm_year": studAdmYear == null ? null : studAdmYear,
        "stud_status": studStatus == null ? null : studStatus,
    };
}
