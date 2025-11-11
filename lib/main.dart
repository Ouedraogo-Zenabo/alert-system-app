import 'package:flutter/material.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/alert/presentation/pages/new_alert_step1_page.dart'; // ✅ Import de la route vers l’alerte

void main() {
  runApp(const MyApp());
}

/// Initialisation de l'application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Système d’Alerte Précoce',

      //  Gestion des routes
      routes: {
        "/": (context) => const LoginPage(),
        "/new-alert-step1": (context) => NewAlertStepsPage(),
      },

      //  Définit la page par défaut
      initialRoute: "/",
    );
  }
}
