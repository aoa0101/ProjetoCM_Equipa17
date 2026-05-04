import 'package:flutter/material.dart';

import 'package:cinelog/user_authentication_screens/authentication_button.dart';
import 'package:cinelog/user_authentication_screens/authentication_input.dart';

import 'package:cinelog/color_scheme.dart';

const gap = SizedBox(height: 22);

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Registar",
                  style: TextStyle(
                    color: SECONDARY_COLOR,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gap,

                AuthenticationInput(hintText:"Username "),
                
                gap,

                AuthenticationInput(hintText:"Email"),

                gap,

                AuthenticationInput(hintText:"Nome", obscure: true),

                gap,

                AuthenticationInput(hintText:"Password", obscure: true),

                gap,

                AuthenticationInput(hintText: "Confirmação da Password", obscure: true),

                gap,

                AuthenticationButton(path: "/", text: "Registar")
              ],
            ),
          ),
        ),
    );
  }
}