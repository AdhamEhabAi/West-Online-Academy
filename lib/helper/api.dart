import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class Api
{
  Future<dynamic> get({required String url}) async {
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200)
    {
      Map<String, dynamic> data =
      jsonDecode(response.body);
      return data;
    }else
    {
      throw Exception(
        'هناك مشكلة ${response.statusCode}'
      );
    }
  }

  Future<dynamic> post({required String url, @required dynamic body}) async
{
  http.Response response = await http.post(
      Uri.parse(url),
      body: body,
  );
  if(response.statusCode == 200)
  {
    Map<String,dynamic> data = jsonDecode(response.body);
    return data;
  }else
  {
    throw Exception('هناك مشكلة ${response.statusCode}');
  }
}
}

