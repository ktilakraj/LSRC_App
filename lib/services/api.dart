import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;
import 'package:lsrc/models/courselist.dart';
import 'package:lsrc/models/profile.dart';
import 'package:lsrc/services/hive.dart';

import '../constants.dart';
import '../models/about.dart';
import '../models/auth.dart';
import '../models/course.dart';
import '../models/event.dart';
import '../models/notification.dart';

class ApiProvider {
  static void recordLog(http.Response response) {
    final _map = {"code": "${response.statusCode}", "data": "${response.body}"};
    Crashlytics.instance.log("Api error: $_map");
  }

  static void recordError(Exception e, StackTrace s) =>
      Crashlytics.instance.recordError(e, s);

  static Future<AboutModel> get fetchInfo async {
    final _response = await http.get("$baseUrl/3359").catchError((e, s) {
      recordError(e, s);
      return null;
    });
    if (_response?.statusCode == 200) {
      return aboutModelFromMap(_response.body);
    }
    if (_response != null) recordLog(_response);
    return null;
  }

  static Future<CourseModel> get fetchCourses async {
    final _response = await http.get("$baseUrl/3361").catchError((e, s) {
      recordError(e, s);
      return null;
    });
    if (_response?.statusCode == 200) {
      return courseModelFromMap(_response.body);
    }
    if (_response != null) recordLog(_response);
    return null;
  }

  static Future<List<EventModel>> get fetchEvents async {
    final _response =
        await http.get("$baseUrl?categories=42").catchError((e, s) {
      recordError(e, s);
      return null;
    });
    if (_response?.statusCode == 200) {
      return eventModelFromMap(_response.body);
    }
    if (_response != null) recordLog(_response);
    return null;
  }

  static Future<AuthModel> login(
      String email, String pass, String token) async {
    final _body = {"email": email, "pass": pass};
    if (token != null) _body["token"] = token;
    final _response =
        await http.post("$authUrl/login.php", body: _body).catchError((e, s) {
      recordError(e, s);
      return null;
    });
    if (_response?.statusCode == 200) {
      return authModelFromMap(_response.body);
    }
    if (_response != null) recordLog(_response);
    return null;
  }

  static Future<String> forgotPassword(
    String email,
  ) async {
    final _body = {
      "stud_email": email,
    };
    final _response =
        await http.post("$authUrl/forgot.php", body: _body).catchError((e, s) {
      recordError(e, s);
      return null;
    });
    if (_response?.statusCode == 200) {
      return authModelFromMap(_response.body).message;
    }
    if (_response != null) recordLog(_response);
    return null;
  }

  static Future<List<NotificationModel>> get fetchNotifcations async {
    final _response =
        await http.get("$baseUrl?categories=41").catchError((e, s) {
      recordError(e, s);
      return null;
    });
    if (_response?.statusCode == 200) {
      return notificationApiModelFromMap(_response.body);
    }
    if (_response != null) recordLog(_response);
    return null;
  }

  static Future<AuthModel> register(
      {String email,
      String pass,
      String name,
      String program,
      String year,
      String token,
      String mobileNo}) async {
    final _body = {
      "email": email,
      "pass": pass,
      "name": name,
      "contact": mobileNo,
      "year": year,
      "course": program
    };
    if (token != null) _body["token"] = token;
    final _response = await http
        .post("$authUrl/register.php", body: _body)
        .catchError((e, s) {
      recordError(e, s);
      return null;
    });
    print(_response.body);
    if (_response?.statusCode == 200) {
      return authModelFromMap(_response.body);
    }
    if (_response != null) recordLog(_response);
    return null;
  }

  static Future<ProfileModel> get fetchProfile async {
    final id = await UserProvider.fetchUserId();
    final _response = await http
        .post("$authUrl/get.php", body: {"stud_id": id}).catchError((e, s) {
      recordError(e, s);
      return null;
    });
    if (_response?.statusCode == 200) {
      return profileModelFromMap(_response.body);
    }
    if (_response != null) recordLog(_response);
    return null;
  }

  static Future<AuthModel> editProfile(
      {String name, String contact, String course, String year}) async {
    final _id = await UserProvider.fetchUserId();
    final _response = await http.post("$authUrl/edit.php", body: {
      "name": name,
      "contact": contact,
      "year": year,
      "course": course,
      "stud_id": _id,
      "type": "edit"
    }).catchError((e, s) {
      recordError(e, s);
      return null;
    });
    if (_response?.statusCode == 200) {
      return authModelFromMap(_response.body);
    }
    if (_response != null) recordLog(_response);
    return null;
  }

  static Future<List<CourseListModel>> fetchCourseList() async {
    final _response =
        await http.get("$authUrl/getCourse.php").catchError((e, s) {
      recordError(e, s);
      return null;
    });
    if (_response?.statusCode == 200) {
      return courseListModelFromMap(_response.body);
    }
    if (_response != null) recordLog(_response);
    return null;
  }
}
