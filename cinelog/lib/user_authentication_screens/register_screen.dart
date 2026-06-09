import 'package:flutter/material.dart';

import 'package:cinelog/user_authentication_screens/authentication_button.dart';
import 'package:cinelog/user_authentication_screens/authentication_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinelog/color_scheme.dart';
import 'package:go_router/go_router.dart';

const gap = SizedBox(height: 22);

// Tela de registro para os usuários, onde eles podem criar uma nova conta
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
// Estado mutável para a tela de registro, onde a lógica de criação de conta é implementada
class _RegisterScreenState extends State<RegisterScreen> {
  // Controladores para os campos de input de registro, permitindo acessar o texto inserido pelo usuário
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


// Função para realizar o processo de registro utilizando o Firebase Authentication e Firestore
  Future<void> _register() async {
    // Verifica se todos os campos de input estão preenchidos, caso contrário exibe uma mensagem de erro
    if(_usernameController.text.isEmpty || _emailController.text.isEmpty || _nameController.text.isEmpty || _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos!"))
      );
      return;
    }
    // Verifica se as senhas inseridas nos campos de password e confirmação de password são iguais, caso contrário exibe uma mensagem de erro
    if(_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("As passwords não são iguais!"))
      );
      return;
    }
    try {
      // Tenta criar um novo usuário com email e senha fornecidos, e em seguida atualiza o nome de exibição do usuário
      final uid = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Atualiza o nome de exibição do usuário recém-criado com o valor inserido no campo de nome
      await uid.user!.updateDisplayName(_nameController.text);

      // Armazena as informações adicionais do usuário (username, nome e email) no Firestore em uma coleção chamada 'users', utilizando o UID do usuário como identificador do documento
      await FirebaseFirestore.instance.collection('users').doc(uid.user!.uid).set({
        'username': _usernameController.text,
        'name': _nameController.text,
        'email': _emailController.text,
      });

      // Se o registro for bem-sucedido, exibe uma mensagem de sucesso e navega para a tela principal da aplicação
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registo bem sucedido!"))
        );
        context.go('/');
      }
    } 
    // Captura e trata as exceções específicas do Firebase Authentication, exibindo mensagens de erro apropriadas para cada tipo de erro
    on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'A password deve ter pelo menos 6 caracteres.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Já existe uma conta para esse email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O email fornecido é inválido.';
      } else {

        // Para outros erros, exibe a mensagem de erro retornada pelo Firebase
        errorMessage = 'Ocorreu um erro: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );
      
    }
    // Captura e trata outras exceções do Firebase, exibindo a mensagem de erro retornada
    on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ocorreu um erro: ${e.message}"))
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
                // Campos de input para username, email, nome, password e confirmação de password utilizando o widget personalizado AuthenticationInput
                AuthenticationInput(hintText:"Username ", controller: _usernameController),
                
                gap,
                // Campo de input para email
                AuthenticationInput(hintText:"Email", controller: _emailController),

                gap,
                // Campo de input para nome
                AuthenticationInput(hintText:"Nome", obscure: false, controller: _nameController),

                gap,
                // Campo de input para password, com a opção de ocultar o texto
                AuthenticationInput(hintText:"Password", obscure: true, controller: _passwordController),

                gap,
                // Campo de input para confirmação de password, com a opção de ocultar o texto
                AuthenticationInput(hintText: "Confirmação da Password", obscure: true, controller: _confirmPasswordController),

                gap,
                // Botão de registro que chama a função _register quando pressionado, utilizando o widget personalizado AuthenticationButton
                AuthenticationButton(text: "Registar", onPressed: _register)
              ],
            ),
          ),
        ),
    );
  }
}