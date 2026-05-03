import 'package:flutter/material.dart';
import 'color_scheme.dart'; // Importem aqui as vossas cores

class OptionsScreenWidget extends StatelessWidget {
  const OptionsScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: APPBAR_BACKGROUND_COLOR,
        iconTheme: IconThemeData(color: SECONDARY_COLOR),
        title: Text('Settings', style: TextStyle(color: SECONDARY_COLOR)),
      ),
      body: Center(
        child: SizedBox(
          width: 289,
          child: Column(
            children: [
              const SizedBox(height: 142),
              MakeOptionButton(Icons.person, "Account"),
              MakeOptionButton(Icons.notifications_none, "Notifications"),
              MakeOptionButton(Icons.lock, "Privacy"),
              MakeOptionButton(Icons.format_color_fill, "Appearence"),
              MakeOptionButton(null, "About Us"),
            ],
          ),
        ),
      ),
    );
  }

  Widget MakeOptionButton(IconData? icon, String buttonText) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF151515),
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: SECONDARY_COLOR, size: 27),
              const Spacer(),
            ],
            Text(buttonText,
                style: TextStyle(color: SECONDARY_COLOR, fontSize: 16)),
            if (icon != null) const Spacer(), // Equilibra o centro
          ],
        ),
      ),
    );
  }
}