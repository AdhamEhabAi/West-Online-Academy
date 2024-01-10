import 'dart:convert';
import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/all_lessons.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_icon_button.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/show_snake_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CodePage extends StatelessWidget {
  CodePage({
    required this.user,
    required this.lesson,
    super.key,
  });
  UserModel user;
  AllLessons lesson;
  bool isLoading = false;

  late String code;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 350,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    'ادخل الكود هنا.',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (value) {
                      code = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(16)),
                      hintText: 'الكود',
                      labelText: 'الكود',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomIconButton(
                    color: kSecondaryColor,
                    height: 60,
                    width: double.infinity,
                    onTap: () async {
                      try {
                        http.Response response =
                            await http.post(Uri.parse(getCourseByCode), body: {
                          'code': code,
                          'id': user.id,
                        });
                        if (response.statusCode == 200) {
                          Map<String, dynamic> data = jsonDecode(response.body);
                          if (data['status'] == 'false') {
                            return showSnackbar(
                                context, data['error'].toString());
                          } else {
                            showSnackbar(context, 'تم بنجاح');
                            Navigator.of(context).pop();
                          }
                        } else {
                          throw Exception('هناك مشكلة ${response.statusCode}');
                        }
                      } on Exception catch (e) {
                        showSnackbar(context, e.toString());
                      }
                    },
                    child: const Text(
                      'تأكيد',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'الغاء',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
