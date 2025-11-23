import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/alert_model.dart';

class NewAlertStep6Page extends StatelessWidget {
  final AlertModel alert;

  const NewAlertStep6Page({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle Alerte - Étape 6 (Récapitulatif)"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width < 600 ? 16 : width * 0.2,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionEvenement(),
            const SizedBox(height: 20),

            _buildSectionLocalisation(),
            const SizedBox(height: 20),

            _buildSectionRapporteur(),
            const SizedBox(height: 20),

            _buildSectionDestinataires(),
            const SizedBox(height: 30),

            _buildBoutons(context),
          ],
        ),
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////
  /// SECTION 1 : ÉVÈNEMENT
  /////////////////////////////////////////////////////////////////////////////

  Widget _buildSectionEvenement() {
    return _sectionCard(
      icon: Icons.warning_amber_rounded,
      color: Colors.red,
      title: "Évènement",
      children: [
        //_item("Catégorie", alert.categorie),  // ← tu gardes ta variable

        const SizedBox(height: 8),

        /// Ampleur + barre
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Amplitude"),
            Text(
              alert.ampleur != null
                  ? "${(alert.ampleur! * 100).toStringAsFixed(0)} %"
                  : "0 %",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        LinearProgressIndicator(
          value: alert.ampleur ?? 0.0,
          backgroundColor: Colors.grey.shade300,
        ),

        const SizedBox(height: 12),
        _modifier(),
      ],
    );
  }

  /////////////////////////////////////////////////////////////////////////////
  /// SECTION 2 : LOCALISATION
  /////////////////////////////////////////////////////////////////////////////

  Widget _buildSectionLocalisation() {
    return _sectionCard(
      icon: Icons.location_on,
      color: Colors.blue,
      title: "Localisation",
      children: [
        _item("Date & heure", "${alert.date ?? ''} ${alert.time ?? ''}"),
        _item("Région", alert.region),
        _item("Province", alert.province),
        _item("Commune", alert.commune),
        _item("Village", alert.village),
        const SizedBox(height: 12),
        _modifier(),
      ],
    );
  }

  /////////////////////////////////////////////////////////////////////////////
  /// SECTION 3 : RAPPORTEUR
  /////////////////////////////////////////////////////////////////////////////

  Widget _buildSectionRapporteur() {
    return _sectionCard(
      icon: Icons.person,
      color: Colors.green,
      title: "Rapporteur",
      children: [
        _item("Nom complet", alert.rapporteurNom),
        _item("Téléphone", alert.rapporteurTelephone),
        _item("Fonction", alert.fonction),
        _item("Langue", alert.languePreferee),
        const SizedBox(height: 12),
        _modifier(),
      ],
    );
  }

  /////////////////////////////////////////////////////////////////////////////
  /// SECTION 4 : DESTINATAIRES
  /////////////////////////////////////////////////////////////////////////////

  Widget _buildSectionDestinataires() {
    return _sectionCard(
      icon: Icons.people_alt,
      color: Colors.orange,
      title: "Destinataires",
      children: [
        Wrap(
          spacing: 8,
          children: const [
            Chip(label: Text("SMS")),
            Chip(label: Text("Email")),
            Chip(label: Text("Notification")),
          ],
        ),
        const SizedBox(height: 16),

        _item("Structures", "${alert.structure ?? 0}"),
       // _item("Autorités", "${alert.autorites ?? 0}"),
        //_item("Équipes", "${alert.equipes ?? 0}"),
        _item("Total", "${alert.groupesDestinataires ?? 0}"),

        const SizedBox(height: 12),
        _modifier(),
      ],
    );
  }

  /////////////////////////////////////////////////////////////////////////////
  /// BOUTONS
  /////////////////////////////////////////////////////////////////////////////

  Widget _buildBoutons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Précédent"),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO : Soumission finale
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          child: const Text("Soumettre l’alerte"),
        ),
      ],
    );
  }

  /////////////////////////////////////////////////////////////////////////////
  /// UTILITAIRES
  /////////////////////////////////////////////////////////////////////////////

  Widget _sectionCard({
    required IconData icon,
    required Color color,
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _item(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value?.toString() ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _modifier() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text("Modifier"),
      ),
    );
  }
}
