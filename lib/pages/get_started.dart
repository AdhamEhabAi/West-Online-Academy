import 'package:elmanasa/constants.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_button.dart';
import 'package:flutter/material.dart';
import 'sign_in_page.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'رحلة تعلم افضل, المستقبل  يبدأ من هنا',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  // const Spacer(flex: 1),
                  const Text(
                    'على منصتنا، نقدم لكم أدوات وموارد تعليمية مبتكرة تمكنكم من استكشاف عوالم جديدة وتطوير قدراتكم بشكل شامل.',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo.jpeg',
                    width: 360,
                    height: 360,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      CustomButton(
                        width: 180,
                        text: 'ابدأ الأن',
                        onTap: () {
                          showGeneralDialog(
                            barrierDismissible: true,
                            barrierLabel: "Sign In",
                            context: context,
                            pageBuilder: (context, _, __) => const SignInPage(),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
