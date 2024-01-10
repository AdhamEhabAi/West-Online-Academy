import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:http/http.dart' as http;

class SearchService
{

  Future<List<AllLessons>> getAllLessonsBySearch({required String lessonName , required String yr}) async {
    http.Response response = await http.get(Uri.parse('$domain/api/api-search.php?search=$lessonName&yr=$yr' ));
    Map<String, dynamic> data = jsonDecode(response.body);
    List<AllLessons> lessonList = [];

    if (data.containsKey('data')) {
      List lessonsData = data['data'];
      for (int i = 0; i < lessonsData.length; i++) {
        lessonList.add(AllLessons.fromJson(lessonsData[i]));
      }
    }
    return lessonList;
  }


}
