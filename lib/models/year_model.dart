
class Year {
  final String id;
  final String className;

  Year({
    required this.id,
    required this.className,
  });

  factory Year.fromJson(jsonData) {
    return Year(
      id: jsonData['id'],
      className: jsonData['class'],
    );
  }
}