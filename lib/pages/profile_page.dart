import 'package:elmanasa/models/user_model.dart';
import 'package:elmanasa/widgets/profileWidgets/master_profile_widget.dart';
import 'package:elmanasa/widgets/profileWidgets/profile_card_widget.dart';
import 'package:elmanasa/widgets/profileWidgets/square_profile_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MasterProfileWidget(
                  title: '${user.fname} ${user.lname}',
                  icon: Icons.account_circle,
                  subTitle: 'المعلومات الشخصية',
                  ontap: ()
              {
                Navigator.pushNamed(context, 'EditProfilePage',arguments: user);
              }),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SquareProfileCard(title: 'تعليمات', subTitle: 'تعليمات هامة لتحقيق اقصى استفادة', icon: Icons.integration_instructions_rounded),
                  SquareProfileCard(title: 'تحتاج مساعدة ؟', subTitle: 'تواصل معنا لمزيد من المعلومات', icon: Icons.question_mark_outlined)
                ],
              ),
              const SizedBox(height: 40,),
              ProfileCardWidget(title: 'السياسة والخصوصية', icon: Icons.policy_outlined,ontap: ()
              {
                Navigator.pushNamed(context, 'PrivAndPolicy');
              }),
              ProfileCardWidget(title: 'عن التطبيق', icon: Icons.change_circle_rounded),
              ProfileCardWidget(title: 'تسجيل الخروج', icon: Icons.logout,
                  ontap: ()
              {
                Navigator.pushReplacementNamed(context, 'SplashScreen');
              }),
            ],
          ),
        ),
      ),
    );
  }
}
