const String baseUrl = "https://lsraheja.org/wp-json/wp/v2/posts";
const String authUrl = "https://www.lsraheja.org/lsrc_moa/";

const List<CourseDetails> coursesList = [
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

class CourseDetails {
  final String id;
  final String name;

  const CourseDetails(this.id, this.name);
}
