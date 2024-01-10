class AllPdf {
  final String id, name, url, date, owner, idclassroom;

  AllPdf(
      {required this.id,
      required this.name,
      required this.url,
      required this.date,
      required this.owner,
      required this.idclassroom});

  factory AllPdf.fromJson(jsonData) {
    return AllPdf(
      id: jsonData['id'],
      name: jsonData['name'],
      url : jsonData['url'],
      date : jsonData['date'],
      owner : jsonData['owner'],
      idclassroom : jsonData['idclassroom'],
    );
  }
}
