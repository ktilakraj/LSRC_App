import 'package:http/http.dart' as http;

import '../constants.dart';
import '../models/about.dart';
import '../models/auth.dart';
import '../models/course.dart';
import '../models/event.dart';
import '../models/notification.dart';

class ApiProvider {
  static Future<AboutModel> get fetchInfo async {
    final _response = await http.get("$baseUrl/3359").catchError((e) => null);
    if (_response?.statusCode == 200) {
      return aboutModelFromMap(_response.body);
    }
    return null;
  }

  static Future<CourseModel> get fetchCourses async {
    final _response = await http.get("$baseUrl/3361").catchError((e) => null);
    if (_response?.statusCode == 200) {
      return courseModelFromMap(_response.body);
    }
    return null;
  }

  static Future<List<EventModel>> get fetchEvents async {
    final _response =
        await http.get("$baseUrl?categories=42").catchError((e) => null);
    if (_response?.statusCode == 200) {
      return eventModelFromMap(_response.body);
    }
    return null;
  }

  static Future<AuthModel> login(String email, String pass) async {
    final _response = await http.post("$authUrl/login.php",
        body: {"email": email, "pass": pass}).catchError((e) => null);
    if (_response?.statusCode == 200) {
      return authModelFromMap(_response.body);
    }
    return null;
  }

  static Future<List<NotificationModel>> get fetchNotifcations async {
    final _response =
        await http.get("$baseUrl?categories=41").catchError((e) => null);
    if (_response?.statusCode == 200) {
      return notificationApiModelFromMap(_response.body);
    }
    return null;
  }

  static Future<AuthModel> register(
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
}
