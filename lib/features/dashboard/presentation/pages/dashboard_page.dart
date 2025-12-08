/*import 'package:flutter/material.dart';
import 'package:mobile_app/features/alert/domain/alert_model.dart';
import 'package:mobile_app/features/alert/presentation/pages/new_alert_step1_page_fixed.dart';


 // Import de la page de création d'alerte

class DashboardPage extends StatelessWidget {
  
  const DashboardPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Kaboré Marie",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Point Focal Communal",
              style: TextStyle(
                color: Colors.green,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // Wrap pour rendre les StatCards responsive
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                StatCard(title: "Créées", value: "10"),
                StatCard(title: "En attente", value: "5"),
                StatCard(title: "Transmises", value: "15"),
                StatCard(title: "Évaluées", value: "3"),
              ],
            ),

            const SizedBox(height: 20),

            // Bouton Créer une alerte
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigation vers la page NewAlertStep1Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewAlertStep1Page(alert: AlertModel()),

                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Text(
                  "Créer une alerte",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 25),
            const Text(
              "Dernières alertes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            const AlertItem(
              title: "Inondation",
              date: "28 Oct 2025",
              location: "Boucle du Mouhoun, Balé, Sibi",
              affected: "250 personnes",
              status: "Urgent",
              statusColor: Colors.red,
            ),
            const AlertItem(
              title: "Sécheresse",
              date: "25 Oct 2025",
              location: "Est, Komondjari",
              affected: "80 personnes",
              status: "Évalué",
              statusColor: Colors.green,
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alertes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

// ---------------------------------------------
// Composants StatCard et AlertItem inchangés
// ---------------------------------------------
class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 50) / 2;
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}

class AlertItem extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String affected;
  final String status;
  final Color statusColor;

  const AlertItem({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.affected,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: const Icon(Icons.shield, size: 28, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$date\n$location\n$affected"),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: statusColor,
              )),
        ),
      ),
    );
  }
}*/














///////////////////////////////////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:mobile_app/features/alert/presentation/pages/alert_list_page.dart';
import 'package:mobile_app/features/alert/presentation/pages/new_alert_step1_page.dart';
import 'package:mobile_app/features/alert/domain/alert_model.dart';
import 'package:mobile_app/features/user/domain/user_repository.dart';
import 'package:mobile_app/features/user/presentation/pages/profile_page.dart';

class DashboardPage extends StatefulWidget {
  final UserRepository userRepository;
  final String token;

  const DashboardPage({
    super.key,
    required this.userRepository,
    required this.token,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Initialisation correcte de la liste
    _pages = [
      const _DashboardHome(),
      const AlertsListPage(),
      ProfilePage(
        //userRepository: widget.userRepository,
        //token: widget.token,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Alertes"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  const _DashboardHome();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              StatCard(title: "Créées", value: "10"),
              StatCard(title: "En attente", value: "5"),
              StatCard(title: "Transmises", value: "15"),
              StatCard(title: "Évaluées", value: "3"),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewAlertStep1Page(alert: AlertModel()),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: const Text(
                "Créer une alerte",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 25),
          const Text(
            "Dernières alertes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),
          const AlertItem(
            title: "Inondation",
            date: "28 Oct 2025",
            location: "Boucle du Mouhoun, Balé, Sibi",
            affected: "250 personnes",
            status: "Urgent",
            statusColor: Colors.red,
          ),
          const AlertItem(
            title: "Sécheresse",
            date: "25 Oct 2025",
            location: "Est, Komondjari",
            affected: "80 personnes",
            status: "Évalué",
            statusColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 50) / 2;
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}

class AlertItem extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String affected;
  final String status;
  final Color statusColor;

  const AlertItem({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.affected,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: const Icon(Icons.shield, size: 28, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("$date\n$location\n$affected"),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            status,
            style: TextStyle(fontWeight: FontWeight.bold, color: statusColor),
          ),
        ),
      ),
    );
  }
}
