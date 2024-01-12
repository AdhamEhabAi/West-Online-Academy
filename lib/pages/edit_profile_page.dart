import 'package:elmanasa/constants.dart';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/models/year_model.dart';
import 'package:elmanasa/pages/register_page.dart';
import 'package:elmanasa/services/get_all_years.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_button.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_textfield.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController passController = TextEditingController();
  late String dropDownValue = 'اختر الصف';
  late String classId;
  @override
  Widget build(BuildContext context) {
    UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تعديل الملف الشخصي',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kSecondaryColor,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              children: [
                CustomTextField.customFormTextField(
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'رجاءً ادخل الاسم الاول ';
                  //   }
                  //   return null;
                  // },
                  hintText: user.fname,
                  onChanged: (value) {},
                  labelText: user.fname,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField.customFormTextField(
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'رجاءً ادخل الاسم الثاني ';
                  //   }
                  //   return null;
                  // },
                  hintText: user.lname,
                  labelText: user.lname,
                  textInputType: TextInputType.name,
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField.customFormTextField(
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'رجاءً ادخل رقم التليفون ';
                  //   }
                  //   return null;
                  // },
                  hintText: user.fnum,
                  labelText: user.fnum,
                  textInputType: TextInputType.phone,
                  prefix: const Icon(
                    Icons.phone,
                    color: kPrimaryColor,
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField.customFormTextField(
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'رجاءًادخل الايميل';
                  //   } else {
                  //     return validateEmail(value);
                  //   }
                  // },
                  textInputType: TextInputType.emailAddress,
                  labelText: user.uname,
                  hintText: user.uname,
                  prefix: const Icon(Icons.email, color: kPrimaryColor),
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField.customFormTextField(
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'رجاءً ادخل كلمة المرور';
                  //   }
                  //   return null;
                  // },
                  obsecureText: true,
                  textInputType: TextInputType.visiblePassword,
                  controller: passController,
                  labelText: 'كلمة المرور الجديده',
                  hintText: 'ادخل كلمة المرور',
                  prefix: const Icon(Icons.lock_outline_rounded,
                      color: kPrimaryColor),
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField.customFormTextField(
                    validator: (value) {
                      if (value != passController.text) {
                        return 'ادخل كلمة المرور نفسها';
                      }
                      return null;
                    },
                    onChanged: (value) {},
                    textInputType: TextInputType.visiblePassword,
                    prefix: const Icon(Icons.lock_outline_rounded),
                    obsecureText: true,
                    hintText: 'تأكيد كلمة المرور',
                    labelText: 'تأكيد كلمة المرور'),
                const SizedBox(
                  height: 20,
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
                  controller: passController,
                  labelText: 'ادخل كلمة المرور القديمه',
                  hintText: 'ادخل كلمة المرور القديمه',
                  prefix: const Icon(Icons.lock_outline_rounded,
                      color: kPrimaryColor),
                  onChanged: (value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<List<Year>>(
                  future: AllYearsService().getAllYears(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null) {
                      return const Text('Data is null');
                    } else {
                      List<Year> years = snapshot.data!;
                      return DropdownButtonFormField<String>(
                        validator: validateDropDown,
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
                        style: const TextStyle(
                            color: kSecondaryColor, fontSize: 16),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  width: double.infinity,
                  color: kSecondaryColor,
                  text: 'تأكيد',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
