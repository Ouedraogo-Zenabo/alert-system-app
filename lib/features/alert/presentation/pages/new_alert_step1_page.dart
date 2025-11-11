/*import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class NewAlertStep1Page extends StatefulWidget {
  const NewAlertStep1Page({super.key});

  @override
  _NewAlertStep1PageState createState() => _NewAlertStep1PageState();
}

class _NewAlertStep1PageState extends State<NewAlertStep1Page> {
  // Contrôleurs pour récupérer les valeurs saisies
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  // Variables pour stocker les sélections des dropdowns
  String? selectedRegion;
  String? selectedProvince;
  String? selectedCommune;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Alerte - Localisation"),
        backgroundColor: AppColors.primary, // Exemple si tu utilises ton thème
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Date et Localisation",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ----------------------------
            // Champ Date
            // ----------------------------
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

            // ----------------------------
            // Champ Heure
            // ----------------------------
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

            // ----------------------------
            // Dropdown Région
            // ----------------------------
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Région",
                border: OutlineInputBorder(),
              ),
              value: selectedRegion,
              items: const [
                DropdownMenuItem(
                    value: "Centre-Nord", child: Text("Centre-Nord")),
                DropdownMenuItem(
                    value: "Plateau-Central", child: Text("Plateau-Central")),
              ],
              onChanged: (v) => setState(() => selectedRegion = v),
            ),
            const SizedBox(height: 16),

            // Dropdown Province
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Province",
                border: OutlineInputBorder(),
              ),
              value: selectedProvince,
              items: const [
                DropdownMenuItem(value: "Sanmatenga", child: Text("Sanmatenga")),
              ],
              onChanged: (v) => setState(() => selectedProvince = v),
            ),
            const SizedBox(height: 16),

            // Dropdown Commune
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Commune",
                border: OutlineInputBorder(),
              ),
              value: selectedCommune,
              items: const [
                DropdownMenuItem(value: "Korsimoro", child: Text("Korsimoro")),
              ],
              onChanged: (v) => setState(() => selectedCommune = v),
            ),
            const SizedBox(height: 16),

            // Village textField
            TextField(
              controller: villageController,
              decoration: const InputDecoration(
                labelText: "Village",
                hintText: "Nom du village",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // ----------------------------
            // Bouton Suivant
            // ----------------------------
            CustomButton(
              text: "Suivant",
              onPressed: () {
                // Vérifier que les champs essentiels sont remplis
                if (dateController.text.isEmpty ||
                    timeController.text.isEmpty ||
                    selectedRegion == null ||
                    selectedProvince == null ||
                    selectedCommune == null ||
                    villageController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Veuillez remplir tous les champs obligatoires")),
                  );
                  return;
                }

                // Navigation vers l'étape 2
                Navigator.pushNamed(context, "/new-alert-step2",
                    arguments: {
                      "date": dateController.text,
                      "time": timeController.text,
                      "region": selectedRegion,
                      "province": selectedProvince,
                      "commune": selectedCommune,
                      "village": villageController.text,
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';


class NewAlertStep1Page extends StatefulWidget {
  const NewAlertStep1Page({super.key});

  @override
  _NewAlertStep1PageState createState() => _NewAlertStep1PageState();
}

class _NewAlertStep1PageState extends State<NewAlertStep1Page> {
  // Étape actuelle (1 à 5)
  int currentStep = 1;

  // Titres des étapes
  final List<String> stepTitles = [
    "Localisation",
    "Événement",
    "Conséquences",
    "Rapporteur",
    "Destinataires",
    "Révision"
  ];

  // Contrôleurs pour chaque étape si nécessaire
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  String? selectedRegion;
  String? selectedProvince;
  String? selectedCommune;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Alerte"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ----------------------------
            // Stepper horizontal
            // ----------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(stepTitles.length, (index) {
                final stepNumber = index + 1;

                Color circleColor;
                Color borderColor = Colors.grey;

                if (stepNumber < currentStep) {
                  circleColor = Colors.green; // Étape passée
                } else if (stepNumber == currentStep) {
                  circleColor = Colors.blue; // Étape actuelle
                } else {
                  circleColor = Colors.white; // Étape future
                  borderColor = Colors.grey;
                }

                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: circleColor,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: stepNumber > currentStep ? Colors.grey : Colors.green,
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "$stepNumber",
                          style: TextStyle(
                            color: stepNumber > currentStep ? Colors.grey : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        stepTitles[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // ----------------------------
            // Contenu dynamique selon l'étape
            // ----------------------------
            Expanded(
              child: getStepContent(),
            ),

            const SizedBox(height: 16),

            // ----------------------------
            // Boutons Précédent / Suivant
            // ----------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentStep > 1
                      ? () {
                          setState(() {
                            currentStep--;
                          });
                        }
                      : null,
                  child: const Text("Précédent"),
                ),
                ElevatedButton(
                  onPressed: currentStep < 5
                      ? () {
                          setState(() {
                            currentStep++;
                          });
                        }
                      : null,
                  child: const Text("Suivant"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Méthode qui renvoie le widget correspondant à l'étape actuelle
  Widget getStepContent() {
    switch (currentStep) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Date et Localisation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Champ Date
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
            // Champ Heure
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
            // Dropdown Région
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Région",
                border: OutlineInputBorder(),
              ),
              value: selectedRegion,
              items: const [
                DropdownMenuItem(value: "Centre-Nord", child: Text("Centre-Nord")),
                DropdownMenuItem(value: "Plateau-Central", child: Text("Plateau-Central")),
              ],
              onChanged: (v) => setState(() => selectedRegion = v),
            ),
            const SizedBox(height: 16),
            // Province dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Province",
                border: OutlineInputBorder(),
              ),
              value: selectedProvince,
              items: const [
                DropdownMenuItem(value: "Sanmatenga", child: Text("Sanmatenga")),
              ],
              onChanged: (v) => setState(() => selectedProvince = v),
            ),
            const SizedBox(height: 16),
            // Commune dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Commune",
                border: OutlineInputBorder(),
              ),
              value: selectedCommune,
              items: const [
                DropdownMenuItem(value: "Korsimoro", child: Text("Korsimoro")),
              ],
              onChanged: (v) => setState(() => selectedCommune = v),
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
      case 2:
        return const Center(child: Text("Contenu de l'étape 2: Événement"));
      case 3:
        return const Center(child: Text("Contenu de l'étape 3: Conséquences"));
      case 4:
        return const Center(child: Text("Contenu de l'étape 4: Rapporteur"));
      case 5:
        return const Center(child: Text("Contenu de l'étape 5: Destinataires"));
      default:
        return const SizedBox();
    }
  }
}
*/


