import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_course_by_year.dart';
import 'package:http/http.dart' as http;

class AllCoursesByYearService {
  Future<List<CourseYear>> getAllCoursesYear({required String yr}) async {
    http.Response response = await http.get(Uri.parse(getAllCoursesByYear + yr));
    List<dynamic> data = jsonDecode(response.body);
    List<CourseYear> coursesList = [];

    for (int i = 0; i < data.length; i++) {
      Map<String, dynamic> courseData = data[i];

      coursesList.add(CourseYear.fromJson(courseData));
    }

    return coursesList;
  }
}
