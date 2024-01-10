import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/pages/my_courses_screen.dart';
import 'package:elmanasa/pages/profile_page.dart';
import 'package:elmanasa/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'home_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomeScreen(),
          const QuizPage(),
          MyCourses(user: user),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: kSecondaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
              pageController.animateToPage(currentIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            },
            color: Colors.white,
            activeColor: Colors.white,
            backgroundColor: kSecondaryColor,
            tabBackgroundColor: kPrimaryColor,
            padding: const EdgeInsets.all(16),
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'الرئيسية',
              ),
              GButton(
                icon: Icons.quiz,
                text: 'الاختبارات',
              ),
              GButton(
                icon: Icons.play_arrow_outlined,
                text: 'دوراتي',
              ),
              GButton(
                icon: Icons.account_circle_outlined,
                text: 'الملف الشخصي',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