////////////////////////////////////////////////////////////////////////////////////////////////////


/*import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';

class NewAlertStepsPage extends StatefulWidget {
  const NewAlertStepsPage({super.key});

  @override
  _NewAlertStepsPageState createState() => _NewAlertStepsPageState();
}

class _NewAlertStepsPageState extends State<NewAlertStepsPage> {
  int currentStep = 1;

  // Contrôleurs pour les champs de l’étape 1
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController villageController = TextEditingController();

  // Dropdowns
  String? selectedRegion;
  String? selectedProvince;
  String? selectedCommune;

  // Liste des étapes
  final List<String> steps = [
    "Localisation",
    "Événement",
    "Conséquences",
    "Rapporteur",
    "Destinataires",
    "Révision"
  ];

  // Données selon le TDR
  final Map<String, Map<String, List<String>>> regionData = {
    "Boucle du Mouhoun": {
      "Balé": ["Sibi"],
    },
    "Centre-Nord": {
      "Sanmatenga": ["Korsimoro", "Ziga"],
    },
    "Nord": {
      "Passoré": ["Kirsi", "Gomponsson"],
    },
  };

  // Vérification des champs selon l’étape
  bool validateCurrentStep() {
    if (currentStep == 1) {
      return dateController.text.isNotEmpty &&
          timeController.text.isNotEmpty &&
          selectedRegion != null &&
          selectedProvince != null &&
          selectedCommune != null &&
          villageController.text.isNotEmpty;
    }
    // À compléter pour les autres étapes
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
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      setState(() => currentStep--);
    }
  }

  Widget buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: steps.asMap().entries.map((entry) {
        int stepNumber = entry.key + 1;
        String label = entry.value;

        Color circleColor;
        Color borderColor = Colors.grey;

        if (stepNumber < currentStep) {
          circleColor = Colors.green; // Étape passée
        } else if (stepNumber == currentStep) {
          circleColor = Colors.blue; // Étape actuelle
        } else {
          circleColor = Colors.white; // Étape future
        }

        return Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: circleColor,
              child: Text(
                "$stepNumber",
                style: TextStyle(
                  color:
                      stepNumber == currentStep ? Colors.white : Colors.black,
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

  // Étape 1 : Localisation
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

        // Champ Date
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

        // Champ Heure
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
        const SizedBox(height: 16),a

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep > 1)
                  Expanded(
                    child: CustomButton(
                      text: "Précédent",
                      onPressed: previousStep,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                if (currentStep > 1) const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: currentStep == steps.length ? "Terminer" : "Suivant",
                    onPressed: () {
                      if (currentStep == steps.length) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Alerte enregistrée avec succès !")),
                        );
                      } else {
                        nextStep();
                      }
                    },
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
//////////////////////////////////////////////////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';
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









