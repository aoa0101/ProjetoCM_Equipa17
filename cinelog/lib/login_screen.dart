import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'color_scheme.dart';

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

                _input("Username ou Email"),

                const SizedBox(height: 15),

                _input("Password", obscure: true),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BUTTON_BACKGROUND_COLOR,
                      foregroundColor: SECONDARY_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text("Log-in"),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BUTTON_BACKGROUND_COLOR,
                      foregroundColor: SECONDARY_COLOR,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      context.go('/login/register');
                    },
                    child: const Text("Registar"),
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  "Esqueceu-se da sua password?",
                  style: TextStyle(color: BUTTON_BACKGROUND_COLOR, fontSize: 10),
                ),

                const SizedBox(height: 5),

                Text(
                  "Termos e Condições",
                  style: TextStyle(color: BUTTON_BACKGROUND_COLOR, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(String hint, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      style: TextStyle(color: SECONDARY_COLOR),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: SECONDARY_COLOR.withOpacity(0.6)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SECONDARY_COLOR.withOpacity(0.4)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SECONDARY_COLOR),
        ),
      ),
    );
  }
}