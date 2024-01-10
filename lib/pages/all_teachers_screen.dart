import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_teachers.dart';
import 'package:elmanasa/services/get_all_teachers.dart';
import 'package:elmanasa/widgets/homeScreenWidgets/teacher_box_widget.dart';
import 'package:flutter/material.dart';

class AllTeachersScreen extends StatelessWidget {
  const AllTeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kSecondaryColor,
          elevation: 0.0,
          title: const Text(
            'المعلمين',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<AllTeachers>>(
            future: AllTeachersService().getAllTeachers(),
            builder: (context, snapshot)
          {
            if(snapshot.hasData)
            {
              List<AllTeachers> teachers = snapshot.data!;
              return GridView.builder(
                itemCount: teachers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return TeacherBox(teachers: teachers[index],);
                },
              );
            }else
            {
              return const Center(child: CircularProgressIndicator());
            }
          },),
        )
      ),
    );
  }
}
