import 'package:elmanasa/constants.dart';
import 'package:elmanasa/widgets/buttonsAndTextFields/custom_icon_button.dart';
import 'package:flutter/material.dart';

class EnrollBottomSheet extends StatelessWidget {
  const EnrollBottomSheet({required this.onTabSub,Key? key, required this.txt, required this.icon}) : super(key: key);
  final VoidCallback onTabSub;
  final String txt;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomIconButton(
              onTap: onTabSub,
              color: kPrimaryColor,
              height: 45,
              width: 45,
              child: Text(
                txt,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          CustomIconButton(
            onTap: () {},
            height: 45,
            width: 45,
            child: Icon(
              icon,
              color: Colors.pink,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}