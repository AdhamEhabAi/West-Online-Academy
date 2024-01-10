import 'package:flutter/material.dart';
import '../../constants.dart';

class MasterProfileWidget extends StatelessWidget {
  MasterProfileWidget({
    required this.icon,
    required this.title,
    this.subTitle,
    this.ontap,
    super.key,
  });

  String? subTitle;
  String? title;
  IconData? icon;
  VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          alignment: Alignment.center, // Center the child within the container
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 5,
              )
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            title: Text(
              title!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              subTitle!,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 12,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
