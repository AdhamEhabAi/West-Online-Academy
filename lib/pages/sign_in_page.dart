import 'dart:convert';
import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_button.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_textfield.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/email_validator.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/show_snake_bar.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;


class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
  });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late String userName , passWord;
  bool isLoading = false;
  late final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Center(
        child: Container(
          height: 620,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
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
                    const Text(
                      'تسجيل الدخول',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                    const Text(
                      'مرحبًا بك! الرجاء تسجيل الدخول للوصول إلى حسابك.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextField.customFormTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'رجاءًادخل الايميل';
                                } else {
                                  return validateEmail(value);
                                }
                              },
                              textInputType: TextInputType.emailAddress,
                              onChanged: (value)
                              {
                                userName = value;
                              },
                              labelText: 'البريد الالكتروني',
                              hintText: 'ادخل البريد الالكتروني',
                              prefix:
                                  const Icon(Icons.email, color: kPrimaryColor),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField.customFormTextField(
                              validator: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'رجاءً ادخل كلمة المرور';
                                }return null;
                              },
                              obsecureText: true,
                              textInputType: TextInputType.visiblePassword,
                              onChanged: (value)
                              {
                                passWord = value;
                              },
                              labelText: 'كلمة المرور',
                              hintText: 'ادخل كلمة المرور',
                              prefix: const Icon(Icons.lock_outline_rounded,
                                  color: kPrimaryColor),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                                onTap: () async {
                                  if(formKey.currentState!.validate())
                                  {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      http.Response response = await http.post(
                                          Uri.parse(
                                              signInApi),
                                          body: {
                                            'username': userName,
                                            'password': passWord,
                                          });
                                      if (response.statusCode == 200) {
                                        Map<String, dynamic> data =
                                        jsonDecode(response.body);
                                          if(data['status'] == 'false')
                                          {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            return showSnackbar(context, 'اسم المستخدم او كلمه السر خطء');
                                          }else {
                                            user = UserModel(
                                                id: data['id'],
                                                fname: data['fname'],
                                                lname: data['lname'],
                                                img: data['img'],
                                                fnum: data['fnum'],
                                                country: data['country'],
                                                uname: data['uname'],
                                                upass: data['upass'],
                                                yr: data['yr']);
                                            showSnackbar(context, 'تم تسجيل الدخول بنجاح');
                                            Navigator.pushReplacementNamed(
                                                context, 'NavBar',arguments: user);
                                            setState(() {
                                              isLoading = false;
                                            });

                                          }
                                      } else {
                                        throw Exception(
                                            'هناك مشكلة ${response.statusCode}');
                                      }
                                    } on Exception catch (e) {
                                      showSnackbar(context, e.toString());
                                    }

                                  }
                                },
                                text: 'تسجيل الدخول',
                                color: kSecondaryColor,
                                width: double.infinity),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Expanded(child: Divider()),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'أو',
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ),
                                Expanded(child: Divider()),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              text: 'انشاء حساب',
                              color: kPrimaryColor,
                              width: double.infinity,
                              onTap: () {
                                Navigator.pushNamed(context, 'RegisterPage');
                              },
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
