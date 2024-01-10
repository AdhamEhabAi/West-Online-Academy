class AllLessons
{
  String id;
  String name;
  String typeClassroom;
  String videoControll;
  String cat;
  String title;
  String img;
  String vid;
  String vStatus;
  String stitle;
  String svid;
  String sStatus;
  String videoLimit;
  String sub;
  String pub;
  String yr;
  String price;
  String exam;
  String fres;
  String cnct;
  String exmlnk;

  AllLessons({required this.id,
    required this.name,
    required this.typeClassroom,
    required this.videoControll,
    required this.cat,
    required this.title,
    required this.img,
    required this.vid,
    required this.vStatus,
    required this.stitle,
    required this.svid,
    required this.sStatus,
    required this.videoLimit,
    required this.sub,
    required this.pub,
    required this.yr,
    required this.price,
    required this.exam,
    required this.fres,
    required this.cnct,
    required this.exmlnk,});
  factory AllLessons.fromJson(jsonData)
  {
    return AllLessons(
      id: jsonData['id'] ?? "",
      name: jsonData['name'] ?? "",
      typeClassroom: jsonData['typeclassroom'] ?? "",
      videoControll: jsonData['videoControll'] ?? "",
      cat: jsonData['cat'] ?? "",
      title: jsonData['title'] ?? "",
      img: jsonData['img'] ?? "",
      vid: jsonData['vid'] ?? "",
      vStatus: jsonData['vstatus'] ?? "",
      stitle: jsonData['stitle'] ?? "",
      svid: jsonData['svid'] ?? "",
      sStatus: jsonData['sstatus'] ?? "",
      videoLimit: jsonData['videolimte'] ?? "",
      sub: jsonData['sub'] ?? "",
      pub: jsonData['pub'] ?? "",
      yr: jsonData['yr'] ?? "",
      price: jsonData['price'] ?? "",
      exam: jsonData['exam'] ?? "",
      fres: jsonData['fres'] ?? "",
      cnct: jsonData['cnct'] ?? "",
      exmlnk: jsonData['exmlnk'] ?? "",
    );
  }
}
