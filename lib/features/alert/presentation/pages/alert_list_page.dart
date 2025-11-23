import 'package:flutter/material.dart';
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
}
