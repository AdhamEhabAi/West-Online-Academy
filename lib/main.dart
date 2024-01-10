import 'dart:convert';
import 'dart:io';
import 'package:elmanasa/models/all_own_courses.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/pages/all_teachers_screen.dart';
import 'package:elmanasa/pages/course_info.dart';
import 'package:elmanasa/pages/all_courses_screen.dart';
import 'package:elmanasa/pages/details_screen.dart';
import 'package:elmanasa/pages/edit_profile_page.dart';
import 'package:elmanasa/pages/my_courses_screen.dart';
import 'package:elmanasa/pages/get_started.dart';
import 'package:elmanasa/pages/nav_bar.dart';
import 'package:elmanasa/pages/privacy_policy.dart';
import 'package:elmanasa/pages/register_page.dart';
import 'package:elmanasa/pages/splash_screen.dart';
import 'package:elmanasa/pages/teacher%20_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true,
  );
  runApp(const MyApp());
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'),
      ],
      debugShowCheckedModeBanner: false,
      home: const NavBar(),
      initialRoute: 'SplashScreen',
      routes: {
        'GetStarted': (context) => const GetStarted(),
        'SplashScreen': (context) => const SplashScreen(),
        'NavBar': (context) => const NavBar(),
        'PrivAndPolicy': (context) => const PrivAndPolicy(),
        'MyCourses': (context) => MyCourses(
              user: UserModel.fromJson(json),
            ),
        'CourseInfo': (context) => CourseInfo(),
        'TeacherProfile': (context) => const TeacherProfile(),
        'AllCoursesPage': (context) => const AllCoursesPage(),
        'AllTeachersScreen': (context) => const AllTeachersScreen(),
        'RegisterPage': (context) => const RegisterPage(),
        'EditProfilePage': (context) => const EditProfilePage(),
        'DetailsScreen': (context) => DetailsScreen(
              ownedCourse: AllOwnCourses.fromJson(json as Map<String, dynamic>),
            ),
      },
    );
  }
}
