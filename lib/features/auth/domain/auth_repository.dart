/*import '../data/auth_service.dart';

///  Gère la logique métier de l’authentification.
/// Utilise AuthService pour vérifier les identifiants.
class AuthRepository {
  final AuthService authService = AuthService();

  bool login(String username, String password) {
    return authService.login(username, password);
  }
}*/

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl = "http://197.239.116.77:3000/api/v1";

  Future<bool> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        print("Connexion OK : ${response.body}");
        return true;
      } else {
        print("Erreur login (${response.statusCode}) : ${response.body}");
        return false;
      }
    } catch (e) {
      print("Erreur réseau : $e");
      return false;
    }
  }
}

