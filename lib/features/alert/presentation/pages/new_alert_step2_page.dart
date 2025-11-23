/*import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/alert_model.dart';
import 'new_alert_step3_page.dart';

/// Étape 2 : Événement
/// Cette page permet de renseigner le type d’événement, ses causes,
/// son ampleur et une description détaillée.
/// Elle reçoit l'objet [AlertModel] de l'étape précédente et le complète.
class NewAlertStep2Page extends StatefulWidget {
  final AlertModel alert;

  const NewAlertStep2Page({super.key, required this.alert});

  @override
  State<NewAlertStep2Page> createState() => _NewAlertStep2PageState();
}

class _NewAlertStep2PageState extends State<NewAlertStep2Page> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCategory;
  List<String> _selectedFactors = [];
  double _amplitude = 0.3;
  String? _periode;
  String? _duree;
  String? _description;

  final List<String> _factors = [
    'Fortes pluies',
    'Vents violents',
    'Chaleur extrême',
    'Mouvement de population',
  ];

  final List<String> _periodes = ['En cours', 'Prévue', 'Terminée'];

  void _goToNextStep() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Met à jour l’objet AlertModel
      widget.alert
        ..typeEvenement = _selectedCategory
        ..facteursDeclencheurs = _selectedFactors
        ..ampleur = _amplitude
        ..periode = _periode
        ..dureeEstimee = _duree
        ..description = _description;

      // Redirection vers l’étape 3
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewAlertStep3Page(alert: widget.alert),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Alerte "),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Type d’événement ---
              Text("Type d'événement", style: AppTextStyles.titleMedium),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Catégorie",
                ),
                items: ['Inondation', 'Sécheresse', 'Tempête', 'Incendie']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val),
                validator: (value) =>
                    value == null ? 'Veuillez sélectionner une catégorie' : null,
              ),
              const SizedBox(height: 20),

              // --- Facteurs déclencheurs ---
              Text("Facteurs déclencheurs", style: AppTextStyles.titleMedium),
              const SizedBox(height: 8),
              ..._factors.map((factor) {
                final isSelected = _selectedFactors.contains(factor);
                return CheckboxListTile(
                  title: Text(factor),
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      val!
                          ? _selectedFactors.add(factor)
                          : _selectedFactors.remove(factor);
                    });
                  },
                );
              }),

              const SizedBox(height: 16),

              // --- Ampleur ---
              Text("Ampleur de l'événement", style: AppTextStyles.titleMedium),
              Slider(
                value: _amplitude,
                min: 0.0,
                max: 1.0,
                divisions: 2,
                label: _amplitude == 0.0
                    ? "Faible"
                    : _amplitude == 0.5
                        ? "Modérée"
                        : "Élevée",
                onChanged: (val) => setState(() => _amplitude = val),
              ),

              // --- Période ---
              const SizedBox(height: 16),
              Text("Période de l'événement", style: AppTextStyles.titleMedium),
              DropdownButtonFormField<String>(
                value: _periode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Période",
                ),
                items: _periodes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _periode = val),
              ),

              const SizedBox(height: 16),

              // --- Durée estimée ---
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Durée estimée",
                  hintText: "Ex : 2 jours, 1 semaine...",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => _duree = val,
              ),
              const SizedBox(height: 16),

              // --- Description détaillée ---
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Description détaillée",
                  hintText: "Décrivez l’événement en détail...",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onSaved: (val) => _description = val,
              ),
              const SizedBox(height: 30),

              // --- Boutons de navigation ---
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
                    ),
                    onPressed: _goToNextStep,
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
*/



/////////////////////////////////////////////////////////////////////////////////



