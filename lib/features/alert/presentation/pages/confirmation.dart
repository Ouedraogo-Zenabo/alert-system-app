/*import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/alert_model.dart';

/// ------------------------------------------------------------
/// DIALOG : Confirmation d’envoi de l’alerte
/// ------------------------------------------------------------
Future<void> showConfirmationDialog(BuildContext context, AlertModel alert) {
  // Formatage du message (tu peux adapter selon ton modèle)
  final message = """
    [ALERTE ${alert.type?.toUpperCase() ?? "N/A"}] ${alert.evenement ?? ''} à ${alert.localisation ?? ''}. 
    ${alert.nombrePersonnes ?? ''} personnes affectées. Intervention urgente requise.
    Contact: ${alert.contact ?? ''}
    """;

  return showDialog(
    context: context,
    barrierDismissible: false, // Pour éviter la fermeture en cliquant ailleurs
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 350, // Rendre la popup responsive
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // -------------------------------------------------------------------
                // Titre
                // -------------------------------------------------------------------
                const Text(
                  "Transmettre l’alerte ?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Sous-titre
                Text(
                  "L’alerte sera envoyée par SMS à ${alert.destinataires?.length ?? 0} destinataires",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),

                const SizedBox(height: 20),

                // -------------------------------------------------------------------
                // Aperçu du message
                // -------------------------------------------------------------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Aperçu du message",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // Liste des destinataires
                Text(
                  "${alert.destinataires?.length ?? 0} destinataires : ${alert.destinataires?.join(', ') ?? ''}",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 25),

                // -------------------------------------------------------------------
                // Boutons
                // -------------------------------------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Bouton "Annuler"
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Annuler"),
                    ),

                    const SizedBox(width: 8),

                    // Bouton "Confirmer l'envoi"
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Appeler ton service d’envoi SMS
                        // sendAlert(alert);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Confirmer l’envoi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
*/