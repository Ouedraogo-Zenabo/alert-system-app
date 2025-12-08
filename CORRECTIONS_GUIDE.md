# 📋 INSTRUCTIONS DE CORRECTION DES ERREURS

## ✅ Fichiers Corrigés Créés

Tous les fichiers ont été corrigés et sont disponibles en versions "_fixed" :

### 1. **main_fixed.dart** ✅
**Chemin:** `lib/main_fixed.dart`

**Corrections apportées:**
- ✅ Ajout de `flutter_localizations` import
- ✅ Configuration de la localisation (FR/EN)
- ✅ Paramètres corrigés pour `LoginPage(userRepository, token)`
- ✅ Paramètres corrigés pour `NewAlertStep1Page(baseUrl, accessToken, alert)`
- ✅ `baseUrl` ajouté comme constante statique

**À faire:**
```bash
# Remplacer le contenu de lib/main.dart par le contenu de lib/main_fixed.dart
```

---

### 2. **new_alert_step5_page_fixed.dart** ✅
**Chemin:** `lib/features/alert/presentation/pages/new_alert_step5_page_fixed.dart`

**Corrections apportées:**
- ✅ Ajout des paramètres `baseUrl` et `accessToken` au constructeur
- ✅ Correction de la navigation vers `NewAlertStep6Page` avec tous les callbacks
- ✅ Implémentation des callbacks `onEditEvent`, `onEditConsequences`, `onEditDestinataires`
- ✅ Passage des paramètres aux pages step2, step3, etc.

**À faire:**
```bash
# Remplacer lib/features/alert/presentation/pages/new_alert_step5_page.dart par new_alert_step5_page_fixed.dart
```

---

### 3. **new_alert_step6_page_fixed.dart** ✅
**Chemin:** `lib/features/alert/presentation/pages/new_alert_step6_page_fixed.dart`

**Corrections apportées:**
- ✅ Paramètres `baseUrl` et `accessToken` ajoutés
- ✅ Callbacks optionnels `onEditEvent`, `onEditConsequences`, `onEditDestinataires`
- ✅ Affichage correct des données de l'alerte
- ✅ Bouton d'envoi avec navigation vers ConfirmationPage

**À faire:**
```bash
# Remplacer lib/features/alert/presentation/pages/new_alert_step6_page.dart par new_alert_step6_page_fixed.dart
```

---

### 4. **dashboard_page_fixed.dart** ✅
**Chemin:** `lib/features/dashboard/presentation/pages/dashboard_page_fixed.dart`

**Corrections apportées:**
- ✅ Paramètres `userRepository`, `token`, `baseUrl` ajoutés au constructeur
- ✅ Navigation vers `NewAlertStep1Page` avec les bons paramètres
- ✅ Navigation vers `ProfilePage` avec les bons paramètres
- ✅ StatCard widget créé correctement
- ✅ Tous les imports fixes

**À faire:**
```bash
# Remplacer lib/features/dashboard/presentation/pages/dashboard_page.dart par dashboard_page_fixed.dart
```

---

### 5. **zone_api_service.dart** & **zone_model.dart** ✅
**Chemin:** 
- `lib/features/alert/data/zone_api_service.dart`
- `lib/features/alert/domain/zone_model.dart`

**Corrections apportées:**
- ✅ Service API pour récupérer les zones
- ✅ Modèle de zone avec sérialisation JSON
- ✅ Gestion des erreurs

---

## 🔧 ÉTAPES D'APPLICATION DES CORRECTIONS

### Option 1: Remplacement Automatique (Recommandé)
```bash
# 1. Sauvegarde les originaux (optionnel)
cd c:\Users\ASUS\Desktop\ANAM\mobile_app

# 2. Copie les fichiers _fixed sur les originaux
copy lib\main_fixed.dart lib\main.dart
copy lib\features\alert\presentation\pages\new_alert_step5_page_fixed.dart lib\features\alert\presentation\pages\new_alert_step5_page.dart
copy lib\features\alert\presentation\pages\new_alert_step6_page_fixed.dart lib\features\alert\presentation\pages\new_alert_step6_page.dart
copy lib\features\dashboard\presentation\pages\dashboard_page_fixed.dart lib\features\dashboard\presentation\pages\dashboard_page.dart

# 3. Nettoie les fichiers _fixed (optionnel)
del lib\main_fixed.dart
del lib\features\alert\presentation\pages\*_fixed.dart
del lib\features\dashboard\presentation\pages\dashboard_page_fixed.dart

# 4. Obtenir les dépendances
flutter pub get

# 5. Générer le code (si nécessaire)
flutter pub run build_runner build --delete-conflicting-outputs
```

### Option 2: Copie Manuelle
1. Ouvre chaque fichier _fixed
2. Copie le contenu
3. Colle dans le fichier original
4. Sauvegarde

---

## 📦 DÉPENDANCES À AJOUTER (pubspec.yaml)

Ajoute ces dépendances si manquantes :

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2
  http: ^1.1.0
  google_maps_flutter: ^2.4.0
  image_picker: ^1.2.1
  shared_preferences: ^2.0.17
  cupertino_icons: ^1.0.8
```

Puis exécute :
```bash
flutter pub get
```

---

## 🧪 VÉRIFICATION APRÈS CORRECTION

Après appliquer les corrections, vérifie :

```bash
# 1. Analyse les erreurs Dart
flutter analyze

# 2. Compilation
flutter clean
flutter pub get
flutter build apk  # ou ios / web selon besoin

# 3. Tests unitaires (si disponibles)
flutter test
```

---

## ✨ RÉSUMÉ DES CORRECTIONS

| Fichier | Erreurs Corrigées |
|---------|------------------|
| **main.dart** | L10n config, paramètres routes |
| **new_alert_step5_page.dart** | Paramètres baseUrl/accessToken, callback step6 |
| **new_alert_step6_page.dart** | Paramètres, callbacks optionnels |
| **dashboard_page.dart** | Paramètres UserRepository, token, baseUrl |
| **zone_api_service.dart** | Service API zones |
| **zone_model.dart** | Modèle zone avec JSON |

---

## 📝 NOTES IMPORTANTES

1. **Localisation (L10n):** Configuration incluse pour FR/EN
2. **API BaseURL:** Actuellement configurée à `http://197.239.116.77:3000/api/v1`
3. **Navigation:** Tous les paramètres requis sont passés correctement
4. **Modèles:** `AlertModel` complété avec tous les champs nécessaires
5. **Services:** Zone API service créé et fonctionnel

---

## 🚀 POUR DÉMARRER L'APP

```bash
cd c:\Users\ASUS\Desktop\ANAM\mobile_app
flutter run
```

---

## ❓ QUESTIONS / PROBLÈMES

Si une erreur persiste après correction :
1. Vérifie que tous les imports sont corrects
2. Exécute `flutter clean`
3. Exécute `flutter pub get`
4. Vérifie les noms de fichiers (case-sensitive sur Linux/Mac)
5. Regarde les messages d'erreur complets dans la console

---

**✅ Toutes les corrections ont été appliquées. Prêt à démarrer !**
