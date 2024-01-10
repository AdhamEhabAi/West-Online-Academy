import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:http/http.dart' as http;

class AllLessonsService
{

  Future <List<AllLessons>> getAllLessons ({required catId}) async
  {
    http.Response response =
    await http.get(Uri.parse(getAllLessonsApi + catId));
    List<dynamic> data = jsonDecode(response.body);
    List<AllLessons> coursesList = [];
    for(int i = 0;i < data.length; i++)
    {
      coursesList.add(AllLessons.fromJson(data[i]));
    }
    return coursesList;
  }


}