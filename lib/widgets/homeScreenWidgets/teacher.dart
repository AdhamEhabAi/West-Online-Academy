import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_teachers.dart';
import 'package:flutter/material.dart';

class Teacher extends StatelessWidget {
   Teacher({required this.allTeachers,super.key});

  AllTeachers allTeachers;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: ()
        {
          Navigator.of(context).pushNamed('TeacherProfile',arguments: allTeachers);
        },
        child: Container(
          height: 80,
          width: 260,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                imgPath + allTeachers.img,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) {
                  // Display a placeholder image when an error occurs
                  return const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${allTeachers.fname!} ${allTeachers.lname!}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                   allTeachers.fnum!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
