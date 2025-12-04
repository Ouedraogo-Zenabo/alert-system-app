


///////////////////////////////////////////////////////////////////////////////////////////////


// lib/features/alert/presentation/pages/new_alert_step1_page.dart

/*import 'package:flutter/material.dart';
import 'package:mobile_app/features/alert/domain/alert_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/coustom_button_step1.dart';
import 'new_alert_step2_page.dart';

class NewAlertStep1Page extends StatefulWidget {
  

  final AlertModel alert;

  const NewAlertStep1Page({
    super.key,
    required this.alert,
  });

  @override
  _NewAlertStep1PageState createState() => _NewAlertStep1PageState();
}

class _NewAlertStep1PageState extends State<NewAlertStep1Page> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  String? selectedRegion;
  String? selectedProvince;
  String? selectedCommune;

  final Map<String, Map<String, List<String>>> regionData = {
    "Boucle du Mouhoun": {"Balé": ["Sibi"]},
    "Centre-Nord": {"Sanmatenga": ["Korsimoro", "Ziga"]},
    "Nord": {"Passoré": ["Kirsi", "Gomponsson"]},
  };

  final List<String> steps = [
    "Localisation",
    "Événement",
    "Conséquences",
    "Rapporteur",
    "Destinataires",
    "Revision",
  ];

  bool validateForm() {
    return dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty &&
        selectedRegion != null &&
        selectedProvince != null &&
        selectedCommune != null &&
        villageController.text.isNotEmpty;
  }

  void goToNextStep() {
    if (!validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs obligatoires.")),
      );
      return;
    }

    final alert = AlertModel(
      date: dateController.text,
      time: timeController.text,
      village: villageController.text,
      region: selectedRegion!,
      province: selectedProvince!,
      commune: selectedCommune!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewAlertStep2Page(alert: alert)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> regionList = regionData.keys.toList();
    List<String> provinceList = selectedRegion != null
        ? regionData[selectedRegion!]!.keys.toList()
        : [];
    List<String> communeList = (selectedRegion != null &&
            selectedProvince != null &&
            regionData[selectedRegion!]!.containsKey(selectedProvince))
        ? regionData[selectedRegion!]![selectedProvince!]!
        : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Alerte"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Indicateur des étapes ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: steps.asMap().entries.map((entry) {
                  int stepNumber = entry.key + 1;
                  String label = entry.value;

                  Color circleColor;
                  if (stepNumber < 1) {
                    circleColor = Colors.green;
                  } else if (stepNumber == 1) {
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
                            color: stepNumber == 1 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(label, style: const TextStyle(fontSize: 11)),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              const Text(
                "Étape 1 : Date et Localisation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Date
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Date de l'événement",
                  hintText: "30/10/2025",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                    initialDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    dateController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
                },
              ),
              const SizedBox(height: 16),

              // Heure
              TextField(
                controller: timeController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Heure",
                  hintText: "14:30",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  TimeOfDay? pickedTime =
                      await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (pickedTime != null) timeController.text = pickedTime.format(context);
                },
              ),
              const SizedBox(height: 16),

              // Région
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Région",
                  border: OutlineInputBorder(),
                ),
                value: selectedRegion,
                items: regionList
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRegion = value;
                    selectedProvince = null;
                    selectedCommune = null;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Province
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Province",
                  border: OutlineInputBorder(),
                ),
                value: selectedProvince,
                items: provinceList
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProvince = value;
                    selectedCommune = null;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Commune
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Commune",
                  border: OutlineInputBorder(),
                ),
                value: selectedCommune,
                items: communeList
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCommune = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Village
              TextField(
                controller: villageController,
                decoration: const InputDecoration(
                  labelText: "Village",
                  hintText: "Nom du village",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Bouton Suivant
              CustomButton(
                text: "Suivant",
                onPressed: goToNextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

//////////////////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:mobile_app/features/alert/domain/alert_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/coustom_button_step1.dart';
import 'new_alert_step2_page.dart';

/// ------------------------------------------------------------
/// ÉTAPE 1 : Page totalement RESPONSIVE
/// ------------------------------------------------------------
class NewAlertStep1Page extends StatefulWidget {
  final AlertModel alert;

  const NewAlertStep1Page({
    super.key,
    required this.alert,
  });

  @override
  _NewAlertStep1PageState createState() => _NewAlertStep1PageState();
}

class _NewAlertStep1PageState extends State<NewAlertStep1Page> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  String? selectedRegion;
  String? selectedProvince;
  String? selectedCommune;

  /// Données des régions
  final Map<String, Map<String, List<String>>> regionData = {
    "Boucle du Mouhoun": {"Balé": ["Sibi"]},
    "Centre-Nord": {"Sanmatenga": ["Korsimoro", "Ziga"]},
    "Nord": {"Passoré": ["Kirsi", "Gomponsson"]},
  };

  final List<String> steps = [
    "Localisation",
    "Événement",
    "Conséquences",
    "Rapporteur",
    "Destinataires",
    "Revision",
  ];

  /// Vérifie si le formulaire est rempli
  bool validateForm() {
    return dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty &&
        selectedRegion != null &&
        selectedProvince != null &&
        selectedCommune != null &&
        villageController.text.isNotEmpty;
  }

  /// Navigation vers l'étape suivante
  void goToNextStep() {
    if (!validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs obligatoires.")),
      );
      return;
    }

    final alert = AlertModel(
      date: dateController.text,
      time: timeController.text,
      village: villageController.text,
      region: selectedRegion!,
      province: selectedProvince!,
      commune: selectedCommune!,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewAlertStep2Page(alert: alert)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /// Gestion responsive : largeur maximale pour tablette / PC
    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = constraints.maxWidth > 600
            ? 500                      // largeur max sur tablette/PC
            : constraints.maxWidth * 0.92; // 92% de largeur sur mobile

        List<String> regionList = regionData.keys.toList();
        List<String> provinceList =
            selectedRegion != null ? regionData[selectedRegion!]!.keys.toList() : [];
        List<String> communeList =
            (selectedRegion != null &&
                    selectedProvince != null &&
                    regionData[selectedRegion!]!.containsKey(selectedProvince))
                ? regionData[selectedRegion!]![selectedProvince!]!
                : [];

        return Scaffold(
          appBar: AppBar(
            title: const Text("Nouvelle Alerte"),
            backgroundColor: AppColors.primary,
          ),

          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth.toDouble()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ---------- INDICATEUR D'ÉTAPES ----------
                    _buildStepsIndicator(),

                    const SizedBox(height: 20),

                    const Text(
                      "Étape 1 : Date et Localisation",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    /// DATE
                    _responsiveField(
                      child: TextField(
                        controller: dateController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Date de l'événement",
                          hintText: "30/10/2025",
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                            initialDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            dateController.text =
                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                          }
                        },
                      ),
                    ),

                    /// HEURE
                    _responsiveField(
                      child: TextField(
                        controller: timeController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: "Heure",
                          hintText: "14:30",
                          border: OutlineInputBorder(),
                        ),
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            timeController.text = pickedTime.format(context);
                          }
                        },
                      ),
                    ),

                    /// RÉGION
                    _responsiveField(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Région",
                          border: OutlineInputBorder(),
                        ),
                        value: selectedRegion,
                        items: regionList
                            .map((r) =>
                                DropdownMenuItem(value: r, child: Text(r)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRegion = value;
                            selectedProvince = null;
                            selectedCommune = null;
                          });
                        },
                      ),
                    ),

                    /// PROVINCE
                    _responsiveField(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Province",
                          border: OutlineInputBorder(),
                        ),
                        value: selectedProvince,
                        items: provinceList
                            .map((p) =>
                                DropdownMenuItem(value: p, child: Text(p)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedProvince = value;
                            selectedCommune = null;
                          });
                        },
                      ),
                    ),

                    /// COMMUNE
                    _responsiveField(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: "Commune",
                          border: OutlineInputBorder(),
                        ),
                        value: selectedCommune,
                        items: communeList
                            .map((c) =>
                                DropdownMenuItem(value: c, child: Text(c)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCommune = value;
                          });
                        },
                      ),
                    ),

                    /// VILLAGE
                    _responsiveField(
                      child: TextField(
                        controller: villageController,
                        decoration: const InputDecoration(
                          labelText: "Village",
                          hintText: "Nom du village",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// BUTTON SUIVANT
                    CustomButton(
                      text: "Suivant",
                      onPressed: goToNextStep,
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

  /// ------------------------------------------------------------
  /// WIDGET : Indicateur d'étapes responsive
  /// ------------------------------------------------------------
  Widget _buildStepsIndicator() {
    return Wrap(
      spacing: 20,
      alignment: WrapAlignment.center,
      children: steps.asMap().entries.map((entry) {
        int stepNumber = entry.key + 1;
        String label = entry.value;

        Color circleColor =
            stepNumber == 1 ? AppColors.primary : Colors.white;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: circleColor,
              child: Text(
                "$stepNumber",
                style: TextStyle(
                  color: stepNumber == 1 ? Colors.white : Colors.black,
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
    );
  }

  /// ------------------------------------------------------------
  /// WIDGET : Applique un spacing uniforme aux champs
  /// ------------------------------------------------------------
  Widget _responsiveField({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: child,
    );
  }
}
