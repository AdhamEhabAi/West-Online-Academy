import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_teachers.dart';
import 'package:http/http.dart' as http;

class AllTeachersService
{
  Future <List<AllTeachers>> getAllTeachers () async
  {
   http.Response response =
          await http.get(Uri.parse(getAllTeachersApi));
   List<dynamic> data = jsonDecode(response.body);
   List<AllTeachers> teacherList = [];
   for(int i = 0;i < data.length; i++)
   {
     teacherList.add(AllTeachers.fromJson(data[i]));
   }
   return teacherList;
  }
}