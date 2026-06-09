import 'package:flutter/material.dart';

import 'package:cinelog/user_authentication_screens/authentication_button.dart';
import 'package:cinelog/user_authentication_screens/authentication_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cinelog/color_scheme.dart';
import 'package:go_router/go_router.dart';

const gap = SizedBox(height: 22);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _register() async {
    if(_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("As passwords não são iguais!"))
      );
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registo bem sucedido!"))
        );
        context.go('/');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'A password deve ter pelo menos 6 caracteres.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Já existe uma conta para esse email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O email fornecido é inválido.';
      } else {
        errorMessage = 'Ocorreu um erro: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );

    }
  }

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

                AuthenticationInput(hintText:"Username ", controller: _usernameController),
                
                gap,

                AuthenticationInput(hintText:"Email", controller: _emailController),

                gap,

                AuthenticationInput(hintText:"Nome", obscure: false, controller: _nameController),

                gap,

                AuthenticationInput(hintText:"Password", obscure: true, controller: _passwordController),

                gap,

                AuthenticationInput(hintText: "Confirmação da Password", obscure: true, controller: _confirmPasswordController),

                gap,

                AuthenticationButton(text: "Registar", onPressed: _register)
              ],
            ),
          ),
        ),
    );
  }
}