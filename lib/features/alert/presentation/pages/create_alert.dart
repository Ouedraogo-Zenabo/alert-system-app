import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateAlertPage extends StatefulWidget {
  @override
  _CreateAlertPageState createState() => _CreateAlertPageState();
}

class _CreateAlertPageState extends State<CreateAlertPage> {
  bool loading = false;
  String? errorMessage;

  List zones = [];
  final TextEditingController _startDateController = TextEditingController();

  // FORM DATA
  final form = {
    "title": "",
    "message": "",
    "type": "FLOOD",
    "severity": "MODERATE",
    "zoneId": "",
    "startDate": "",
    "startTime": "",
    "endDate": "",
    "endTime": "",
    "instructions": "",
    "actionRequired": false
  };

  final alertTypes = [
    {"value": "FLOOD", "label": "Inondation"},
    {"value": "DROUGHT", "label": "Sécheresse"},
    {"value": "EPIDEMIC", "label": "Épidémie"},
    {"value": "FIRE", "label": "Incendie"},
    {"value": "STORM", "label": "Tempête"},
    {"value": "EARTHQUAKE", "label": "Tremblement de terre"},
    {"value": "SECURITY", "label": "Sécurité/Conflit"},
    {"value": "FAMINE", "label": "Famine"},
    {"value": "LOCUST", "label": "Invasion acridienne"},
    {"value": "OTHER", "label": "Autre"}
  ];

  final severityLevels = [
    {"value": "INFO", "label": "Information"},
    {"value": "LOW", "label": "Faible"},
    {"value": "MODERATE", "label": "Modéré"},
    {"value": "HIGH", "label": "Élevé"},
    {"value": "CRITICAL", "label": "Critique"},
    {"value": "EXTREME", "label": "Extrême"}
  ];

  @override
  void initState() {
    super.initState();
    _loadZones();
    form["startDate"] = DateTime.now().toIso8601String().split("T")[0];
    _startDateController.text = form["startDate"]?.toString() ?? "";
  }

  @override
  void dispose() {
    _startDateController.dispose();
    super.dispose();
  }

