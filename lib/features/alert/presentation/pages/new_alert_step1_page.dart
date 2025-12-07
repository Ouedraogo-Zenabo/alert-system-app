
//////////////////////////////////////////////////////////////////////////

/*import 'package:flutter/material.dart';
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
}*/






///////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////

/*
// Page Étape 1 — Localisation de l'évènement
// Version responsive, fonctionnelle et bien commentée
// NOTE : Adapte les imports selon ton architecture de projet

import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:;google_maps_flutter/google_maps_flutter.dart'
import 'package:mobile_app/features/alert/domain/alert_model.dart';
import 'package:mobile_app/features/alert/domain/zone_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/features/alert/data/zone_api_service.dart';

class NewAlertStep1Page extends StatefulWidget {
  final AlertModel alert; // Déclaration du paramètre

  const NewAlertStep1Page({super.key, required this.alert}); // Constructeur

  @override
  State<NewAlertStep1Page> createState() => _NewAlertStep1PageState();
}

class _NewAlertStep1PageState extends State<NewAlertStep1Page> {
  // Liste simulée des zones — remplace par ta vraie API ou ton provider
  final List<Map<String, dynamic>> zones = [
    {
      'name': 'Nord',
      'code': 'BF-10',
      'type': 'REGION',
      'latitude': 13.5471,
      'longitude': -2.0602,
      'population': 1637723,
      'id': '6c55e3cd-1edd-4030-b548-c3abcec7809a',
    },
  ];

  Map<String, dynamic>? selectedZone;

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Localisation de l’évènement'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ========================= SECTION CARTE =========================
                Container(
                  width: double.infinity,
                  height: isLargeScreen ? 250 : 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, size: 50, color: Colors.blue),
                      const SizedBox(height: 12),
                      Text(
                        'Cliquez sur la carte pour sélectionner la localisation',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'ou utilisez les champs ci-dessous',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ========================= SELECT ZONE =========================
                const Text('Sélectionnez une zone',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                DropdownButtonFormField<Map<String, dynamic>>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  items: zones.map((z) {
                    return DropdownMenuItem(
                      value: z,
                      child: Text('${z['name']} (${z['code']}) — ${z['type']}'),
                    );
                  }).toList(),
                  value: selectedZone,
                  onChanged: (val) {
                    setState(() => selectedZone = val);
                  },
                ),

                const SizedBox(height: 20),

                // ========================= DETAILS DE LA ZONE =========================
                if (selectedZone != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Détails de la zone sélectionnée',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 15),

                        _detailRow('Nom', selectedZone!['name']),
                        _detailRow('Code', selectedZone!['code']),
                        _detailRow('Type', selectedZone!['type']),
                        _detailRow('Latitude', '${selectedZone!['latitude']}'),
                        _detailRow('Longitude', '${selectedZone!['longitude']}'),
                        _detailRow(
                            'Population', '${selectedZone!['population']}'),
                        _detailRow('ID', selectedZone!['id']),
                      ],
                    ),
                  ),

                const SizedBox(height: 40),

                // ========================= ACTION BUTTONS =========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text('Annuler'),
                      ),
                    ),

                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text('Sauvegarder le brouillon'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: selectedZone == null ? null : () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text('Suivant'),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========================= WIDGET DETAIL LIGNE =========================
  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }
}*/



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_app/features/alert/domain/alert_model.dart';
import 'package:http/http.dart' as http;

class NewAlertStep1Page extends StatefulWidget {
  final AlertModel alert;

  const NewAlertStep1Page({super.key, required this.alert});

  @override
  State<NewAlertStep1Page> createState() => _NewAlertStep1PageState();
}

class _NewAlertStep1PageState extends State<NewAlertStep1Page> {
  List<Map<String, dynamic>> zones = [];
  Map<String, dynamic>? selectedZone;

  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchZones(); // Charger les zones dès l’ouverture de la page
  }

  // ========================= GET ZONES FROM BACKEND =========================
  Future<void> fetchZones() async {
    try {
      const url = "http://197.239.116.77:3000/api/v1/zones";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          zones = List<Map<String, dynamic>>.from(data["zones"]);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Localisation de l’évènement'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ------------------------ CARTE PLACEHOLDER ------------------------
                Container(
                  width: double.infinity,
                  height: isLargeScreen ? 250 : 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, size: 50, color: Colors.blue),
                      const SizedBox(height: 12),
                      Text(
                        'Cliquez sur la carte pour sélectionner la localisation',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'ou utilisez les champs ci-dessous',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Sélectionnez une zone',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // ========================= LOADING / ERROR / DROPDOWN =========================
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else if (hasError)
                  const Text(
                    "Erreur lors du chargement des zones.",
                    style: TextStyle(color: Colors.red),
                  )
                else
                  DropdownButtonFormField<Map<String, dynamic>>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    items: zones.map((z) {
                      return DropdownMenuItem(
                        value: z,
                        child: Text('${z['name']} (${z['code']}) — ${z['type']}'),
                      );
                    }).toList(),
                    value: selectedZone,
                    onChanged: (val) {
                      setState(() {
                        selectedZone = val;
                      });
                    },
                  ),

                const SizedBox(height: 20),

                // ========================= DETAILS ZONE =========================
                if (selectedZone != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Détails de la zone sélectionnée',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 15),

                        _detailRow('Nom', selectedZone!['name']),
                        _detailRow('Code', selectedZone!['code']),
                        _detailRow('Type', selectedZone!['type']),
                        _detailRow('Latitude', '${selectedZone!['latitude']}'),
                        _detailRow('Longitude', '${selectedZone!['longitude']}'),
                        _detailRow('Population',
                            '${selectedZone!['population']}'),
                        _detailRow('ID', selectedZone!['id']),
                      ],
                    ),
                  ),

                const SizedBox(height: 40),

                // ========================= BUTTONS =========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text('Annuler'),
                      ),
                    ),

                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text('Sauvegarder le brouillon'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: selectedZone == null ? null : () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text('Suivant'),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========================= WIDGET DETAIL =========================
  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }
}


