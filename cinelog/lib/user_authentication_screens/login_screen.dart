import 'package:flutter/material.dart';

import 'package:cinelog/user_authentication_screens/authentication_button.dart';
import 'package:cinelog/user_authentication_screens/authentication_input.dart';

import 'package:cinelog/color_scheme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    color: SECONDARY_COLOR,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),
                Image.asset(
                  "lib/images/cinelog_logo.png",
                  height: 60,
                ),

                const SizedBox(height: 20),

                AuthenticationInput(hintText: "Username ou Email"),

                const SizedBox(height: 15),

                AuthenticationInput(hintText: "Password", obscure: true),

                const SizedBox(height: 25),

                AuthenticationButton(path: "/", text:  "Log-in"),

                const SizedBox(height: 10),

                AuthenticationButton(path: "/login/register", text:  "Registar"),

                const SizedBox(height: 15),

                Text(
                  "Esqueceu-se da sua password?",
                  style: TextStyle(color: AUTHENTICATION_BUTTON_BACKGROUND_COLOR, fontSize: 10),
                ),

                const SizedBox(height: 5),

                Text(
                  "Termos e Condições",
                  style: TextStyle(color: AUTHENTICATION_BUTTON_BACKGROUND_COLOR, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}