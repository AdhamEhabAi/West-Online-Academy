import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_course_by_year.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:elmanasa/models/all_teachers.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/pages/code_screen.dart';
import 'package:elmanasa/services/get_all_courses_year.dart';
import 'package:elmanasa/services/get_all_teachers.dart';
import 'package:elmanasa/services/search_service.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/show_snake_bar.dart';
import 'package:elmanasa/widgets/homeScreenWidgets/teacher.dart';
import 'package:elmanasa/widgets/homeScreenWidgets/clipper.dart';
import 'package:elmanasa/widgets/homeScreenWidgets/course_widget.dart';
import 'package:elmanasa/widgets/shimmer/course_shimmer.dart';
import 'package:elmanasa/widgets/shimmer/teacher_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/courseScreenWidgets/lessonWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int levelIndex = 0;
  late AllLessons selectedLesson;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
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
                            'مرحبا, ${'${user.fname} ${user.lname}'}',
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
                            child: Column(
                              children: [
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      _searchController.text = value;
                                      _isSearching = value
                                          .isNotEmpty; // Set the flag based on whether the user is actively searching.
                                    });
                                  },
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'بحث',
                                    prefixIcon: Icon(Icons.search,
                                        color: kPrimaryColor),
                                    suffixIcon: Icon(
                                      Icons.manage_search,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                                if (_isSearching)
                                  FutureBuilder<List<AllLessons>>(
                                    future: SearchService()
                                        .getAllLessonsBySearch(
                                            lessonName: _searchController.text,
                                            yr: user.yr),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(); // You can show a loading indicator here if needed.
                                      } else if (snapshot.hasError) {
                                        return const Text(
                                            'لا يوجد دروس بهذا الاسم');
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Text(
                                            'لا يوجد نتائج للبحث');
                                      } else {
                                        List<AllLessons> searchLessons =
                                            snapshot.data!;
                                        return Container(
                                          color: Colors.white,
                                          child: ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            separatorBuilder: (_, __) {
                                              return const SizedBox(
                                                height: 10,
                                              );
                                            },
                                            padding: const EdgeInsets.only(
                                                top: 20, bottom: 40),
                                            shrinkWrap: true,
                                            itemCount: searchLessons.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  selectedLesson =
                                                      searchLessons[index];
                                                  try {
                                                    http.Response response =
                                                        await http.post(
                                                      Uri.parse(
                                                          checkIfTheCourseIsOwned),
                                                      body: {
                                                        'idcourse':
                                                            selectedLesson.id,
                                                        'iduser': user.id,
                                                      },
                                                    );
                                                    if (response.statusCode ==
                                                        200) {
                                                      Map<String, dynamic>
                                                          data = jsonDecode(
                                                              response.body);
                                                      print(data.toString());
                                                      if (data['status'] ==
                                                          'false') {
                                                        showGeneralDialog(
                                                          barrierDismissible:
                                                              true,
                                                          barrierLabel:
                                                              "Code page",
                                                          context: context,
                                                          pageBuilder: (context,
                                                                  _, __) =>
                                                              CodePage(
                                                            user: user,
                                                            lesson:
                                                                selectedLesson,
                                                          ),
                                                        );
                                                      } else {
                                                        showSnackbar(context,
                                                            'انت تمتلك هذا الكورس بالفعل');
                                                      }
                                                    }
                                                  } on Exception catch (e) {
                                                    showSnackbar(
                                                        context, e.toString());
                                                  }
                                                },
                                                child: LessonWidget(
                                                    lessons:
                                                        searchLessons[index]),
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
              future: AllCoursesByYearService().getAllCoursesYear(yr: user.yr),
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
                  List<CourseYear> courses = snapshot.data!;
                  return SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Courses(
                        enableNavigation: true,
                        image: "assets/images/logo.jpeg",
                        course: courses[index],
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
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: kPrimaryColor,
                            size: 100,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'لا يوجد مدرسين , في الوقت الحالي .',
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
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: kPrimaryColor,
                            size: 100,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'لا يوجد مدرسين , في الوقت الحالي .',
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
