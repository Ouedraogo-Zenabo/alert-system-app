import '../data/auth_service.dart';

///  Gère la logique métier de l’authentification.
/// Utilise AuthService pour vérifier les identifiants.
class AuthRepository {
  final AuthService authService = AuthService();

  bool login(String username, String password) {
    return authService.login(username, password);
  }
}
