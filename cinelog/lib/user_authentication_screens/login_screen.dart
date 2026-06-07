import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cinelog/user_authentication_screens/authentication_button.dart';
import 'package:cinelog/user_authentication_screens/authentication_input.dart';

import 'package:cinelog/color_scheme.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();
  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      if (mounted) {
        context.go( '/');
      };
    } on FirebaseAuthException catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao fazer login: ${e.message}"))
      );
    }
  }
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

                AuthenticationInput(hintText: "Username ou Email", controller: usernameController,),

                const SizedBox(height: 15),

                AuthenticationInput(hintText: "Password", obscure: true, controller: passwordController,),

                const SizedBox(height: 25),

                AuthenticationButton(text: "Log-in", onPressed: () => _login()),

                const SizedBox(height: 10),

                AuthenticationButton(text: "Registar", onPressed: () {context.go('/login/register');}),

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