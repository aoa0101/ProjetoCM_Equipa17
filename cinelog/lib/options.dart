import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'color_scheme.dart'; // Importem aqui as vossas cores

class OptionsScreenWidget extends StatelessWidget {
  const OptionsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: APPBAR_BACKGROUND_COLOR,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: SECONDARY_COLOR),
          onPressed: () => context.go('/'),
        ),
        title: Text('Settings', style: TextStyle(color: SECONDARY_COLOR)),
      ),
      body: Center(
        child: Text("Ecrã de Definições", style: TextStyle(color: Colors.white)), 
      ),
    );
  }
}