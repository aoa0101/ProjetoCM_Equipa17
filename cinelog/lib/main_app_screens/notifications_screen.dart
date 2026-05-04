import 'package:cinelog/color_scheme.dart';
import 'package:cinelog/main_app_screens/logo_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: LogoAppBar(),

      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [

              const SizedBox(height: 30),

              // Title
              Text(
                "Notificações",
                style: TextStyle(
                  color: SECONDARY_COLOR,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Notifications list
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: const [
                    NotificationCard(
                      title: "Nova estreia!",
                      description:
                          "O teu filme Dune estreia hoje no cinema!",
                    ),
                    NotificationCard(
                      title: "Lembrete!",
                      description:
                          "Tens 3 episódios de The Last of Us para ver!",
                    ),
                    NotificationCard(
                      title: "Nova sugestão!",
                      description:
                          "À tua roleta do sofá sugere Matrix para hoje à noite!",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SECONDARY_COLOR),
      ),
      child: Row(
        children: [
          // Text content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: SECONDARY_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Icon area 
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: EdgeInsets.all(1),
              child: Icon(
                Icons.category,
                color: Colors.black12,
              ),
            ),
          ),
        ),       ],
      ),
    );
  }
}