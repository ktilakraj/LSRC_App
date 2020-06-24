// To parse this JSON data, do
//
//     final authModel = authModelFromMap(jsonString);

import 'dart:convert';

AuthModel authModelFromMap(String str) => AuthModel.fromMap(json.decode(str));

String authModelToMap(AuthModel data) => json.encode(data.toMap());

class AuthModel {
  AuthModel({
    this.message,
    this.userId,
  });

  final String message;
  final String userId;

  AuthModel copyWith({
    String message,
    String userId,
  }) =>
      AuthModel(
        message: message ?? this.message,
        userId: userId ?? this.userId,
      );

  factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
        message: json["message"] == null ? null : json["message"],
        userId: json["user_id"] == null || json["user_id"] == 0
            ? null
            : json["user_id"],
      );

  Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "user_id": userId == null ? null : userId,
      };
}
