import 'package:flutter/material.dart';

class CustomCountrySquare extends StatelessWidget {
  CustomCountrySquare(
      {super.key, required this.text, required this.color, this.onTap});
  final String? text;
  final Color? color;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 110,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: 10,),
            const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
            ),
            Text(
              text!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
