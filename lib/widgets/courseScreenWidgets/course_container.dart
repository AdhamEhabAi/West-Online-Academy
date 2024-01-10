import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_own_courses.dart';
import 'package:flutter/material.dart';
import '../../pages/details_screen.dart';

class CourseContainer extends StatelessWidget {
  final AllOwnCourses ownedCourse;

  const CourseContainer({
    Key? key,
    required this.ownedCourse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsScreen(
                ownedCourse: ownedCourse,
              ))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imgPath + ownedCourse.img,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  // Display a placeholder image when an error occurs
                  return Image.asset('assets/images/logo.jpeg',height: 40,);
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ownedCourse.name,style: const TextStyle(fontSize: 20),),
                  const SizedBox(
                    height: 5,
                  ),
                  const LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: Colors.black12,
                    color: kPrimaryColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
