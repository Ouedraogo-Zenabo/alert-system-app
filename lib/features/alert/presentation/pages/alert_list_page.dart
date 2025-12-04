/*port 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/alert_service.dart';
import '../../domain/alert_model.dart';

class AlertListPage extends StatelessWidget {
  const AlertListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = AlertService().getAlerts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des alertes'),
        backgroundColor: AppColors.primary,
      ),
      body: alerts.isEmpty
          ? const Center(child: Text('Aucune alerte enregistrée.'))
          : ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                final AlertModel alert = alerts[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      alert.typeEvenement ?? 'Événement inconnu',
                      style: AppTextStyles.titleMedium,
                    ),
                    subtitle: Text(
                      'Région : ${alert.region ?? 'N/A'}\n'
                      'Personnes affectées : ${alert.nbPersonnesAffectees ?? 'N/A'}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
            ),
    );
  }
}*/



import 'package:flutter/material.dart';

/// ------------------------------------------------------------
/// MODEL — représente une alerte
/// ------------------------------------------------------------
class AlertItem {
  final String type;        // Exemple: "Inondation"
  final String date;        // Exemple: "28 Oct 2025"
  final String location;    // Exemple: "Boucle du Mouhoun, Balé, Sibi"
  final int affected;       // Exemple: 250
  final String status;      // Exemple: "Urgent", "Évalué"
  final IconData icon;      // Exemple: Icons.water_drop

  AlertItem({
    required this.type,
    required this.date,
    required this.location,
    required this.affected,
    required this.status,
    required this.icon,
  });
}

/// ------------------------------------------------------------
/// PAGE LISTE ALERTES
/// ------------------------------------------------------------
class AlertsListPage extends StatefulWidget {
  const AlertsListPage({super.key});

  @override
  State<AlertsListPage> createState() => _AlertsListPageState();
}

class _AlertsListPageState extends State<AlertsListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Liste de démonstration (tu vas remplacer par ta vraie liste API)
  final List<AlertItem> alerts = [
    AlertItem(
      type: "Inondation",
      date: "28 Oct 2025",
      location: "Boucle du Mouhoun, Balé, Sibi",
      affected: 250,
      status: "Urgent",
      icon: Icons.water_drop,
    ),
    AlertItem(
      type: "Sécheresse",
      date: "25 Oct 2025",
      location: "Centre-Nord, Sanmatenga, Korsimoro",
      affected: 1200,
      status: "Évalué",
      icon: Icons.wb_sunny,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// ---------------- APPBAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Mes Alertes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 5),

          /// ---------------- BARRE DE RECHERCHE ----------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Rechercher...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.black87),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// ---------------- TABS ----------------
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            indicatorColor: Colors.blue,
            tabs: const [
              Tab(text: "Toutes"),
              Tab(text: "Soumises"),
              Tab(text: "Transmises"),
              Tab(text: "Évaluées"),
            ],
          ),

          const SizedBox(height: 10),

          /// ---------------- CONTENU DES TABS ----------------
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAlertsList(alerts),
                _buildAlertsList(alerts.where((a) => a.status == "Soumis").toList()),
                _buildAlertsList(alerts.where((a) => a.status == "Transmis").toList()),
                _buildAlertsList(alerts.where((a) => a.status == "Évalué").toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ------------------------------------------------------------
  /// WIDGET : LISTE DES ALERTES
  /// ------------------------------------------------------------
  Widget _buildAlertsList(List<AlertItem> list) {
    if (list.isEmpty) {
      return const Center(child: Text("Aucune alerte trouvée"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _buildAlertCard(list[index]);
      },
    );
  }

  /// ------------------------------------------------------------
  /// WIDGET : CARTE D’UNE ALERTE (comme l’image)
  /// ------------------------------------------------------------
  Widget _buildAlertCard(AlertItem alert) {
    Color statusColor =
        alert.status == "Urgent" ? Colors.red.shade100 : Colors.green.shade100;

    Color statusTextColor =
        alert.status == "Urgent" ? Colors.red : Colors.green;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// --- Ligne du haut ---
          Row(
            children: [
            Icon(alert.icon, color: Colors.blue, size: 26),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  alert.type,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),

              /// Badge Statut
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  alert.status,
                  style: TextStyle(
                    color: statusTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 12),

          /// --- Date ---
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16),
              const SizedBox(width: 6),
              Text(alert.date),
            ],
          ),

          const SizedBox(height: 10),

          /// --- Localisation ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, size: 16),
              const SizedBox(width: 6),
              Expanded(child: Text(alert.location)),
            ],
          ),

          const SizedBox(height: 10),

          /// --- Personnes affectées ---
          Row(
            children: [
              const Icon(Icons.people, size: 16),
              const SizedBox(width: 6),
              Text("${alert.affected} personnes affectées"),
            ],
          ),
        ],
      ),
    );
  }
}

