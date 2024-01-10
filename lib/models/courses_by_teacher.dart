import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:flutter/material.dart';

class CourseByTeacher extends StatelessWidget {
  CourseByTeacher({required this.lessons,this.ontap,super.key});
  AllLessons lessons;
  VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        child: Container(
          alignment: Alignment.centerRight,
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius:7,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: kSecondaryColor,
              child: Icon(Icons.play_circle,color: Colors.white,),
            ),
            title: Text(
                lessons.name!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                )),
          ),
        ),
      ),
    );
  }
}
