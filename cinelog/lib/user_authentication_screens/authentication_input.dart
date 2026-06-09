import 'package:cinelog/color_scheme.dart';
import 'package:flutter/material.dart';

// Widget personalizado e reutilizavel para os campos de input de autenticação (login e registo)
class AuthenticationInput extends StatelessWidget {
  //texto apresentado como dica dentro do campo de input
  final String hintText;
  //indica se o texto deve ser ocultado (útil para campos de password)
  final bool obscure;
  //controlador para gerenciar o texto inserido no campo de input
  final TextEditingController controller;

  const AuthenticationInput({super.key, required this.hintText, this.obscure = false, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: SECONDARY_COLOR),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: SECONDARY_COLOR.withValues(alpha: .6)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SECONDARY_COLOR.withValues(alpha: .4)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SECONDARY_COLOR),
        ),
      ),
    );
  }
}