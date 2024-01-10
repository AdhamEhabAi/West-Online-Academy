import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:http/http.dart' as http;

class Allcoursesbyteacher
{
  Future <List<AllLessons>> getAllcoursesPyteacher ({required String teacherId}) async
  {
    http.Response response =
    await http.get(Uri.parse(getCoursesByTeacher + teacherId));
    List<dynamic> data = jsonDecode(response.body);
    List<AllLessons> coursesbyteacherlist = [];
    for(int i = 0;i < data.length; i++)
    {
      coursesbyteacherlist.add(AllLessons.fromJson(data[i]));
    }
    return coursesbyteacherlist;
  }

}
