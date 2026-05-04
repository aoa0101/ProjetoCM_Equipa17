import 'package:flutter/material.dart';

import 'package:cinelog/color_scheme.dart';

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
              _makeOptionButton(Icons.person, "Conta"),
              _makeOptionButton(Icons.notifications_none, "Notificações"),
              _makeOptionButton(Icons.lock, "Privacidade"),
              _makeOptionButton(Icons.format_color_fill, "Aparência"),
              _makeOptionButton(null, "Sobre nós", customWidth: 160),
            ],
          ),
        ),
      ),
    );
  }

  Widget _makeOptionButton(IconData? icon, String buttonText, {double customWidth = double.infinity}) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: SizedBox(
        width: customWidth,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D2D2D), 
              minimumSize: const Size(0, 55),
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
              if (icon != null) const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}