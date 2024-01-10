class Video {
  String id;
  String name;
  String idclassroom;
  String leader;
  String date;
  String videoType;
  String views;
  String firstUrl;
  // String sacandUrl;
  String status;

  Video({
    required this.id,
    required this.name,
    required this.idclassroom,
    required this.leader,
    required this.date,
    required this.videoType,
    required this.views,
    required this.firstUrl,
    // required this.sacandUrl,
    required this.status,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      name: json['name'],
      idclassroom: json['idclassroom'],
      leader: json['leader'],
      date: json['date'],
      videoType: json['videoType'],
      views: json['views'],
      firstUrl: json['firstUrl'],
      // sacandUrl: json['sacandUrl'],
      status: json['status'],
    );
  }
}


// List<Lesson> lessonList = [
//   Lesson(
//     duration: '11 دقيقه 20 ثانية',
//     isCompleted: true,
//     isPlaying: true,
//     name: "المحاضره الاولي",
//   ),
//   Lesson(
//     duration: '10 دقيقه 11 sec',
//     isCompleted: false,
//     isPlaying: false,
//     name: "المحاضره الثانية",
//   ),
//   Lesson(
//     duration: '7 دقيقه',
//     isCompleted: false,
//     isPlaying: false,
//     name: "المحاضره الثالثة",
//   ),
//   Lesson(
//     duration: '5 دقيقه',
//     isCompleted: false,
//     isPlaying: false,
//     name: "المحاضره الرابعة",
//   ),
//   Lesson(
//     duration: '5 دقيقه',
//     isCompleted: false,
//     isPlaying: false,
//     name: "المحاضره الخامسة",
//   ),
//   Lesson(
//     duration: '5 دقيقه',
//     isCompleted: false,
//     isPlaying: false,
//     name: "المحاضره السادسة",
//   )
// ];
