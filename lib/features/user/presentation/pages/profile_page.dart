/*import 'package:flutter/material.dart';
import 'package:mobile_app/features/user/data/models/user_model.dart';
import 'package:mobile_app/features/user/domain/user_repository.dart';


/// ------------------------------------------------------------
/// Page Profil — UI principale
/// ------------------------------------------------------------
class ProfilePage extends StatefulWidget {
  final UserRepository userRepository;
  final String token;

  const ProfilePage({
    super.key,
    required this.userRepository,
    required this.token,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  /// Charge profil depuis API puis local
  Future<void> _loadProfile() async {
    try {
      final fetchedUser =
          await widget.userRepository.getUserProfile(widget.token);

      setState(() {
        user = fetchedUser;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Erreur de chargement du profil.")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildPersonalInfo(),
            const SizedBox(height: 20),
            _buildStats(),
            const SizedBox(height: 20),
            _buildSettings(),
            const SizedBox(height: 20),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // HEADER (Nom + initiales)
  // ------------------------------
  Widget _buildHeader() {
    String initials = user!.name.isNotEmpty
        ? user!.name[0].toUpperCase()
        : "?";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26),
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Text(initials,
                style: const TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          Text(
            user!.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Point Focal Communal",
            style: TextStyle(color: Colors.white70),
          )
        ],
      ),
    );
  }

  // ------------------------------
  // INFORMATIONS PERSONNELLES
  // ------------------------------
  Widget _buildPersonalInfo() {
    return _buildCard(
      title: "Informations personnelles",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(Icons.phone, user!.phone),
          _infoRow(Icons.email, user!.email),
          _infoRow(Icons.location_on, user!.commune),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 15, color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  // ------------------------------
  // STATISTIQUES
  // ------------------------------
  Widget _buildStats() {
    return _buildCard(
      title: "Statistiques personnelles",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _statRow("Total", user!.totalAlerts),
          _statRow("Ce mois", user!.alertsThisMonth),
          _statRow("Transmises", user!.alertsTransmitted),
        ],
      ),
    );
  }

  Widget _statRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15)),
          const Spacer(),
          Text(value.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.black54)),
        ],
      ),
    );
  }

  // ------------------------------
  // PARAMÈTRES
  // ------------------------------
  Widget _buildSettings() {
    return _buildCard(
      title: "Paramètres",
      content: Column(
        children: const [
          _SettingSwitch(title: "Notifications"),
          _SettingSwitch(title: "Mode sombre"),
          _SettingSwitch(title: "Synchronisation auto"),
        ],
      ),
    );
  }

  // ------------------------------
  // BOUTON DÉCONNEXION
  // ------------------------------
  Widget _buildLogoutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
      ),
      onPressed: () async {
        await widget.userRepository.logout();

        // Retour à la page login
        Navigator.pushNamedAndRemoveUntil(
            context, "/login", (route) => false);
      },
      child: const Text("Déconnexion"),
    );
  }

  // ------------------------------
  // CARD (boîte blanche arrondie)
  // ------------------------------
  Widget _buildCard({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          content
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// Composant Switch pour les paramètres
/// ------------------------------------------------------------
class _SettingSwitch extends StatefulWidget {
  final String title;
  const _SettingSwitch({super.key, required this.title});

  @override
  State<_SettingSwitch> createState() => _SettingSwitchState();
}

class _SettingSwitchState extends State<_SettingSwitch> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.title),
      value: value,
      onChanged: (v) => setState(() => value = v),
    );
  }
}*/




////////////////////////////////////////////////////////////////////
library;



import 'package:flutter/material.dart';
import 'package:mobile_app/features/user/domain/user_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required UserRepository userRepository, required String token});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.3,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // -------------------------------------------------------
            // 1. CARTE PROFIL (photo, nom, rôle)
            // -------------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Cercle avatar avec initiales
                  CircleAvatar(
                    radius: width * 0.12,
                    backgroundColor: Colors.white,
                    child: const Text(
                      "MK",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "Kaboré Marie",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Point Focal Communal",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------------------------------------
            // 2. INFORMATIONS PERSONNELLES
            // -------------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informations personnelles",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _infoRow(
                    icon: Icons.phone_outlined,
                    title: "Téléphone",
                    value: "+226 75 23 45 67",
                  ),

                  const SizedBox(height: 15),

                  _infoRow(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: "m.kabore@commune-korsimoro.bf",
                  ),

                  const SizedBox(height: 15),

                  _infoRow(
                    icon: Icons.location_on_outlined,
                    title: "Commune",
                    value: "Korsimoro, Sanmatenga",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // -------------------------------------------------------
            // 3. Statistiques personnelles
            // -------------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Statistiques personnelles",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // --- Mini graph (barres)
                  SizedBox(
                    height: 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _bar(label: "Juil", value: 3),
                        _bar(label: "Août", value: 4),
                        _bar(label: "Sept", value: 6),
                        _bar(label: "Oct", value: 7),
                      ],
                    ),
                  ),

                  const Divider(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statNumber(label: "Total", value: "23"),
                      _statNumber(label: "Ce mois", value: "8"),
                      _statNumber(label: "Transmises", value: "15"),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            // -------------------------------------------------------
            // 4. PARAMÈTRES
            // -------------------------------------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Paramètres",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  _settingSwitch(
                    icon: Icons.notifications_none,
                    title: "Notifications",
                    subtitle: "Recevoir les notifications push",
                    value: true,
                  ),

                  _settingSwitch(
                    icon: Icons.dark_mode_outlined,
                    title: "Mode sombre",
                    subtitle: "Thème de l'application",
                    value: false,
                  ),

                  _settingSwitch(
                    icon: Icons.sync_outlined,
                    title: "Synchronisation auto",
                    subtitle: "Synchroniser automatiquement",
                    value: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // -------------------------------------------------------
            // 5. BOUTON DECONNEXION
            // -------------------------------------------------------
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  "Déconnexion",
                  style: TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {},
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // Widgets UI réutilisables
  // ===========================================================================

  static Widget _infoRow({required IconData icon, required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: Colors.grey.shade700),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        )
      ],
    );
  }

  static Widget _bar({required String label, required double value}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 20,
            height: value * 10,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  static Widget _statNumber({required String label, required String value}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  static Widget _settingSwitch({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 25, color: Colors.grey.shade700),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 15)),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),

        Switch(
          value: value,
          onChanged: (v) {},
        ),
      ],
    );
  }
}

