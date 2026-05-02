import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OptionsScreenWidget extends StatelessWidget {
  const OptionsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: TextButton(
          onPressed: () => context.go("/options"), 
          child: Text("Account")),
      ),
    );
  }
}