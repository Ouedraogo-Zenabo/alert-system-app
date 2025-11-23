// lib/features/alert/data/models/alert_model.dart

/// Classe représentant une alerte complète.
/// Ce modèle regroupe toutes les informations collectées
/// lors des différentes étapes de création d'une alerte.
/*class AlertModel {
  // ============================
  // Étape 1 : Localisation
  // ============================
  String? region; // Exemple : "Centre"
  String? province; // Exemple : "Kadiogo"
  String? commune; // Exemple : "Ouagadougou"
  String? zone; // Optionnel : nom de la zone ou du quartier précis
  String? coordonnees; // Coordonnées GPS (latitude, longitude)
  String? village; // Optionnel : nom du village ou hameau
  String? date; // Date de l'événement
  String? time; // Heure de l'événement
  
  // ============================
  // Étape 2 : Événement
  // ============================
  String? typeEvenement; // Exemple : "Inondation", "Sécheresse", etc.
  List<String>? facteursDeclencheurs; // Exemples : ["Pluie intense", "Mauvais drainage"]
  double? ampleur; // De 0 à 1 pour représenter la gravité
  String? periode; // Exemple : "Saison des pluies"
  String? dureeEstimee; // Exemple : "3 jours"
  String? description; // Détails libres de l’événement
  

  // ============================
  // Étape 3 : Conséquences
  // ============================
   // Étape 3 : Conséquences
  
  List<String>? consequencesObservees;
  int? nbPersonnesAffectees;
  int? nbPersonnesDeplacees;
  int? nbDeces;
  int? nbBlesses;
  String? infrastructuresTouchees;
  String? besoinsUrgents;

  
 
  


  // ============================
  // Étape 4 : Rapporteur
  // ============================
  String? rapporteur; // Nom complet du rapporteur
  String? fonctionRapporteur; // Ex : "Agent de terrain", "Coordinateur régional"
  String? contactRapporteur; // Téléphone ou email

  // ============================
  // Étape 5 : Destinataires
  // ============================
  List<String>? destinataires; // Liste des personnes ou services à alerter
  String? niveauUrgence; // Exemple : "Faible", "Moyenne", "Élevée"

  // ============================
  // Métadonnées système
  // ============================
  String? id; // Identifiant unique (UUID ou ID généré par la base)
  DateTime? dateCreation; // Date d’enregistrement de l’alerte
  String? statut; // Exemple : "En attente", "Validée", "Transmise"
  String? source; // Exemple : "Application mobile", "Web", etc.

  AlertModel({
    // Étape 1
    this.region,
    this.province,
    this.commune,
    this.zone,
    this.coordonnees,
    this.date,
    this.time,
    this.village,

    // Étape 2
    this.typeEvenement,
    this.facteursDeclencheurs,
    this.ampleur,
    this.periode,
    this.dureeEstimee,
    this.description,

    // Étape 3
    
    this.consequencesObservees,
    this.nbPersonnesAffectees,
    this.nbPersonnesDeplacees,
    this.nbDeces,
    this.nbBlesses,
    this.infrastructuresTouchees,
    this.besoinsUrgents,

    // Étape 4
    this.rapporteur,
    this.fonctionRapporteur,
    this.contactRapporteur,

    // Étape 5
    this.destinataires,
    this.niveauUrgence,

    // Métadonnées
    this.id,
    this.dateCreation,
    this.statut,
    this.source,
  });

  // ============================
  // Méthodes utilitaires
  // ============================

  /// Convertir un objet AlertModel en Map (utile pour l’enregistrement Firebase ou SQLite)
  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'region': region,
    'province': province,
    'commune': commune,
    'zone': zone,
    'coordonnees': coordonnees,
    'typeEvenement': typeEvenement,
    'facteursDeclencheurs': facteursDeclencheurs,
    'ampleur': ampleur,
    'periode': periode,
    'dureeEstimee': dureeEstimee,
    'description': description,
    'consequencesObservees': consequencesObservees,
    'nbPersonnesAffectees': nbPersonnesAffectees,
    'nbPersonnesDeplacees': nbPersonnesDeplacees,
    'nbDeces': nbDeces,
    'nbBlesses': nbBlesses,
    'impactEconomique': impactEconomique,
    'rapporteur': rapporteur,
    'fonctionRapporteur': fonctionRapporteur,
    'contactRapporteur': contactRapporteur,
    'destinataires': destinataires,
    'niveauUrgence': niveauUrgence,
    'dateCreation': dateCreation?.toIso8601String(),
    'statut': statut,
    'source': source,
  };
}
  /// Créer un objet AlertModel à partir d’un Map (utile pour la lecture depuis une base)
factory AlertModel.fromMap(Map<String, dynamic> map) {
  return AlertModel(
    id: map['id'],
    region: map['region'],
    province: map['province'],
    commune: map['commune'],
    zone: map['zone'],
    coordonnees: map['coordonnees'],
    typeEvenement: map['typeEvenement'],
    facteursDeclencheurs: List<String>.from(map['facteursDeclencheurs'] ?? []),
    ampleur: (map['ampleur'] ?? 0).toDouble(),
    periode: map['periode'],
    dureeEstimee: map['dureeEstimee'],
    description: map['description'],
    consequencesObservees: List<String>.from(map['consequencesObservees'] ?? []),
    nbPersonnesAffectees: map['nbPersonnesAffectees'],
    nbPersonnesDeplacees: map['nbPersonnesDeplacees'],
    nbDeces: map['nbDeces'],
    nbBlesses: map['nbBlesses'],
    impactEconomique: (map['impactEconomique'] ?? 0).toDouble(),
    rapporteur: map['rapporteur'],
    fonctionRapporteur: map['fonctionRapporteur'],
    contactRapporteur: map['contactRapporteur'],
    destinataires: List<String>.from(map['destinataires'] ?? []),
    niveauUrgence: map['niveauUrgence'],
    dateCreation: map['dateCreation'] != null
        ? DateTime.parse(map['dateCreation'])
        : null,
    statut: map['statut'],
    source: map['source'],
  );
}*/





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class AlertModel {
  // ============================
  // Étape 1 : Localisation
  // ============================
  String? region;
  String? province;
  String? commune;
  String? zone;
  String? coordonnees;
  String? village;
  String? date;
  String? time;

  // ============================
  // Étape 2 : Événement
  // ============================
  String? typeEvenement;
  List<String>? facteursDeclencheurs;
  double? ampleur;
  String? periode;
  String? dureeEstimee;
  String? description;

  // ============================
  // Étape 3 : Conséquences
  // ============================
  List<String>? consequencesObservees;
  int? nbPersonnesAffectees;
  int? nbPersonnesDeplacees;
  int? nbDeces;
  int? nbBlesses;
  String? infrastructuresTouchees;
  String? besoinsUrgents;
  double? impactEconomique; 
  // ✅ Nouvel attribut pour stocker les chemins des photos
  List<String>? photos;

  // ============================
  // Étape 4 : Rapporteur
  // ============================
  String? rapporteurNom;
  String? rapporteurPrenom;
  String? rapporteurTelephone;
  String? rapporteurEmail;
  String? fonction;
  String? structure;
  String? languePreferee;

  // ============================
  // Étape 5 : Destinataires
  // ============================

  // Groupes sélectionnés (checkbox)
  Map<String, bool>? groupesDestinataires = {
    "Structures partenaires": false,
    "Autorités locales": false,
    "Équipes d’intervention": false,
  };

  // Canaux de communication (SMS / Email / Push)
  bool sendSMS = false;
  bool sendEmail = false;
  bool sendPush = false;

  // Destinataire personnalisé
  String? contactNom;
  String? contactTelephone;
  String? contactEmail;

  // Messages personnalisés
  String? smsMessage;
  String? emailMessage;
  final String? evenement; // Type d’événement (inondation, attaque, accident, etc.)
  final String? localisation;



  

  // ============================
  // Métadonnées système
  // ============================
  String? id;
  DateTime? dateCreation;
  String? statut;
  String? source;

  AlertModel({
    // Étape 1
    this.region,
    this.province,
    this.commune,
    this.zone,
    this.coordonnees,
    this.date,
    this.time,
    this.village,

    // Étape 2
    this.typeEvenement,
    this.facteursDeclencheurs,
    this.ampleur,
    this.periode,
    this.dureeEstimee,
    this.description,

    // Étape 3
    this.consequencesObservees,
    this.nbPersonnesAffectees,
    this.nbPersonnesDeplacees,
    this.nbDeces,
    this.nbBlesses,
    this.infrastructuresTouchees,
    this.besoinsUrgents,
    this.impactEconomique, 
    this.photos,

    // Étape 4
    this.rapporteurNom,
    this.rapporteurPrenom,
    this.rapporteurTelephone,
    this.rapporteurEmail,
    this.fonction,
    this.structure,
    this.languePreferee,

    // Étape 5
    

    this.groupesDestinataires,
    this.sendSMS = false,
    this.sendEmail = false,
    this.sendPush = false,
    this.contactNom,
    this.contactTelephone,
    this.contactEmail,
    this.smsMessage,
    this.emailMessage,
    this.evenement,
    this.localisation,

    


    // Métadonnées
    this.id,
    this.dateCreation,
    this.statut,
    this.source,
  });

  // ============================
  // Méthodes utilitaires
  // ============================
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'region': region,
      'province': province,
      'commune': commune,
      'zone': zone,
      'coordonnees': coordonnees,
      'typeEvenement': typeEvenement,
      'facteursDeclencheurs': facteursDeclencheurs,
      'ampleur': ampleur,
      'periode': periode,
      'dureeEstimee': dureeEstimee,
      'description': description,
      'consequencesObservees': consequencesObservees,
      'nbPersonnesAffectees': nbPersonnesAffectees,
      'nbPersonnesDeplacees': nbPersonnesDeplacees,
      'nbDeces': nbDeces,
      'nbBlesses': nbBlesses,
      'infrastructuresTouchees': infrastructuresTouchees,
      'besoinsUrgents': besoinsUrgents,
      'impactEconomique': impactEconomique, // ⚠ ajouté ici
      'rapporteurNom': rapporteurNom,  
      'rapporteurPrenom': rapporteurPrenom,
      'rapporteurTelephone': rapporteurTelephone,
      'rapporteurEmail': rapporteurEmail,
      'fonction': fonction,
      'structure': structure,
      'languePreferee': languePreferee,
      'groupesDestinataires': groupesDestinataires,
      'sendSMS': sendSMS,
      'sendEmail': sendEmail,
      'sendPush': sendPush,
      'contactNom': contactNom,
      'contactTelephone': contactTelephone,
      'contactEmail': contactEmail,
      'smsMessage': smsMessage,
      'emailMessage': emailMessage,
      'dateCreation': dateCreation?.toIso8601String(),
      'statut': statut,
      'source': source,
      'evenement': evenement,
      'localisation': localisation,

    };
  }

  factory AlertModel.fromMap(Map<String, dynamic> map) {
    return AlertModel(
      id: map['id'],
      region: map['region'],
      province: map['province'],
      commune: map['commune'],
      zone: map['zone'],
      coordonnees: map['coordonnees'],
      typeEvenement: map['typeEvenement'],
      facteursDeclencheurs: List<String>.from(map['facteursDeclencheurs'] ?? []),
      ampleur: (map['ampleur'] ?? 0).toDouble(),
      periode: map['periode'],
      dureeEstimee: map['dureeEstimee'],
      description: map['description'],
      consequencesObservees: List<String>.from(map['consequencesObservees'] ?? []),
      nbPersonnesAffectees: map['nbPersonnesAffectees'],
      nbPersonnesDeplacees: map['nbPersonnesDeplacees'],
      nbDeces: map['nbDeces'],
      nbBlesses: map['nbBlesses'],
      infrastructuresTouchees: map['infrastructuresTouchees'],
      besoinsUrgents: map['besoinsUrgents'],
      impactEconomique: (map['impactEconomique'] ?? 0).toDouble(), // ⚠ ajouté ici
      rapporteurNom: map['rapporteurNom'],
      rapporteurPrenom: map['rapporteurPrenom'],
      rapporteurTelephone: map['rapporteurTelephone'],
      rapporteurEmail: map['rapporteurEmail'],
      fonction: map['fonction'],
      structure: map['structure'],
      languePreferee: map['languePreferee'],
     groupesDestinataires: Map<String, bool>.from(map['groupesDestinataires'] ?? {}),
      sendSMS: map['sendSMS'] ?? false,
      sendEmail: map['sendEmail'] ?? false,
      sendPush: map['sendPush'] ?? false,
      contactNom: map['contactNom'],
      contactTelephone: map['contactTelephone'],
      contactEmail: map['contactEmail'],
      smsMessage: map['smsMessage'],
      emailMessage: map['emailMessage'],
      localisation: map['localisation'],

      
      dateCreation: map['dateCreation'] != null
          ? DateTime.parse(map['dateCreation'])
          : null,
      statut: map['statut'],
      source: map['source'],
    );
  }
}

