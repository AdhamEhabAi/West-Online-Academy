import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:http/http.dart' as http;

class GetAllLessonsByYear
{

  Future <List<AllLessons>> getAllLessonsByYear ({required String userYr}) async
  {
    http.Response response =
    await http.get(Uri.parse(getAllLessonsByYearApi + userYr));
    List<dynamic> data = jsonDecode(response.body);
    List<AllLessons> lessonList = [];
    for(int i = 0;i < data.length; i++)
    {
      lessonList.add(AllLessons.fromJson(data[i]));
    }
    return lessonList;
  }


}