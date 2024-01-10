import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.width = 120,
      this.onTap,
      this.color = kPrimaryColor,
      required this.text,
      super.key});
  double? width;
  String? text;
  Color? color;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 1),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text!,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              width: 25,
            ),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
