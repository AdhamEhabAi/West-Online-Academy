import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_course_by_year.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/pages/code_screen.dart';
import 'package:elmanasa/services/get_all_Lessons.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/show_snake_bar.dart';
import 'package:elmanasa/widgets/courseScreenWidgets/lessonWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CourseInfo extends StatelessWidget {
  CourseInfo({super.key});
  late AllLessons selectedLesson;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> courseTeacher =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    CourseYear course = courseTeacher['course'];
    UserModel user = courseTeacher['user'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'معلومات عن الدوره',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: kSecondaryColor,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "دوره شامله لماده ${course.name}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const Text(
                        '100 ساعة - 52 درس',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "تحتوي الدوره علي تاسسيس شامل للصفوف السابقهة بالاضافه الي شرح الكتاب وحل النمازج وكل ما يحتاجه الطالب لانجتز الاختبار بتفوق",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "محتوي الدوره",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    width: 350,
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "دروس تاسيس",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_downward_outlined,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  FutureBuilder<List<AllLessons>>(
                    future: AllLessonsService().getAllLessons(catId: course.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.data == null) {
                        return const Text('لا يوجد دروس الان');
                      } else {
                        List<AllLessons> lessons = snapshot.data!;
                        if (lessons.isEmpty) {
                          return const Center(child: Text('لا يوجد دروس الان'));
                        }

                        return SizedBox(
                          height: 80,
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
                              return GestureDetector(
                                onTap: () async {
                                  selectedLesson = lessons[index];
                                  try {
                                    http.Response response = await http.post(
                                        Uri.parse(
                                            checkIfTheCourseIsOwned),
                                        body: {
                                          'idcourse': selectedLesson.id,
                                          'iduser': user.id,
                                        });
                                    if (response.statusCode == 200) {
                                      Map<String, dynamic> data =
                                      jsonDecode(response.body);
                                      print(data.toString());
                                      if(data['status'] == 'false')
                                      {
                                        showGeneralDialog(
                                          barrierDismissible: true,
                                          barrierLabel: "Code page",
                                          context: context,
                                          pageBuilder: (context, _, __) => CodePage(user: user, lesson: selectedLesson,),
                                        );
                                      }else {
                                        return showSnackbar(context, 'انت تمتلك هذا الكورس بالفعل');
                                      }
                                    }
                                  } on Exception catch (e) {
                                    showSnackbar(context, e.toString());
                                  }

                                },
                                child: LessonWidget(lessons: lessons[index]),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),


      ),
    );
  }
}