  // GET ZONES
  Future<void> _loadZones() async {
    try {
      final url = Uri.parse("http://197.239.116.77:3000/api/v1/zones");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        setState(() {
          zones = decoded["zones"] ?? [];
          // If no zone selected yet, default to first zone's id (helps avoid empty ZoneId)
          if (zones.isNotEmpty && (form["zoneId"] == null || form["zoneId"].toString().isEmpty)) {
            form["zoneId"] = zones[0]["id"];
            // If startDate controller empty, keep it as is (we already initialize it in initState)
          }
        });
      }
    } catch (e) {
      print("Erreur chargement zones : $e");
    }
  }

  bool get canSubmit {
    return form["title"].toString().trim().length >= 5 &&
        form["message"].toString().trim().length >= 10 &&
        (form["zoneId"] ?? "").toString().isNotEmpty &&
        (form["startDate"] ?? "").toString().isNotEmpty;
  }

  // Combine date + time → ISO
  String? _combineDateTime(String? date, String? time) {
    if ((date ?? "").isEmpty) return null;
    time = (time ?? "").isEmpty ? "00:00" : time;
    final full = DateTime.tryParse("$date $time");
    return full?.toIso8601String();
  }

  // POST alert (with status)
  Future<void> _submitAlert(String status) async {
    print("=== DEBUG: _submitAlert appelé avec status=$status ===");
    print("Form data: $form");
    print("canSubmit value: $canSubmit");
    
    if (!canSubmit) {
      final titleLen = form["title"].toString().trim().length;
      final messageLen = form["message"].toString().trim().length;
      final zoneId = (form["zoneId"] ?? "").toString();
      final startDate = (form["startDate"] ?? "").toString();
      
      print("DEBUG: Validation échouée");
      print("  - Title length: $titleLen (min: 5)");
      print("  - Message length: $messageLen (min: 10)");
      print("  - ZoneId: '$zoneId' (must not be empty)");
      print("  - StartDate: '$startDate' (must not be empty)");
      
      setState(() => errorMessage = "Veuillez remplir tous les champs obligatoires.\n"
          "Titre (min 5 chars): $titleLen/5\n"
          "Message (min 10 chars): $messageLen/10\n"
          "Zone: ${zoneId.isEmpty ? 'vide' : 'OK'}\n"
          "Date début: ${startDate.isEmpty ? 'vide' : 'OK'}");
      return;
    }

    setState(() {
      loading = true;
      errorMessage = null;
    });

    final startDateTime = _combineDateTime(
        form["startDate"] as String?, form["startTime"] as String?);
    final endDateTime = (form["endDate"] ?? "").toString().isNotEmpty
        ? _combineDateTime(
            form["endDate"] as String?, form["endTime"] as String?)
        : null;

    final data = {
      "title": form["title"],
      "message": form["message"],
      "type": form["type"],
      "severity": form["severity"],
      "zoneId": form["zoneId"],
      "startDate": startDateTime,
      "endDate": endDateTime,
      "instructions": form["instructions"],
      "actionRequired": form["actionRequired"],
      "status": status,
    };

    print("Sending alert with data: $data");

    try {
      final url = Uri.parse("http://197.239.116.77:3000/api/v1/alerts");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      print("API Response status: ${response.statusCode}");
      print("API Response body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("SUCCESS: Alerte soumise avec succès!");
        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        setState(() => errorMessage = "Erreur serveur (${response.statusCode}): ${response.body}");
      }
    } catch (e) {
      print("ERROR: Erreur réseau - $e");
      setState(() => errorMessage = "Erreur réseau : $e");
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  // SAVE draft without full validation
  Future<void> _saveDraft() async {
    print("=== DEBUG: _saveDraft appelé ===");
    print("Form data: $form");
    
    setState(() {
      loading = true;
      errorMessage = null;
    });

    final startDateTime = _combineDateTime(
        form["startDate"] as String?, form["startTime"] as String?);
    final endDateTime = (form["endDate"] ?? "").toString().isNotEmpty
        ? _combineDateTime(
            form["endDate"] as String?, form["endTime"] as String?)
        : null;

    final data = {
      "title": form["title"],
      "message": form["message"],
      "type": form["type"],
      "severity": form["severity"],
      "zoneId": form["zoneId"],
      "startDate": startDateTime,
      "endDate": endDateTime,
      "instructions": form["instructions"],
      "actionRequired": form["actionRequired"],
      "status": "DRAFT",
    };

    print("Saving draft with data: $data");

    try {
      final url = Uri.parse("http://197.239.116.77:3000/api/v1/alerts");
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      print("API Response status: ${response.statusCode}");
      print("API Response body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("SUCCESS: Brouillon sauvegardé avec succès!");
        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        setState(() => errorMessage = "Erreur serveur (${response.statusCode}): ${response.body}");
      }
    } catch (e) {
      print("ERROR: Erreur réseau - $e");
      setState(() => errorMessage = "Erreur réseau : $e");
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final padding = isMobile ? 16.0 : 32.0;
    final maxWidth = 600.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Créer une alerte"),
        leading: BackButton(),
        elevation: 0, // Désactiver l'ombre pour réduire charge GPU
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    children: [
                      if (errorMessage != null)
                        Container(
                          padding: EdgeInsets.all(12),
                          color: Colors.red[100],
                          child: Text(errorMessage!, style: TextStyle(color: Colors.red)),
                        ),

                      // Titre
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Titre *",
                          border: OutlineInputBorder(), // Utiliser outline au lieu de underline
                        ),
                        onChanged: (v) => setState(() => form["title"] = v),
                      ),

                      SizedBox(height: 16),

                      // Type + Sévérité
                      isMobile
                          ? Column(
                              children: [
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    labelText: "Type d'alerte",
                                    border: OutlineInputBorder(),
                                  ),
                                  value: form["type"],
                                  items: alertTypes
                                      .map((e) => DropdownMenuItem(
                                          value: e["value"], child: Text(e["label"]!)))
                                      .toList(),
                                  onChanged: (v) => setState(() => form["type"] = v ?? ""),
                                ),
                                SizedBox(height: 16),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    labelText: "Sévérité",
                                    border: OutlineInputBorder(),
                                  ),
                                  value: form["severity"],
                                  items: severityLevels
                                      .map((e) => DropdownMenuItem(
                                          value: e["value"], child: Text(e["label"]!)))
                                      .toList(),
                                  onChanged: (v) => setState(() => form["severity"] = v ?? ""),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      labelText: "Type d'alerte",
                                      border: OutlineInputBorder(),
                                    ),
                                    value: form["type"],
                                    items: alertTypes
                                        .map((e) => DropdownMenuItem(
                                            value: e["value"], child: Text(e["label"]!)))
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => form["type"] = v ?? ""),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      labelText: "Sévérité",
                                      border: OutlineInputBorder(),
                                    ),
                                    value: form["severity"],
                                    items: severityLevels
                                        .map((e) => DropdownMenuItem(
                                            value: e["value"], child: Text(e["label"]!)))
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => form["severity"] = v ?? ""),
                                  ),
                                ),
                              ],
                            ),

                      SizedBox(height: 16),

                      // Zone
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Zone géographique *",
                          border: OutlineInputBorder(),
                        ),
                        value: form["zoneId"],
                        items: zones
                            .map((z) => DropdownMenuItem(
                                  value: z["id"],
                                  child: Text("${z["name"]} (${z["type"]})"),
                                ))
                            .toList(),
                        onChanged: (v) => setState(() => form["zoneId"] = v ?? ""),
                      ),

                      SizedBox(height: 16),

                      // Dates
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Période de l'événement",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 12),
                          isMobile
                              ? Column(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Date début",
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: _startDateController,
                                      onChanged: (v) =>
                                          setState(() => form["startDate"] = v),
                                    ),
                                    SizedBox(height: 12),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Heure début",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (v) =>
                                          setState(() => form["startTime"] = v),
                                    ),
                                    SizedBox(height: 16),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Date fin",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (v) =>
                                          setState(() => form["endDate"] = v),
                                    ),
                                    SizedBox(height: 12),
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: "Heure fin",
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (v) =>
                                          setState(() => form["endTime"] = v),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              labelText: "Date début",
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: _startDateController,
                                            onChanged: (v) =>
                                                setState(() => form["startDate"] = v),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              labelText: "Heure début",
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (v) =>
                                                setState(() => form["startTime"] = v),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              labelText: "Date fin",
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (v) =>
                                                setState(() => form["endDate"] = v),
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              labelText: "Heure fin",
                                              border: OutlineInputBorder(),
                                            ),
                                            onChanged: (v) =>
                                                setState(() => form["endTime"] = v),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Message
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Message *",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                        onChanged: (v) => setState(() => form["message"] = v),
                      ),

                      SizedBox(height: 16),

                      // Instructions
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Instructions",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        onChanged: (v) => setState(() => form["instructions"] = v),
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: (form["actionRequired"] as bool?) ?? false,
                            onChanged: (val) =>
                                setState(() => form["actionRequired"] = val ?? false),
                          ),
                          Text("Action immédiate requise")
                        ],
                      ),

                      SizedBox(height: 20),

                      // Buttons
                      isMobile
                          ? Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: loading ? null : () => _saveDraft(),
                                    child: Text("Enregistrer brouillon"),
                                  ),
                                ),
                                SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: loading ? null : () => _submitAlert("SUBMITTED"),
                                    child: Text("Créer & soumettre"),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: loading ? null : () => _saveDraft(),
                                    child: Text("Enregistrer brouillon"),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: loading ? null : () => _submitAlert("SUBMITTED"),
                                    child: Text("Créer & soumettre"),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}