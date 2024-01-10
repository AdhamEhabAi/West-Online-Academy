import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_course_by_year.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/services/get_all_courses_year.dart';
import 'package:elmanasa/services/get_all_teachers.dart';
import 'package:elmanasa/widgets/homeScreenWidgets/course_widget.dart';
import 'package:flutter/material.dart';

class AllCoursesPage extends StatefulWidget {
  const AllCoursesPage({super.key});

  @override
  State<AllCoursesPage> createState() => _AllCoursesPageState();
}

class _AllCoursesPageState extends State<AllCoursesPage> {
  @override
  Widget build(BuildContext context) {
    UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'كل الدورات',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text('تعرض جميع الدورات نتيجة البحث عن كل الدورات',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  )),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: Future.wait([
                  AllCoursesByYearService().getAllCoursesYear(yr: user.yr),
                  AllTeachersService().getAllTeachers()
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.inventory_outlined,
                            color: kPrimaryColor,
                            size: 200,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'لا يوجد دورات لمواد اشتركت فيها , في حال الاشتراك في دوره ما ستظهر في هذه الصفحه الاختبار الخاص بها .',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    List<Object> courses = snapshot.data![0];
                    List<Object> teachers = snapshot.data![1];
                    return SizedBox(
                      height: 320,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => Courses(
                          enableNavigation: true,
                          image: "assets/images/logo.jpeg",
                          course: courses[index] as CourseYear,
                          user: user,
                        ),
                        itemCount: courses.length,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