/*import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/alert_model.dart';
import 'new_alert_step3_page.dart';

/// Étape 2 : Événement
/// Cette page permet de définir le type d'événement, les facteurs déclencheurs
/// et l'ampleur de l'événement dans le processus de création d'une alerte.
class NewAlertStep2Page extends StatefulWidget {
  final AlertModel alert; // L'objet alerte transmis depuis l'étape 1

  const NewAlertStep2Page({super.key, required this.alert});

  @override
  _NewAlertStep2PageState createState() => _NewAlertStep2PageState();
}

class _NewAlertStep2PageState extends State<NewAlertStep2Page> {
  final _formKey = GlobalKey<FormState>();

  String? selectedTypeEvenement;
  final List<String> facteursDeclencheurs = [];
  double? ampleur = 0.5;
  String? periode;

  final List<String> typesEvenement = [
    "Inondation",
    "Sécheresse",
    "Tempête",
    "Conflit",
    "Autre"
  ];

  final List<String> facteursPossibles = [
    "Pluie abondante",
    "Température élevée",
    "Mouvement de population",
    "Manque d’eau",
  ];

  final TextEditingController periodeController = TextEditingController();

  // Liste des 6 étapes du processus
  final List<String> steps = [
    "Localisation",
    "Événement",
    "Conséquences",
    "Rapporteur",
    "Destinataires",
    "Révision",
  ];

  void _goToNextStep() {
    if (_formKey.currentState!.validate()) {
      widget.alert.typeEvenement = selectedTypeEvenement;
      widget.alert.facteursDeclencheurs = facteursDeclencheurs;
      widget.alert.ampleur = ampleur;
      widget.alert.periode = periodeController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewAlertStep3Page(alert: widget.alert),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle alerte - Étape 2"),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
                if (stepNumber < 2) {
                  circleColor = Colors.green;
                } else if (stepNumber == 2) {
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
                          color: stepNumber == 2 ? Colors.white : Colors.black,
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

            // --- Titre de l'étape ---
            Text(
              "Étape 2 : Événement",
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: 12),

            // --- Formulaire principal ---
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type d'événement
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Type d'événement",
                      border: OutlineInputBorder(),
                    ),
                    value: selectedTypeEvenement,
                    items: typesEvenement
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      selectedTypeEvenement = value;
                    }),
                    validator: (value) =>
                        value == null ? "Veuillez sélectionner un type" : null,
                  ),
                  const SizedBox(height: 16),

                  // Facteurs déclencheurs
                  Text(
                    "Facteurs déclencheurs",
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: facteursPossibles.map((facteur) {
                      final isSelected =
                          facteursDeclencheurs.contains(facteur);
                      return FilterChip(
                        label: Text(facteur),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              facteursDeclencheurs.add(facteur);
                            } else {
                              facteursDeclencheurs.remove(facteur);
                            }
                          });
                        },
                        selectedColor: AppColors.primary.withOpacity(0.3),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Ampleur (slider)
                  Text(
                    "Ampleur de l'événement : ${ampleur?.toStringAsFixed(2)}",
                    style: AppTextStyles.labelLarge,
                  ),
                  Slider(
                    value: ampleur ?? 0.5,
                    min: 0,
                    max: 1,
                    divisions: 10,
                    label: "${(ampleur! * 100).toInt()}%",
                    onChanged: (value) {
                      setState(() {
                        ampleur = value;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  const SizedBox(height: 16),

                  // Période
                  TextFormField(
                    controller: periodeController,
                    decoration: const InputDecoration(
                      labelText: "Période (ex : Juin - Août 2025)",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Veuillez entrer la période"
                        : null,
                  ),
                  const SizedBox(height: 24),

                  // --- Bouton Suivant ---
                  /*SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _goToNextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Suivant",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),  
  */
                const SizedBox(height: 30),

              // --- Boutons de navigation ---
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
                    ),
                    onPressed: _goToNextStep,
                    child: const Text("Suivant"),
                  ),
                ],
              ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/



//////////////////////////////////////////////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/alert_model.dart';
import 'new_alert_step3_page.dart';

class NewAlertStep2Page extends StatefulWidget {
  final AlertModel alert;

  const NewAlertStep2Page({super.key, required this.alert});

  @override
  State<NewAlertStep2Page> createState() => _NewAlertStep2PageState();
}

