import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

/// ------------------------------------------------------------
/// Stockage local : Sauvegarde du profil pour utilisation hors-ligne.
/// ------------------------------------------------------------
class UserLocalService {
  static const String userKey = "user_profile";

  /// Sauvegarde en cache
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, user.toRawJson());
  }

  /// Chargement local
  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(userKey);

    if (jsonString == null) return null;

    return UserModel.fromRawJson(jsonString);
  }

  /// Efface le profil (ex: déconnexion)
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }
}
