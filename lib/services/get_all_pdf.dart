import 'dart:convert';
import 'package:elmanasa/models/all_pdf.dart';
import 'package:http/http.dart' as http;

class AllPdfService
{
  Future <List<AllPdf>> getAllPdf ({required String courseId}) async
  {
    http.Response response =
    await http.get(Uri.parse('https://beta.aminyoussef.com/api/api-selectData.php?tableName=filepdf&where=idclassroom&equalWhat=$courseId'));
    List<dynamic> data = jsonDecode(response.body);
    List<AllPdf> pdfList = [];
    for(int i = 0;i < data.length; i++)
    {
      pdfList.add(AllPdf.fromJson(data[i]));
    }
    return pdfList;
  }

}
// Future<void> downloadFile(String url, String savePath) async {
//   final response = await http.get(Uri.parse("https://beta.aminyoussef.com/api/api-selectData.php?tableName=filepdf&where=idclassroom&equalWhat=2"));
//   final file = File(savePath);
//   await file.writeAsBytes(response.bodyBytes);
// }
