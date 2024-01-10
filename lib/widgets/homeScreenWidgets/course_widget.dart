import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_course_by_year.dart';
import 'package:elmanasa/models/all_teachers.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  Courses(
      {required this.teacher,
      required this.course,
        required this.enableNavigation,
      required this.user,
      this.image,
      this.cost,
      this.count,
      super.key});

  String? image;
  String? cost;
  String? count;
  CourseYear course;
  AllTeachers teacher;
  UserModel user;
  final bool enableNavigation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enableNavigation
          ? () {
        Navigator.of(context).pushNamed(
          'CourseInfo',
          arguments: {'course': course, 'teacher': teacher,'user':user},
        );
      } : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 270,
          height: 300,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 7,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 265,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 7,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        image!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(course.name,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),

                const SizedBox(
                  height: 5,
                ),
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(cost!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(count!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          )),
                      const SizedBox(
                        width: 120,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(teacher.id,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
