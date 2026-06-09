import 'package:cinelog/color_scheme.dart';
import 'package:flutter/material.dart';

// Widget personalizado e reutilizavel para os botões de autenticação (login e registo)
class AuthenticationButton extends StatelessWidget {
  //texto apresentado no botão
  final String text;
  
  //função a ser executada quando o botão for pressionado
  final VoidCallback? onPressed;
  const AuthenticationButton({super.key, required this.text, required this.onPressed});

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
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.black)),
      ),
    );
  }
}