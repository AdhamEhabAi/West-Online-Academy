import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_course_by_year.dart';
import 'package:elmanasa/models/all_teachers.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/services/get_all_courses_year.dart';
import 'package:elmanasa/services/get_all_teachers.dart';
import 'package:elmanasa/widgets/homeScreenWidgets/teacher.dart';
import 'package:elmanasa/widgets/homeScreenWidgets/clipper.dart';
import 'package:elmanasa/widgets/homeScreenWidgets/course_widget.dart';
import 'package:elmanasa/widgets/shimmer/course_shimmer.dart';
import 'package:elmanasa/widgets/shimmer/teacher_shimmer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int levelIndex = 0;
  @override
  Widget build(BuildContext context) {
    UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipPath(
                  clipper: BottomClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: const BoxDecoration(color: kSecondaryColor),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مرحبا, ${user.fname + ' ' + user.lname}',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'لنبدأ رحلة التعلم',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'بحث',
                                prefixIcon:
                                    Icon(Icons.search, color: kPrimaryColor),
                                suffixIcon: Icon(
                                  Icons.manage_search,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(" مواد الصف",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('AllCoursesPage', arguments: user);
                    },
                    child: const Text("الكل",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.grey, size: 18),
                ],
              ),
            ),
          FutureBuilder(
            future: Future.wait([
              AllCoursesByYearService().getAllCoursesYear(yr: user.yr),
              AllTeachersService().getAllTeachers()
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CourseShimmer();
              } else if (snapshot.hasError) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.not_interested_outlined,
                          color: kPrimaryColor,
                          size: 200,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'لا يوجد مواد , في الوقت الحالي .',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.not_interested_outlined,
                          color: kPrimaryColor,
                          size: 200,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'لا يوجد اختبارات لمواد اشتركت فيها , في الوقت الحالي .',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ); // or handle the case where data is null
              } else {
                List<Object> courses = snapshot.data![0];
                List<Object> teachers = snapshot.data![1];
                return SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Courses(
                      enableNavigation: true,
                      image: "assets/images/logo.jpeg",
                      cost: '250,00',
                      count: "100",
                      teacher: teachers[index] as AllTeachers,
                      course: courses[index] as CourseYear,
                      user: user,
                    ),
                    itemCount: courses.length,
                  ),
                );
              }
            },
          ),

          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("اشهر المدرسين",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('AllTeachersScreen');
                    },
                    child: const Text("الكل",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.grey, size: 18),
                ],
              ),
            ),
            FutureBuilder<List<AllTeachers>>(
              future: AllTeachersService().getAllTeachers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const TeacherShimmer();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return const Text(
                      'لا يوجد مدرسين الان');
                } else {
                  List<AllTeachers> teachers = snapshot.data!;
                  return SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: teachers.length,
                      itemBuilder: (context, index) {
                        return Teacher(
                          allTeachers: teachers[index],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
