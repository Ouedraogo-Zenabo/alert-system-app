
//////////////////////////////////////////////////////////////////////////////////////////////////////////

/*import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
//import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/coustom_button_step1.dart';

class NewAlertStepsPage extends StatefulWidget {
  const NewAlertStepsPage({super.key});

  @override
  _NewAlertStepsPageState createState() => _NewAlertStepsPageState();
}

class _NewAlertStepsPageState extends State<NewAlertStepsPage> {
  int currentStep = 1;

  // -------------------------
  // Contrôleurs étape 1
  // -------------------------
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  // Dropdowns
  String? selectedRegion;
  String? selectedProvince;
  String? selectedCommune;

  // -------------------------
  // Étapes
  // -------------------------
  final List<String> steps = [
    "Localisation",
    "Événement",
    "Conséquences",
    "Rapporteur",
    "Destinataires",
    "Révision"
  ];

  // Données zones TDR
  final Map<String, Map<String, List<String>>> regionData = {
    "Boucle du Mouhoun": {"Balé": ["Sibi"]},
    "Centre-Nord": {"Sanmatenga": ["Korsimoro", "Ziga"]},
    "Nord": {"Passoré": ["Kirsi", "Gomponsson"]},
  };

  // -------------------------
  // Validation des étapes
  // -------------------------
  bool validateCurrentStep() {
    if (currentStep == 1) {
      return dateController.text.isNotEmpty &&
          timeController.text.isNotEmpty &&
          selectedRegion != null &&
          selectedProvince != null &&
          selectedCommune != null &&
          villageController.text.isNotEmpty;
    }
    // Validation simple par défaut pour autres étapes
    return true;
  }

  void nextStep() {
    if (!validateCurrentStep()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Veuillez remplir tous les champs obligatoires.")),
      );
      return;
    }
    if (currentStep < steps.length) {
      setState(() => currentStep++);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Alerte enregistrée avec succès !")),
      );
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      setState(() => currentStep--);
    }
  }

  // -------------------------
  // Indicateur des étapes
  // -------------------------
  Widget buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: steps.asMap().entries.map((entry) {
        int stepNumber = entry.key + 1;
        String label = entry.value;

        Color circleColor;
        Color borderColor = Colors.grey;

        if (stepNumber < currentStep) {
          circleColor = Colors.green; // étape passée
        } else if (stepNumber == currentStep) {
          circleColor = Colors.blue; // étape actuelle
        } else {
          circleColor = Colors.white; // étape future
        }

        return Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: circleColor,
              child: Text(
                "$stepNumber",
                style: TextStyle(
                    color: stepNumber == currentStep
                        ? Colors.white
                        : Colors.black),
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

  // -------------------------
  // Étape 1 : formulaire complet
  // -------------------------
  Widget buildStep1() {
    List<String> regionList = regionData.keys.toList();
    List<String> provinceList = selectedRegion != null
        ? regionData[selectedRegion!]!.keys.toList()
        : [];
    List<String> communeList = (selectedRegion != null &&
            selectedProvince != null &&
            regionData[selectedRegion!]!.containsKey(selectedProvince))
        ? regionData[selectedRegion!]![selectedProvince!]!
        : [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Date et Localisation",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Date
        TextField(
          controller: dateController,
          decoration: const InputDecoration(
            labelText: "Date de l'événement",
            hintText: "30/10/2025",
            border: OutlineInputBorder(),
          ),
          readOnly: true,
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
          decoration: const InputDecoration(
            labelText: "Heure",
            hintText: "14:30",
            border: OutlineInputBorder(),
          ),
          readOnly: true,
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
      ],
    );
  }

  // Placeholder pour les autres étapes
  Widget buildPlaceholderStep(String title) {
    return Center(
      child: Text(
        "Formulaire pour : $title",
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentContent;
    switch (currentStep) {
      case 1:
        currentContent = buildStep1();
        break;
      case 2:
        currentContent = buildPlaceholderStep("Événement");
        break;
      case 3:
        currentContent = buildPlaceholderStep("Conséquences");
        break;
      case 4:
        currentContent = buildPlaceholderStep("Rapporteur");
        break;
      case 5:
        currentContent = buildPlaceholderStep("Destinataires");
        break;
      case 6:
        currentContent = buildPlaceholderStep("Révision finale");
        break;
      default:
        currentContent = const SizedBox();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Alerte"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildStepIndicator(),
            const SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: currentContent)),
            const SizedBox(height: 16),
            Row(
              children: [
                if (currentStep > 1)
                  Expanded(
                    child: CustomButton(
                      text: "Précédent",
                      onPressed: previousStep,
                      color: Colors.grey,
                    ),
                  ),
                if (currentStep > 1) const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: currentStep == steps.length ? "Terminer" : "Suivant",
                    onPressed: nextStep,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
////////////////////////////////////////////////////////////////////////////////////////////

/*import 'package:flutter/material.dart';
import 'package:mobile_app/features/alert/domain/alert_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/coustom_button_step1.dart';
import 'new_alert_step2_page.dart';

class NewAlertStep1Page extends StatefulWidget {
  const NewAlertStep1Page({super.key});

  @override
  _NewAlertStep1PageState createState() => _NewAlertStep1PageState();
}

class _NewAlertStep1PageState extends State<NewAlertStep1Page> {
  // --- Contrôleurs des champs ---
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  // Dropdowns
  String? selectedRegion;
  String? selectedProvince;
  String? selectedCommune;

  // Données régionales
  final Map<String, Map<String, List<String>>> regionData = {
    "Boucle du Mouhoun": {"Balé": ["Sibi"]},
    "Centre-Nord": {"Sanmatenga": ["Korsimoro", "Ziga"]},
    "Nord": {"Passoré": ["Kirsi", "Gomponsson"]},
  };

  // Vérification des champs remplis
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

    // Crée l'alerte
    final alert = AlertModel(
      date: dateController.text,
      time: timeController.text,
      village: villageController.text,
      region: selectedRegion!,
      province: selectedProvince!,
      commune: selectedCommune!,
      
    );

    // Redirection vers l'étape 2
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewAlertStep2Page(alert: alert),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listes pour les dropdowns
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
                children: [
                  _buildStepCircle(1, isActive: true),
                  _buildStepCircle(2),
                  _buildStepCircle(3),
                  _buildStepCircle(4),
                  _buildStepCircle(5),
                ],
              ),
              const SizedBox(height: 16),

              const Text(
                "Étape 1 : Date et Localisation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Champ Date
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

              // Champ Heure
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
                  if (pickedTime != null) {
                    timeController.text = pickedTime.format(context);
                  }
                },
              ),

              const SizedBox(height: 16),

              // Dropdown Région
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

              // Dropdown Province
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

              // Dropdown Commune
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

              // Champ Village
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

  // --- Widget pour les cercles d'étapes ---
  Widget _buildStepCircle(int step, {bool isActive = false}) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: isActive ? AppColors.primary : Colors.green,
      child: Text(
        step.toString(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}*/




///////////////////////////////////////////////////////////////////////////////////////////////


// lib/features/alert/presentation/pages/new_alert_step1_page.dart

import 'package:flutter/material.dart';
import 'package:mobile_app/features/alert/domain/alert_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/coustom_button_step1.dart';
import 'new_alert_step2_page.dart';

class NewAlertStep1Page extends StatefulWidget {
  const NewAlertStep1Page({super.key});

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
}