class _NewAlertStep2PageState extends State<NewAlertStep2Page> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _facteurs = [
    "Pluie",
    "Sécheresse",
    "Inondation",
    "Feu de brousse",
    "Mouvement de population",
    "Conflit",
  ];

  final List<String> _periodes = ["En cours", "Terminée", "À venir"];

  List<String> _facteursSelectionnes = [];
  double _ampleur = 0.3;
  String? _periode;
  String? _duree;
  String? _description;

   // Liste des 6 étapes du processus
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
    _facteursSelectionnes = widget.alert.facteursDeclencheurs ?? [];
    _ampleur = widget.alert.ampleur ?? 0.3;
    _periode = widget.alert.periode;
    _duree = widget.alert.dureeEstimee;
    _description = widget.alert.description;
  }

  void _onSuivant() {
    if (_facteursSelectionnes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner au moins un facteur déclencheur.")),
      );
      return;
    }

    if (_periode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner une période.")),
      );
      return;
    }

    _formKey.currentState!.save();

    widget.alert.facteursDeclencheurs = _facteursSelectionnes;
    widget.alert.ampleur = _ampleur;
    widget.alert.periode = _periode;
    widget.alert.dureeEstimee = _duree;
    widget.alert.description = _description;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewAlertStep3Page(alert: widget.alert),
      ),
    );
  }

  String _labelAmpleur() {
    if (_ampleur == 0) return "Faible";
    if (_ampleur == 0.5) return "Modérée";
    return "Élevée";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Alert"),
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
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
                if (stepNumber < 2) {
                  circleColor = Colors.green;
                } else if (stepNumber == 2) {
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
                          color: stepNumber == 2 ? Colors.white : Colors.black,
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

            // --- Titre de l'étape ---
            Text(
              "Étape 2 : Événement",
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: 12),

                Text("Facteurs déclencheurs", style: AppTextStyles.titleMedium),
                const SizedBox(height: 8),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.1,
                  children: _facteurs.map((facteur) {
                    final bool isSelected = _facteursSelectionnes.contains(facteur);

                    IconData icon;
                    switch (facteur.toLowerCase()) {
                      case 'pluie':
                        icon = Icons.water_drop;
                        break;
                      case 'sécheresse':
                        icon = Icons.terrain;
                        break;
                      case 'inondation':
                        icon = Icons.waves;
                        break;
                      case 'feu de brousse':
                        icon = Icons.local_fire_department;
                        break;
                      default:
                        icon = Icons.warning_amber_rounded;
                    }

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _facteursSelectionnes.remove(facteur);
                          } else {
                            _facteursSelectionnes.add(facteur);
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.2)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : Colors.grey.shade300,
                            width: 0.7,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                              color: isSelected ? AppColors.primary : Colors.grey.shade400,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Icon(icon, color: isSelected ? AppColors.primary : Colors.grey.shade600, size: 18),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                facteur,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.labelLarge.copyWith(
                                  fontSize: 13,
                                  color: isSelected ? AppColors.primary : Colors.grey.shade800,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Text("Ampleur de l'événement", style: AppTextStyles.titleMedium),
                const SizedBox(height: 8),
                Slider(
                  value: _ampleur,
                  min: 0,
                  max: 1,
                  divisions: 2,
                  label: _labelAmpleur(),
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() {
                      _ampleur = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Faible"),
                    Text("Modérée"),
                    Text("Élevée"),
                  ],
                ),
                const SizedBox(height: 24),
                Text("Période de l'événement", style: AppTextStyles.titleMedium),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _periode,
                  hint: const Text("Sélectionnez une période"),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  items: _periodes.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                  onChanged: (value) => setState(() => _periode = value),
                ),
                const SizedBox(height: 24),
                Text("Durée estimée", style: AppTextStyles.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: _duree,
                  decoration: const InputDecoration(
                    hintText: "Ex: 2 jours, 1 semaine...",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _duree = value,
                ),
                const SizedBox(height: 24),
                Text("Description détaillée", style: AppTextStyles.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: _description,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "Décrivez l’événement en détail...",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _description = value,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(onPressed: () => Navigator.pop(context), child: const Text("Précédent")),
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
      ),
    );
  }
}
