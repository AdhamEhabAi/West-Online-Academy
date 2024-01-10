import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_own_courses.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/services/get_owned_course.dart';
import 'package:elmanasa/widgets/courseScreenWidgets/course_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCourses extends StatelessWidget {
  MyCourses({required this.user, Key? key}) : super(key: key);
  UserModel? user;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kSecondaryColor,
            elevation: 0,
            title: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'الدروس',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: kSecondaryColor,
                )),
          ),
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: FutureBuilder<List<AllOwnCourses>>(
                future: GetOwnedCoursesService().getAllOwnedCourses(body: {
                  'iduser': user!.id,
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data == null ||
                      (snapshot.data!).isEmpty) {
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
                    List<AllOwnCourses> allOwnCoursesList = snapshot.data!;
                    return SizedBox(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: allOwnCoursesList.length,
                        itemBuilder: (context, index) {
                          if (index >= 0 && index < allOwnCoursesList.length) {
                            return CourseContainer(
                              ownedCourse: allOwnCoursesList[index],
                            );
                          } else {
                            // Handle the case where the index is out of bounds
                            return Container(); // You can return an empty container or another widget as needed
                          }
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
