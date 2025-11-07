import 'package:flutter/material.dart';
import '../../domain/auth_repository.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';

///  Formulaire de connexion + gestion du bouton "Se connecter"
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final authRepository = AuthRepository();

  bool _loading = false;

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      final username = _usernameCtrl.text;
      final password = _passwordCtrl.text;

      bool isLogged = authRepository.login(username, password);

      if (isLogged) {
        //  Navigation vers le Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
      } else {
        //  Message d’erreur si identifiants incorrects
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Identifiants incorrects")),
        );
      }

      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //  Champ de l’utilisateur
          TextFormField(
            controller: _usernameCtrl,
            decoration: const InputDecoration(labelText: "Nom d'utilisateur"),
            validator: (value) =>
                value!.isEmpty ? "Champ obligatoire" : null,
          ),

          const SizedBox(height: 16),

          //  Champ du mot de passe
          TextFormField(
            controller: _passwordCtrl,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Mot de passe"),
            validator: (value) =>
                value!.isEmpty ? "Champ obligatoire" : null,
          ),

          const SizedBox(height: 24),

          //  Bouton de connexion
          ElevatedButton(
            onPressed: _loading ? null : _handleLogin,
            child: _loading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Se connecter"),
          ),
        ],
      ),
    );
  }
}


