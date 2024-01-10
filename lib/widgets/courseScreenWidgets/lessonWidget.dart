import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:flutter/material.dart';
class LessonWidget extends StatelessWidget {
  LessonWidget({required this.lessons,super.key});

  AllLessons lessons;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: kSecondaryColor,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Image.asset(
              'assets/images/banner-image.png',
              height: 45,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lessons.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.add,
              color: kSecondaryColor,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
