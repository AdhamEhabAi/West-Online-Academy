class ApiResponse {
  final String status;
  final List<AllOwnCourses> data;

  ApiResponse({required this.status, required this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'],
      data: (json['data'] as List)
          .map((courseData) => AllOwnCourses.fromJson(courseData))
          .toList(),
    );
  }
}

class AllOwnCourses {
  final String id;
  final String name;
  final String typeClassroom;
  final String videoControl;
  final String cat;
  final String img;
  final String vStatus;
  final String sStatus;
  final String videoLimit;
  final String pub;
  final String yr;
  AllOwnCourses({
    required this.id,
    required this.name,
    required this.typeClassroom,
    required this.videoControl,
    required this.cat,
    required this.img,
    required this.vStatus,
    required this.sStatus,
    required this.videoLimit,
    required this.pub,
    required this.yr,
  });
  factory AllOwnCourses.fromJson(Map<String, dynamic> json) {
    return AllOwnCourses(
      id: json['id'] ,
      name: json['name'] ,
      typeClassroom: json['typeclassroom'] ,
      videoControl: json['videoControll'] ,
      cat: json['cat'] ,
      img: json['img'] ,
      vStatus: json['vstatus'],
      sStatus: json['sstatus'],
      videoLimit: json['videolimte'],
      pub: json['pub'] ,
      yr: json['yr'] ,
    );
  }
}
