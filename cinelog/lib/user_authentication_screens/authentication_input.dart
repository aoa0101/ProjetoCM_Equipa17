import 'package:cinelog/color_scheme.dart';
import 'package:flutter/material.dart';

class AuthenticationInput extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController controller;

  const AuthenticationInput({super.key, required this.hintText, this.obscure = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: SECONDARY_COLOR),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: SECONDARY_COLOR.withValues(alpha: .6)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SECONDARY_COLOR.withValues(alpha: .4)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SECONDARY_COLOR),
        ),
      ),
    );
  }
}