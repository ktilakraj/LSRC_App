import 'dart:ui';

const String baseUrl = "https://lsraheja.org/wp-json/wp/v2/posts";
const String authUrl = "https://www.lsraheja.org/lsrc_moa/";

const List<CourseDetails> coursesList = [
  CourseDetails("JC ARTS", "Junior Arts"),
  CourseDetails("JC COM", "Junior Commerce"),
  CourseDetails("BCOM", "Bachelor Of Commerce"),
  CourseDetails("BA", "Bachelor Of Arts"),
  CourseDetails("BAF", "Bachelor Of Commerce (Accounting & Finance)"),
  CourseDetails("BBI", "Bachelor Of Commerce (Banking & Insurance)"),
  CourseDetails("BFM", "Bachelor Of Commerce (Financial Markets)"),
  CourseDetails("BMS", "Bachelor Of Management Studies"),
  CourseDetails("BAMMC/BMM",
      "Bachelor Of Arts In Mass Media & Communication / Bachelor In Mass Media"),
  CourseDetails("BSC.IT", "Bachelor Of Science In Information Technology"),
  CourseDetails("MCOM ACC", "Master Of Commerce In Accountancy"),
  CourseDetails("MCOM B/F", "Master Of Commerce In Banking & Finance"),
  CourseDetails("MCOM BM", "Master Of Commerce In Business Management"),
];

class CourseDetails {
  final String id;
  final String name;

  const CourseDetails(this.id, this.name);
}

const defaultColor = Color(0xff071DBD);
enum DetailType { notification, event, examination }