import 'dart:convert';
import 'package:elmanasa/models/video_model.dart';
import 'package:http/http.dart' as http;

class AllVideosService {
  Future<List<Video>> getAllVideos({required String courseId}) async {
    http.Response response = await http.get(Uri.parse(
        'https://beta.aminyoussef.com/api/api-selectData.php?tableName=videolink&where=idclassroom&equalWhat=$courseId'));
    List<dynamic> data = jsonDecode(response.body);
    List<Video> videos = [];
    for(int i =0; i <data.length; i++)
    {
      videos.add(Video.fromJson(data[i]));
    }
    return videos;
  }
}


