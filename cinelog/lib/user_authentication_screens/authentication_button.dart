import 'package:cinelog/color_scheme.dart';
import 'package:flutter/material.dart';
class AuthenticationButton extends StatelessWidget {
  ///The path used in context.go() to navigate. 
  final String text;
  
  ///The text inside that will be inside the button.
  final VoidCallback? onPressed;
  const AuthenticationButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AUTHENTICATION_BUTTON_BACKGROUND_COLOR,
          foregroundColor: SECONDARY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.black)),
      ),
    );
  }
}