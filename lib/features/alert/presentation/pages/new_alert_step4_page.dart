


import 'package:flutter/material.dart';
import 'package:mobile_app/features/alert/presentation/pages/new_alert_step5_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/alert_model.dart';

// import 'new_alert_step5_page.dart';

class NewAlertStep4Page extends StatefulWidget {
  final AlertModel alert;

  const NewAlertStep4Page({super.key, required this.alert});

  @override
  _NewAlertStep4PageState createState() => _NewAlertStep4PageState();
}

class _NewAlertStep4PageState extends State<NewAlertStep4Page> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomCtrl = TextEditingController();
  final TextEditingController prenomCtrl = TextEditingController();
  final TextEditingController telCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController structureCtrl = TextEditingController();

  String? fonction;
  String? langue;

  // Liste des 6 étapes
  final List<String> steps = [
    "Localisation",
    "Événement",
    "Conséquences",
    "Rapporteur",
    "Destinataires",
    "Révision",
  ];

  @override
  void initState() {
    super.initState();
    // Pré-remplir si déjà existant dans le modèle
    nomCtrl.text = widget.alert.rapporteurNom ?? "";
    prenomCtrl.text = widget.alert.rapporteurPrenom ?? "";
    telCtrl.text = widget.alert.rapporteurTelephone ?? "";
    emailCtrl.text = widget.alert.rapporteurEmail ?? "";
    structureCtrl.text = widget.alert.structure ?? "";
    fonction = widget.alert.fonction;
    langue = widget.alert.languePreferee;
  }

  /// Vérifie que tous les champs obligatoires sont remplis
  bool _verifierChamps() {
    if (nomCtrl.text.isEmpty ||
        prenomCtrl.text.isEmpty ||
        telCtrl.text.isEmpty ||
        fonction == null ||
        structureCtrl.text.isEmpty ||
        langue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs obligatoires.")),
      );
      return false;
    }
    return true;
  }

  /// Fonction appelée au clic sur Suivant
  void _onSuivant() {
    if (_verifierChamps()) {
      // Sauvegarde dans le modèle
      widget.alert.rapporteurNom = nomCtrl.text;
      widget.alert.rapporteurPrenom = prenomCtrl.text;
      widget.alert.rapporteurTelephone = telCtrl.text;
      widget.alert.rapporteurEmail = emailCtrl.text;
      widget.alert.fonction = fonction;
      widget.alert.structure = structureCtrl.text;
      widget.alert.languePreferee = langue;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Étape enregistrée avec succès ✅")),
      );

      // TODO : Naviguer vers la page Step 5
        Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => NewAlertStep5Page(alert: widget.alert),
         ),
       );
    }
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.grey),
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Alerte"),
        backgroundColor: AppColors.primary,
      ),
      body: Form(
        key: _formKey,
        onChanged: () => setState(() {}),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Indicateur des 6 étapes ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: steps.asMap().entries.map((entry) {
                  int stepNumber = entry.key + 1;
                  String label = entry.value;

                  Color circleColor;
                  if (stepNumber < 4) {
                    circleColor = Colors.green;
                  } else if (stepNumber == 4) {
                    circleColor = AppColors.primary;
                  } else {
                    circleColor = Colors.white;
                  }

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: circleColor,
                        child: Text(
                          "$stepNumber",
                          style: TextStyle(
                            color: stepNumber == 4 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              Text("Informations du rapporteur", style: AppTextStyles.labelLarge),
              const SizedBox(height: 20),

              // Nom
              TextFormField(
                controller: nomCtrl,
                decoration: _inputDecoration("Nom de famille", Icons.person),
                validator: (v) => v == null || v.isEmpty ? "Champ obligatoire" : null,
              ),
              const SizedBox(height: 16),

              // Prénom
              TextFormField(
                controller: prenomCtrl,
                decoration: _inputDecoration("Prénom", Icons.person_outline),
                validator: (v) => v == null || v.isEmpty ? "Champ obligatoire" : null,
              ),
              const SizedBox(height: 16),

              // Téléphone
              TextFormField(
                controller: telCtrl,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration("+226 XX XX XX XX", Icons.phone),
                validator: (v) => v == null || v.isEmpty ? "Champ obligatoire" : null,
              ),
              const SizedBox(height: 16),

              // Email optionnel
              TextFormField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration("email@example.com", Icons.email),
              ),
              const SizedBox(height: 20),

              // Fonction dropdown
              DropdownButtonFormField<String>(
                value: fonction,
                decoration: _inputDecoration("Fonction", Icons.badge),
                items: [
                  "Point Focal Communal",
                  "Responsable Provincial",
                  "Volontaire",
                  "Autre",
                ].map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                onChanged: (v) => setState(() => fonction = v),
                validator: (v) => v == null ? "Veuillez choisir une fonction" : null,
              ),
              const SizedBox(height: 16),

              // Structure
              TextFormField(
                controller: structureCtrl,
                decoration: _inputDecoration("Nom de la structure", Icons.apartment),
                validator: (v) => v == null || v.isEmpty ? "Champ obligatoire" : null,
              ),
              const SizedBox(height: 20),

              // Langue
              DropdownButtonFormField<String>(
                value: langue,
                decoration: _inputDecoration("Langue préférée", Icons.language),
                items: ["Français", "Mooré", "Dioula", "Fulfuldé"]
                    .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                    .toList(),
                onChanged: (v) => setState(() => langue = v),
                validator: (v) => v == null ? "Veuillez choisir une langue" : null,
              ),
              const SizedBox(height: 32),

              // --- Navigation ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Précédent"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    onPressed: _onSuivant,
                    child: const Text("Suivant"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
