import 'dart:convert';
import 'package:elmanasa/models/year_model.dart';
import 'package:elmanasa/services/get_all_years.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_button.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_textfield.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_country.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/email_validator.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/show_snake_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Color color = kSecondaryColor;
  GlobalKey<FormState> formKey = GlobalKey();
  String country = '0';
  late String userFname, userLname, userFnum, userLnum, userEmail, userPassword;
  bool isLoading = false;
  late String dropDownValue = 'اختر الصف';
  late String classId;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'حساب جديد',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                    const Text(
                      'الرجاء إدخال المعلومات المطلوبة لإنشاء حساب جديد.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextField.customFormTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'رجاءً ادخل الاسم الاول';
                                }
                                return null;
                              },
                              hintText: 'الاسم الاول',
                              onChanged: (value) {
                                userFname = value;
                              },
                              labelText: 'الاسم الاول',
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField.customFormTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'رجاءً ادخل الاسم الثاني ';
                                }
                                return null;
                              },
                              hintText: 'الاسم الثاني',
                              labelText: 'الاسم الثاني',
                              textInputType: TextInputType.name,
                              onChanged: (value) {
                                userLname = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField.customFormTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'رجاءً ادخل رقم التليفون ';
                                }
                                return null;
                              },
                              hintText: 'رقم التليفون',
                              labelText: 'رقم التليفون',
                              textInputType: TextInputType.phone,
                              prefix: const Icon(
                                Icons.phone,
                                color: kPrimaryColor,
                              ),
                              onChanged: (value) {
                                userFnum = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField.customFormTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'رجاءً ادخل رقم تليفون ولي الامر ';
                                }
                                return null;
                              },
                              hintText: 'رقم تليفون ولي الامر',
                              labelText: 'رقم تليفون ولي الامر',
                              textInputType: TextInputType.phone,
                              prefix: const Icon(
                                Icons.phone,
                                color: kPrimaryColor,
                              ),
                              onChanged: (value) {
                                userLnum = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField.customFormTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'رجاءًادخل الايميل';
                                } else {
                                  return validateEmail(value);
                                }
                              },
                              textInputType: TextInputType.emailAddress,
                              labelText: 'البريد الالكتروني',
                              hintText: 'ادخل البريد الالكتروني',
                              prefix:
                                  const Icon(Icons.email, color: kPrimaryColor),
                              onChanged: (value) {
                                userEmail = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField.customFormTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'رجاءً ادخل كلمة المرور';
                                }
                                return null;
                              },
                              obsecureText: true,
                              textInputType: TextInputType.visiblePassword,
                              labelText: 'كلمة المرور',
                              hintText: 'ادخل كلمة المرور',
                              prefix: const Icon(Icons.lock_outline_rounded,
                                  color: kPrimaryColor),
                              onChanged: (value) {
                                userPassword = value;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<List<Year>>(
                              future: AllYearsService().getAllYears(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.data == null) {
                                  return const Text('Data is null');
                                } else {
                                  List<Year> years = snapshot.data!;
                                  return DropdownButtonFormField<String>(
                                    validator: (value) => validateDropDown(value),
                                    isExpanded: true,
                                    value: dropDownValue,
                                    items: snapshot.hasData
                                        ? [
                                      const DropdownMenuItem<String>(
                                        value: 'اختر الصف',
                                        child: Text('اختر الصف'),
                                      ),
                                      ...snapshot.data!.map((year) {
                                        return DropdownMenuItem<String>(
                                          value: year.className,
                                          child: Text(year.className),
                                        );
                                      }).toList()
                                    ]
                                        : [],
                                    onChanged: (String? selectedValue) {
                                      setState(() {
                                        dropDownValue = selectedValue!;
                                        classId = years
                                            .firstWhere(
                                              (year) => year.className == selectedValue,
                                        )
                                            .id;
                                      });
                                    },
                                    icon: const Icon(Icons.menu, color: kSecondaryColor),
                                    style: const TextStyle(color: kSecondaryColor, fontSize: 16),
                                  );


                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomCountrySquare(
                                  onTap: () {
                                    setState(() {
                                      country = '1';
                                    });
                                  },
                                  text: 'مصر',
                                  color: country == '1'
                                      ? kPrimaryColor
                                      : kSecondaryColor,
                                ),
                                CustomCountrySquare(
                                  text: 'السعودية',
                                  onTap: () {
                                    setState(() {
                                      country = '2';
                                    });
                                  },
                                  color: country == '2'
                                      ? kPrimaryColor
                                      : kSecondaryColor,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    http.Response response = await http
                                        .post(Uri.parse(signUpApi), body: {
                                      'fname': userFname,
                                      'lname': userLname,
                                      'fnum': userFnum,
                                      'lnum': userLnum,
                                      'username': userEmail,
                                      'password': userPassword,
                                      'class': classId,
                                      'country': country,
                                    });
                                    if (response.statusCode == 200) {
                                      Map<String, dynamic> data =
                                          jsonDecode(response.body);
                                      for (var item in data.keys) {
                                        if (item == 'error') {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          return showSnackbar(context,
                                              data[item][0].toString());
                                        }
                                      }
                                    } else {
                                      throw Exception(
                                          'هناك مشكلة ${response.statusCode}');
                                    }
                                  } on Exception catch (e) {
                                    showSnackbar(context, e.toString());
                                  }
                                  showSnackbar(context, 'تم التسجيل بنجاح');
                                  Navigator.pop(context);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              text: 'انشاء حساب',
                              color: kSecondaryColor,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String? validateDropDown(String? value) {
  if (value == null || value == 'اختر الصف') {
    return 'يرجى اختيار الصف'; // Replace this message with your desired error message
  }
  return null; // Return null if the value is valid
}
