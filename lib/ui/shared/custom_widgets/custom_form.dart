import 'package:albisharaa/ui/shared/colors.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.fillColor,
    required this.hintTextColor,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.prefixIconColor,
    this.maxHeight,
    this.maxWidth,
  });

  final String hintText;
  final TextEditingController controller;
  final Color? fillColor;
  final Color? hintTextColor;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final double? maxHeight;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      // onChanged: myValidator,
      controller: controller,
      validator: validator,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? screenHieght(15),
          maxWidth: maxWidth ?? screenWidth(1.1),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.transparentColor,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        hintStyle: TextStyle(
          color: hintTextColor,
        ),
        hintText: hintText,
        fillColor: fillColor,
      ),
      keyboardType: keyboardType ?? TextInputType.text,
    );
  }
}
