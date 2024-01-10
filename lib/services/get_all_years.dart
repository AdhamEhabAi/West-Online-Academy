import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/year_model.dart';
import 'package:http/http.dart' as http;

class AllYearsService
{

  Future <List<Year>> getAllYears () async
  {
    http.Response response =
    await http.get(Uri.parse(getAllYearsApi));
    List<dynamic> data = jsonDecode(response.body);
    List<Year> yearsList = [];
    for(int i = 0;i < data.length; i++)
    {
      yearsList.add(Year.fromJson(data[i]));
    }
    return yearsList;
  }
}