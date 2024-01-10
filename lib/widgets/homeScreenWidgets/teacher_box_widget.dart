import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_teachers.dart';
import 'package:flutter/material.dart';

class TeacherBox extends StatelessWidget {
  TeacherBox({required this.teachers,super.key});
  AllTeachers teachers;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: ()
        {
          Navigator.pushNamed(context, 'TeacherProfile',arguments: teachers);
        },
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Image.network(
                imgPath + teachers.img,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  // Display a placeholder image when an error occurs
                  return Image.asset(
                    'assets/images/user.png',
                    height: 40,
                  );
                },
              ),
            ),
            Container(
              width: 150,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('2 دورات',style: TextStyle(color: Colors.white),),
                            Icon(Icons.book_outlined,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(teachers.fname + teachers.lname,
                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),
                    ),
                  ),
                  const Center(
                    child: Text('مدرس عربي',
                      style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
