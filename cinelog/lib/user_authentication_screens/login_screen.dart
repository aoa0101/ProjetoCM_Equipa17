import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cinelog/user_authentication_screens/authentication_button.dart';
import 'package:cinelog/user_authentication_screens/authentication_input.dart';

import 'package:cinelog/color_scheme.dart';
import 'package:go_router/go_router.dart';

// Tela de login para os usuários 
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  //cria o estado mutável para a tela de login
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Estado mutável para a tela de login, onde a lógica de autenticação é implementada
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController =TextEditingController();
  final TextEditingController passwordController =TextEditingController();


  //Realiza o processo de login utilizando o Firebase Authentication
  Future<void> _login() async {
    try {
      // Tenta autenticar o usuário com email e senha fornecidos
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );

      // Se a autenticação for bem-sucedida, exibe uma mensagem de sucesso e navega para a tela principal
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login bem sucedido!"))
        );
        // Navega para a tela principal da aplicação
        context.go( '/');
      };
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Verifica o código de erro retornado pelo Firebase e define uma mensagem de erro apropriada
      if (e.code == 'user-not-found') {
        errorMessage = 'Nenhum usuário encontrado para esse email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Senha incorreta para esse email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O email fornecido é inválido.';
      } else {
        errorMessage = 'Ocorreu um erro: ${e.message}';
      }

      // Exibe a mensagem de erro em um SnackBar para informar o usuário sobre o problema ocorrido durante o login
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
              // Campos de input para email e senha utilizando o widget personalizado AuthenticationInput
                AuthenticationInput(hintText: "Email", controller: usernameController,),

                const SizedBox(height: 15),
              // Campo de input para senha, com a opção de ocultar o texto utilizando o widget personalizado AuthenticationInput
                AuthenticationInput(hintText: "Password", obscure: true, controller: passwordController,),

                const SizedBox(height: 25),
              // Botão de login que chama a função _login quando pressionado, utilizando o widget personalizado AuthenticationButton
                AuthenticationButton(text: "Log-in", onPressed: () => _login()),

                const SizedBox(height: 10),
              // Botão para navegar para a tela de registro, utilizando o widget personalizado AuthenticationButton
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