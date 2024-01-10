import 'package:elmanasa/models/all_course_by_year.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  Courses(
      {
      required this.course,
        required this.enableNavigation,
      required this.user,
      this.image,
      super.key});

  String? image;
  CourseYear course;
  UserModel user;
  final bool enableNavigation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enableNavigation
          ? () {
        Navigator.of(context).pushNamed(
          'CourseInfo',
          arguments: {'course': course,'user':user},
        );
      } : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 270,
          height: 250,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
