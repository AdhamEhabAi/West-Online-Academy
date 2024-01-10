import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:elmanasa/models/all_teachers.dart';
import 'package:elmanasa/models/courses_by_teacher.dart';
import 'package:elmanasa/services/get_all_courses_by_teacher.dart';
import 'package:flutter/material.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({super.key});

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  @override
  Widget build(BuildContext context) {
    AllTeachers allTeachers = ModalRoute.of(context)!.settings.arguments as AllTeachers;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي للمعلم',style: TextStyle(color: Colors.white),),
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(onPressed: ()
        {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                height: 110,
                alignment: Alignment.centerRight,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 7,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35.0),
                    bottomRight: Radius.circular(35.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    imgPath + allTeachers.img,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      // Display a placeholder image when an error occurs
                      return const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/man.jpg'),
                      );
                    },
                  ),
                ],
              )
            ]),
            const SizedBox(
              height: 10,
            ),
            Text('${allTeachers.fname} ${allTeachers.lname}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 7,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('رياضيات',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 120,
                  alignment: Alignment.centerRight,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 7,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(allTeachers.country == '1' ? 'مصر': 'السعودية',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          )),
                      const Icon(
                        Icons.location_on,
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 160,
              width: 360,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 7,
                  )
                ],
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        Icon(
                          Icons.child_care_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        Icon(
                          Icons.play_circle,
                          color: Colors.white,
                          size: 40,
                        ),
                        Icon(
                          Icons.stars,
                          color: Colors.white,
                          size: 40,
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('100',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                      Text('4',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                      Text('4.8',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('الطلاب',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                      Text('دورات',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                      Text('التقيم',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<AllLessons>>(
              future: Allcoursesbyteacher().getAllcoursesPyteacher(teacherId: allTeachers.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.data == null) {
                  return const Text('لا يوجد دروس حتى الان');
                } else {
                  List<AllLessons> lessons = snapshot.data!;
                  if (lessons.isEmpty) {
                    return const Center(child: Text('لا يوجد دروس الان'));
                  }

                  return SizedBox(
                    child: ListView.separated(
                      separatorBuilder: (_, __) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      shrinkWrap: true,
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        return CourseByTeacher(lessons: lessons[index],);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
