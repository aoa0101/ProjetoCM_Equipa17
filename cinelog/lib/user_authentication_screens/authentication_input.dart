import 'package:cinelog/color_scheme.dart';
import 'package:flutter/material.dart';

class AuthenticationInput extends StatelessWidget {
  ///The text inside the input box to indicate what to put inside it.
  final String hintText;

  ///Boolean to decide if the text inside the input is hidden (`true`) or not (`false`). 
  final bool obscure;

  const AuthenticationInput({super.key, required this.hintText, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
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