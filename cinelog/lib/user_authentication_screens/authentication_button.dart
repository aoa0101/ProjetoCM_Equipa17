import 'package:cinelog/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthenticationButton extends StatelessWidget {
  ///The path used in context.go() to navigate. 
  final String path;
  
  ///The text inside that will be inside the button.
  final String text;

  const AuthenticationButton({super.key, required this.path, required this.text});

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
          onPressed: () {
              context.go(path);
          },
          child: Text(
            text,
            style: TextStyle(color: Colors.black)),
      ),
    );
  }
}