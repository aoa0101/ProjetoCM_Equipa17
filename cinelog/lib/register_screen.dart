import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'color_scheme.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                  "Registar",
                  style: TextStyle(
                    color: SECONDARY_COLOR,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),

                _input("Username "),
                
                const SizedBox(height: 20),

                _input("Email"),

                const SizedBox(height: 15),

                _input("Nome", obscure: true),

                const SizedBox(height: 25),

                _input("Password", obscure: true),

                const SizedBox(height: 25),

                _input("Confirmação da Password", obscure: true),

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
                    child: const Text("Registar"),
                  ),
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