import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_light_Styles.dart';
import 'package:todo_app/core/utils/colors_Manager.dart';

typedef Validator = String? Function(String?);

class CustomField extends StatelessWidget {
  CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.isSecure = false,
    this.keyboardType = TextInputType.text,
  });

  String hintText;
  TextEditingController controller;
  Validator validator;
  TextInputType keyboardType;
  bool isSecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isSecure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: ApplightStyle.hintTitle,
        fillColor: ColorsManager.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10, // Adjust this value to make it smaller
          horizontal: 15,
        ),
      ),
    );
  }
}
