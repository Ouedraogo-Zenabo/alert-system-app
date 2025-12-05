/*import 'package:flutter/material.dart';
import 'package:mobile_app/features/user/domain/user_repository.dart';
import '../../domain/auth_repository.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';

///  Formulaire de connexion + gestion du bouton "Se connecter"
class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  final String token;

  const LoginForm({
    Key? key,
    required this.userRepository,
    required this.token,
  }) : super(key: key);


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
          MaterialPageRoute(builder: (_) => DashboardPage(
            userRepository: widget.userRepository,
            token: widget.token,
          )),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo en haut du formulaire
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv0QnySrg0ZxVu2txgj5_n6CbzAusWVdH_VA&s',
              width: 120,
              height: 120,
            ),
          ),

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

          //  Bouton de connexion en bleu
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _loading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // <-- bouton bleu
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      ),
                      
                    ),
            ),
          ),
        ],
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:mobile_app/features/user/domain/user_repository.dart';
import '../../domain/auth_repository.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';

/// ------------------------------------------------------------
/// Formulaire Login totalement RESPONSIVE
/// ------------------------------------------------------------
class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  final String token;

  const LoginForm({
    Key? key,
    required this.userRepository,
    required this.token,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final authRepository = AuthRepository();

  bool _loading = false;

  void _handleLogin() async{
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      final email = _emailCtrl.text;
      final password = _passwordCtrl.text;

      bool isLogged = await authRepository.login(email, password);


      if (isLogged) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardPage(
              userRepository: widget.userRepository,
              token: widget.token,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Identifiants incorrects")),
        );
      }

      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;        // Taille de l’écran
    final isSmall = size.width < 400;                // Petit téléphone
    final isTablet = size.width > 600;               // Tablette

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth > 500
            ? 400 // largeur max sur tablette
            : constraints.maxWidth * 0.9; // 90% sur mobile

        return Center(
          child: SingleChildScrollView(       // Empêche l’overflow clavier
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
              maxWidth: contentWidth.toDouble(), 
            ),

              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// ----------------------------
                    /// Logo responsive
                    /// ----------------------------
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv0QnySrg0ZxVu2txgj5_n6CbzAusWVdH_VA&s',
                        width: isTablet ? 150 : 110,
                        height: isTablet ? 150 : 110,
                        fit: BoxFit.contain,
                      ),
                    ),

                    /// ----------------------------
                    /// Champ Nom utilisateur
                    /// ----------------------------
                    TextFormField(
                      controller: _emailCtrl,
                      decoration:
                          const InputDecoration(labelText: "Adresse mail"),
                      validator: (value) =>
                          value!.isEmpty ? "Champ obligatoire" : null,
                    ),

                    const SizedBox(height: 16),

                    /// ----------------------------
                    /// Champ Mot de passe
                    /// ----------------------------
                    TextFormField(
                      controller: _passwordCtrl,
                      obscureText: true,
                      decoration:
                          const InputDecoration(labelText: "Mot de passe"),
                      validator: (value) =>
                          value!.isEmpty ? "Champ obligatoire" : null,
                    ),

                    const SizedBox(height: 24),

                    /// ----------------------------
                    /// Bouton Connexion Responsive
                    /// ----------------------------
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding:
                              const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _loading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                "Se connecter",
                                style: TextStyle(
                                  fontSize: isSmall ? 14 : 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

