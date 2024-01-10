import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField.customFormTextField(
      {this.controller,
        this.validator,
        super.key,
        this.hintText,
        this.prefix,
        this.labelText,
        this.onChanged,
        this.obsecureText = false, required this.textInputType});

  String? labelText;
  String? hintText;
  FormFieldValidator<String>? validator;
  Function(String)? onChanged;
  Widget? prefix;
  bool obsecureText;
  TextEditingController? controller = TextEditingController();
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7,
          ),
        ],
      ),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        keyboardType: textInputType,
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(16),),
          alignLabelWithHint: true,
          focusedBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: kSecondaryColor),
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kSecondaryColor),
            borderRadius: BorderRadius.circular(16),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: kSecondaryColor),
          prefixIcon: prefix,
        ),
      ),
    );
  }
}
