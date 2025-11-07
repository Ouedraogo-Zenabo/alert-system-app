import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

///  Page d’accueil de l’application : Connexion
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Système d'Alerte Précoce",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 35),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
