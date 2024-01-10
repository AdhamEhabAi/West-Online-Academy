import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_own_courses.dart';

class GetOwnedCoursesService {
  Future<List<AllOwnCourses>> getAllOwnedCourses({required dynamic body}) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(getOwnedCourses),
        body: body,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String status = responseData['status'];
        List<AllOwnCourses> ownCoursesList = [];

        if (status == 'true') {
          List<dynamic> coursesData = responseData['data'];

          for (var courseData in coursesData) {
            ownCoursesList.add(AllOwnCourses.fromJson(courseData));
          }

          return ownCoursesList;
        } else {
          // Handle the case where the status is not 'true'
          throw Exception('Failed to load data. Status: $status');
        }
      } else {
        throw Exception('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
