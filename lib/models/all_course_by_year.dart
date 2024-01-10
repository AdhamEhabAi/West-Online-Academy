class CourseYear {
  String id;
  String name;
  String classNumber;

  CourseYear({
    required this.id,
    required this.name,
    required this.classNumber,
  });

  factory CourseYear.fromJson(jsonData) {
    return CourseYear(
      id: jsonData['id'],
      name: jsonData['name'],
      classNumber: jsonData['class'] ,
    );
  }
}