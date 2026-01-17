
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'bouton_config.dart';


final List<String> liste0127 = [...List.generate(128, (i) => i.toString()), "Aucun sélectionné"];
final List<int> listeMidi0127 = [...List.generate(129, (i) => i.toInt()), ];
final List<String> listVelocite = [...List.generate(128, (i) => i.toString()), ];
const List<int> ccList = <int>[ 
  128,  //Aucun sélectionné
  0,   // Selection de banque
  1,   // Roue de modulation
  2,   // Controleur de souffle
  4,   // Pédale de pied continue
  5,   // Temps de portamento
  6,   // Curseur d'entrée de données
  7,   // Volume
  8,   // Balance
  10,  // Panoramique
  11,  // Expression
  12,  // Contrôle d'effet 1
  13,  // Contrôle d'effet 2
  16,  // Réglage continu général 1
  17,  // Réglage continu général 2
  18,  // Réglage continu général 3
  19,  // Réglage continu général 4
  70,  // Variation (Contrôle de son n°1)
  71,  //Timbre (Contrôle de son n°2)
  72,  // Temps de relâchement
  73,  // Temps d'attaque
  74,  // Timbre / Brillance (Contrôle de son n°2/5)
  75,  // Contrôle de son n°6
  76,  // Contrôle de son n°7
  77,  // Contrôle de son n°8
  78,  // Contrôle de son n°9
  79,  // Contrôle de son n°10
  91,  // Niveau d'effet (Reverb)
  92,  // Niveau de trémolo
  93,  // Niveau de Chorus
  94,  // Niveau de Vibrato
  95   // Niveau de Phaser
];
const List<String> list = <String>[
  "Aucun sélectionné",
  "Selection de banque",
  "Roue de modulation",
  "Controleur de souffle",
  "Pédale de pied continue",
  "Temps de portamento",
  "Curseur d entrée de données",
  "Volume",
  "Balance",
  "Panoramique",
  "Expression",
  "Contrôle d'effet 1",
  "Contrôle d'effet 2",
  "Reglage continu géneral 1 ",
  "Reglage continu géneral 2 ",
  "Reglage continu géneral 3 ", 
  "Reglage continu géneral 4 ",
  "Variation (Contrôle de son n°1)",
  "Timbre (Contrôle de son n°2)",
  "Temps de relâchement",
  "Temps d'attaque",
  "Brillance",
  "Contrôle de son n°6", 
  "Contrôle de son n°7", 
  "Contrôle de son n°8", 
  "Contrôle de son n°9", 
  "Contrôle de son n°10", 
  "Niveau d'effet", 
  "Niveau de trémolo", 
  "Niveau de Chorus", 
  "Niveau de Vibrato", 
  "Niveau de phaser"
];
const List<String> listMode = <String>[
  "Mode Manuel",
  "Mode gamme (Grave)", 
  "Mode gamme (Médium-Grave)",
  "Mode gamme (Médium-Aigu)",
  "Mode gamme (aigu)", 
  "Mode Custom"
];
const List<String>listpreset = <String>["Aucun preset sélectionné", "Preset 1", "Preset 2", "Preset 3"];
final List<String> notesMidi = [ "0 - Do-1", "1 - Do#-1", "2 - Ré-1", "3 - Ré#-1", "4 - Mi-1", "5 - Fa-1", "6 - Fa#-1", "7 - Sol-1", "8 - Sol#-1", "9 - La-1", "10 - La#-1", "11 - Si-1", "12 - Do0", "13 - Do#0", "14 - Ré0", "15 - Ré#0", "16 - Mi0", "17 - Fa0", "18 - Fa#0", "19 - Sol0", "20 - Sol#0", "21 - La0", "22 - La#0", "23 - Si0", "24 - Do1", "25 - Do#1", "26 - Ré1", "27 - Ré#1", "28 - Mi1", "29 - Fa1", "30 - Fa#1", "31 - Sol1", "32 - Sol#1", "33 - La1", "34 - La#1", "35 - Si1", "36 - Do2", "37 - Do#2", "38 - Ré2", "39 - Ré#2", "40 - Mi2", "41 - Fa2", "42 - Fa#2", "43 - Sol2", "44 - Sol#2", "45 - La2", "46 - La#2", "47 - Si2", "48 - Do3", "49 - Do#3", "50 - Ré3", "51 - Ré#3", "52 - Mi3", "53 - Fa3", "54 - Fa#3", "55 - Sol3", "56 - Sol#3", "57 - La3", "58 - La#3", "59 - Si3", "60 - Do4", "61 - Do#4", "62 - Ré4", "63 - Ré#4", "64 - Mi4", "65 - Fa4", "66 - Fa#4", "67 - Sol4", "68 - Sol#4", "69 - La4", "70 - La#4", "71 - Si4", "72 - Do5", "73 - Do#5", "74 - Ré5", "75 - Ré#5", "76 - Mi5", "77 - Fa5", "78 - Fa#5", "79 - Sol5", "80 - Sol#5", "81 - La5", "82 - La#5", "83 - Si5", "84 - Do6", "85 - Do#6", "86 - Ré6", "87 - Ré#6", "88 - Mi6", "89 - Fa6", "90 - Fa#6", "91 - Sol6", "92 - Sol#6", "93 - La6", "94 - La#6", "95 - Si6", "96 - Do7", "97 - Do#7", "98 - Ré7", "99 - Ré#7", "100 - Mi7", "101 - Fa7", "102 - Fa#7", "103 - Sol7", "104 - Sol#7", "105 - La7", "106 - La#7", "107 - Si7", "108 - Do8", "109 - Do#8", "110 - Ré8", "111 - Ré#8", "112 - Mi8", "113 - Fa8", "114 - Fa#8", "115 - Sol8", "116 - Sol#8", "117 - La8", "118 - La#8", "119 - Si8", "120 - Do9", "121 - Do#9", "122 - Ré9", "123 - Ré#9", "124 - Mi9", "125 - Fa9", "126 - Fa#9", "127 - Sol9", ];
final List<String> programChangeList = [ "0 - Piano acoustique 1", "1 - Piano acoustique 2", "2 - Piano électrique 1", "3 - Piano électrique 2", "4 - Piano honky-tonk", "5 - Piano électrique 3", "6 - Clavecin", "7 - Clavinet", "8 - Célesta", "9 - Glockenspiel", "10 - Boîte à musique", "11 - Vibraphone", "12 - Marimba", "13 - Xylophone", "14 - Cloches tubulaires", "15 - Dulcimer", "16 - Orgue drawbar", "17 - Orgue percussif", "18 - Orgue rock", "19 - Orgue d'église", "20 - Orgue à anches", "21 - Accordéon", "22 - Harmonica", "23 - Bandoneon", "24 - Guitare nylon", "25 - Guitare acier", "26 - Guitare jazz", "27 - Guitare clean", "28 - Guitare palm mute", "29 - Guitare overdrive", "30 - Guitare disto", "31 - Guitare harmonique", "32 - Basse acoustique", "33 - Basse finger", "34 - Basse pick", "35 - Basse fretless", "36 - Basse slap 1", "37 - Basse slap 2", "38 - Basse synthé 1", "39 - Basse synthé 2", "40 - Violon", "41 - Alto", "42 - Violoncelle", "43 - Contrebasse", "44 - Cordes tremolo", "45 - Cordes pizzicato", "46 - Harpe", "47 - Timbales", "48 - Ensemble cordes 1", "49 - Ensemble cordes 2", "50 - Synth strings 1", "51 - Synth strings 2", "52 - Chœur ahh", "53 - Chœur ooh", "54 - Voix synthé", "55 - Orchestre hit", "56 - Trompette", "57 - Trombone", "58 - Tuba", "59 - Trompette bouchée", "60 - Cor d’harmonie", "61 - Cuivres", "62 - Synth brass 1", "63 - Synth brass 2", "64 - Sax soprano", "65 - Sax alto", "66 - Sax ténor", "67 - Sax baryton", "68 - Hautbois", "69 - Cor anglais", "70 - Basson", "71 - Clarinette", "72 - Piccolo", "73 - Flûte traversière", "74 - Flûte à bec", "75 - Flûte de pan", "76 - Bouteille soufflée", "77 - Shakuhachi", "78 - Sifflet", "79 - Ocarina", "80 - Lead square", "81 - Lead saw", "82 - Lead calliope", "83 - Lead chiff", "84 - Lead charang", "85 - Lead voix", "86 - Lead fifths", "87 - Lead bass+lead", "88 - Pad new age", "89 - Pad warm", "90 - Pad polysynth", "91 - Pad choir", "92 - Pad bowed", "93 - Pad metallic", "94 - Pad halo", "95 - Pad sweep", "96 - FX pluie", "97 - FX sonorité", "98 - FX cristal", "99 - FX atmosphère", "100 - FX brightness", "101 - FX goblins", "102 - FX écho", "103 - FX sci-fi", "104 - Sitar", "105 - Banjo", "106 - Shamisen", "107 - Koto", "108 - Kalimba", "109 - Cornemuse", "110 - Violon irlandais", "111 - Steel drums", "112 - Woodblock", "113 - Taiko", "114 - Tom mélodique", "115 - Tambourin", "116 - Agogo", "117 - Maracas", "118 - Sifflet court", "119 - Sifflet long", "120 - Guiro court", "121 - Guiro long", "122 - Claves", "123 - Castagnettes", "124 - Surdo", "125 - Triangle", "126 - Shaker", "127 - Bell tree", "Aucun sélectionné" ];
List<BoutonConfig> configBoutons = List.generate(32, (_) => BoutonConfig());

int modeActuel = 0; // valeur par défaut

class MyApp extends StatefulWidget { 
  const MyApp({super.key}); 
  @override State<MyApp> createState() => _MyAppState(); }
class _MyAppState extends State<MyApp> {  
  final GestionBLE ble = GestionBLE();
  int preset = 0;
  bool enregistrementEnabled = false;
  bool enregistrement2 = false;
  bool ModeUart = false;
  void savePreset(String presetName) {   //enregistre dans la base de donnée
  //enregistrement du tableau configboutons dans la base de donnée hive dans la box presets dans le nom du preset
  var box = Hive.box('presets');
  box.put(presetName, configBoutons); 
  }
  //chargement des presets enregistré
  void loadPreset(String presetName) { 
    var box = Hive.box('presets'); 
    if (box.containsKey(presetName))  { //si le nom du preset existe on adapte le tableau configboutons au preset choisi
      List<dynamic> data = box.get(presetName); 
      configBoutons = data.cast<BoutonConfig>(); 
      }
  }
  //envoie de la configuration actuel à l'ESP32
  Future<void> sendAllButtonsConfig() async {
  for (int i = 0; i < 32; i++) {
    BoutonConfig b = configBoutons[i];

    await ble.writeToCharacteristic(
      "6fe3f4e0-9835-48e5-9e44-74a5d48675d5",
      "68dc20a1-9f30-4166-a142-171ccf6d5a39",
      [ i,                // numéro du bouton (0 à 31)
      b.canal - 1,      // canal MIDI (0–15)
      b.note,
      b.velocite,
      b.pc,
      b.volume,
      b.pan,
      b.expression,
      b.brillance,
      b.tremolo,
      b.chorus,
      b.timbre,
      b.vibrato,
      b.phaser,
    ],
    );

    await Future.delayed(const Duration(milliseconds: 10)); 
    // délais pour éviter de saturer le BLE
  }
}



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Clavier MIDI',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Clavier Midi'),
        ),
        body: SingleChildScrollView(
          child: Column(
          children: [ 
            BleScannerWidget(ble: ble), //On génère les boutons de connection du BLE 

            DropdownButtons(numero: 1, ble : ble, text: "Potentiomètre gauche", Mode: "CC"), //On génère 4 boutons de type dropdown
            DropdownButtons(numero: 2, ble : ble, text: "Slider gauche" , Mode: "CC"), 
            DropdownButtons(numero: 3, ble : ble, text: "Slider droit" , Mode: "CC"), 
            DropdownButtons(numero: 4, ble : ble, text: "Potentiomètre droit", Mode: "CC"), 
            
            SizedBox(
              height: 220, // hauteur du tableau
              child: Padding(
                padding: const EdgeInsets.all(5), //espace de 5 pixel entre les boutons
                child: GridView.count(
                  crossAxisCount: 8, // 8 colonnes
                  mainAxisSpacing: 2, // espace vertical
                  crossAxisSpacing: 2, // espace horizontal
                  shrinkWrap: true, // ✅ réduit la taille au contenu
                  children: [
                    for (int i = 1; i <= 32; i++) ...[ //on génère le 32 boutons
                      if (i >= 1 && i <= 4 || i>=29 && i<=32) 
                        CustomButton(
                        label: "N°$i",
                        num: i,
                        ble: ble,
                       ),
                      if (i >= 5 && i <= 8)
                       CustomButton(
                       label: "N°${i + 12}",
                       num: i+12,
                       ble: ble,
                      ),
                      if (i >=9  && i <=12)
                       CustomButton(
                       label: "N°${i -4}",
                       num: i-4,
                       ble: ble,
                      ),
                      if (i >= 13 && i <= 16)
                       CustomButton(
                       label: "N°${i + 8}",
                       num: i+8,
                       ble: ble,
                      ),
                      if (i >= 17 && i <= 20)
                       CustomButton(
                       label: "N°${i - 8}",
                       num: i-8,
                       ble: ble,
                      ),
                      if (i >= 21 && i <= 24)
                       CustomButton(
                       label: "N°${i + 4}",
                       num: i+4,
                       ble: ble,
                      ),
                      if (i >= 25 && i <= 28)
                       CustomButton(
                       label: "N°${i - 12}",
                       num: i-12,
                       ble: ble,
                      ),
                    ],
                  ],
                ),
              ),
            ), 
            DropdownButtons(ble: ble, numero: 0, Mode: "Mode", text: "Mode "), //Bouton de type dropdown pour les modes
          Row( children : [
            DropdownButtons(ble: ble, numero: 0, Mode: "preset", text: "Preset",
            onChanged: (value) { 
                preset = listpreset.indexOf(value); 
                setState(() { 
                  if (preset == 1) {
                    loadPreset("preset1"); 
                    sendAllButtonsConfig();
                    }
                  if (preset == 2){
                    loadPreset("preset2");
                    sendAllButtonsConfig();
                    } 
                  if (preset == 3){
                     loadPreset("preset3");
                     sendAllButtonsConfig();
                     } 
                  });
              }
            ),

            ElevatedButton( onPressed: () { 
              setState(() { 
              if (preset == 1){
                 savePreset("preset1");
                 }
              if (preset == 2){ 
                savePreset("preset2");
              }
              if (preset == 3) {
                savePreset("preset3");
                }
              }
             );
            }, 
            style: ElevatedButton.styleFrom( 
              backgroundColor: Colors.blue, 
              foregroundColor: Colors.white, 
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16), 
              textStyle: const TextStyle( fontSize: 15, fontWeight: FontWeight.bold,
              ),
             ), 
            child: const Text("Sauvegarder"), 
            ),
            ]
           ),
           SizedBox(height: 20 ),
           Row(children: [
              const Text( "Enregistrement : ", 
              style: TextStyle(fontSize: 16, 
                fontWeight: FontWeight.bold
                ),
                ),
              Switch( value: enregistrementEnabled, 
              activeTrackColor: Colors.blueAccent, //bouton bleu quand activé 
              onChanged: (value) { 
                setState(() { 
                  enregistrementEnabled = value; 
                  if (enregistrementEnabled == true){
                    ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "101ce6c9-03e4-4334-a1b5-5e569bcd8433", [1]);
                  }
                  else{
                    ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "101ce6c9-03e4-4334-a1b5-5e569bcd8433", [0]);
                  }
                }
               );
              }, 
            ),
            ElevatedButton( onPressed: () { 
            setState(() { 
              ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "101ce6c9-03e4-4334-a1b5-5e569bcd8433", [2]);
              }
             );
            }, 
            style: ElevatedButton.styleFrom( 
              backgroundColor: Colors.blue, 
              foregroundColor: Colors.white, 
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12), 
              textStyle: const TextStyle( fontSize: 15, fontWeight: FontWeight.bold,
              ),
             ), 
            child: const Text("Lancement"), 
            ),
           ],
           ), 
           Row(children: [
              const Text( "Enregistrement 2 :", 
              style: TextStyle(fontSize: 16, 
                fontWeight: FontWeight.bold
                ),
                ),
              Switch( value: enregistrement2, 
              activeTrackColor: Colors.blueAccent, //bouton bleu quand activé 
              onChanged: (value) { 
                setState(() { 
                  enregistrement2 = value; 
                  if (enregistrement2 == true){
                    ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "101ce6c9-03e4-4334-a1b5-5e569bcd8433", [5]);
                  }
                  else{
                    ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "101ce6c9-03e4-4334-a1b5-5e569bcd8433", [4]);
                  }
                }
               );
              }, 
            ),
            ElevatedButton( onPressed: () { 
            setState(() { 
              ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "101ce6c9-03e4-4334-a1b5-5e569bcd8433", [3]);
              }
             );
            }, 
            style: ElevatedButton.styleFrom( 
              backgroundColor: Colors.blue, 
              foregroundColor: Colors.white, 
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12), 
              textStyle: const TextStyle( fontSize: 15, fontWeight: FontWeight.bold,
              ),
             ), 
            child: const Text("Lancement"), 
            ),
           ],
           ), 
           Row(children: [
            Text( "Mode logiciel :", 
              style: TextStyle(fontSize: 16, 
                fontWeight: FontWeight.bold
                ),
                ),
              Switch( value: ModeUart, 
              activeTrackColor: Colors.blueAccent, //bouton bleu quand activé 
              onChanged: (value) { 
                setState(() { 
                  ModeUart = value; 
                  if (ModeUart == true){
                    ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "101ce6c9-03e4-4334-a1b5-5e569bcd8433", [6]);
                  }
                  else{
                    ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "101ce6c9-03e4-4334-a1b5-5e569bcd8433", [7]);
                  }
                }
               );
              }, 
            ),
            Text( " : Mode filaire ", 
              style: TextStyle(fontSize: 16, 
                fontWeight: FontWeight.bold
                ),
                ),
           ],
           )
          ],
        ),
      ),
     )
    );
  }
}

//classe qui gère les boutons qui changent de couleur
class CustomButton extends StatefulWidget {
  final String label;          // texte du bouton
  final int num;               //numéro du bouton
  final GestionBLE ble;        //gestion du ble

  const CustomButton({
    super.key,
    required this.label,
    required this.num,
    required this.ble
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}
class _CustomButtonState extends State<CustomButton> {
  int _colorIndex = 0; // commence à 0

  final List<Color> _colors = [
    Colors.grey,
    Colors.green,
    Colors.red,
    Colors.orange,
  ];
 // Trame globale de 8 octets
  static List<int> trame = List<int>.filled(8, 0);
  // Met à jour uniquement les bits du bouton num
  Future<List<int>> Traitement(int number, int valeur) async{
    int octetIndex = (number - 1) ~/ 4;        // quel octet (~/ divise et retourne un entier)
    int position   = ((number - 1) % 4) * 2;   // position des 2 bits

    // Efface les 2 bits existants
    trame[octetIndex] &= ~(0x03 << position);

    // Insère la nouvelle valeur (0..3)
    trame[octetIndex] |= (valeur & 0x03) << position;

   // Envoie la trame complète via BLE
    await widget.ble.writeToCharacteristic(
    "4fafc201-1fb5-459e-8fcc-c5c9c331914b",  //service des LED 
    "beb5483e-36e1-4688-b7f5-ea07361b26a8",  //Caractérique des LED
    trame,    //envoie d'une trame de 8 octets
  );

    return trame;
  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { 
        //on modifie l'état interne
        setState(() {
          _colorIndex = (_colorIndex + 1) % _colors.length; 
        });
     
        // on exécute l'action passée en paramètre
        Traitement(widget.num, _colorIndex ); //on rentre le numéro du bouton modifié
       
     
      },

     onLongPress: () {
      if (modeActuel != 5) { //tant qu'on est dans un autre mode que le custom
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Accès interdit : active le Mode Custom"),
          duration: Duration(seconds: 2),
        ),
        );
        return; // on empêche l’ouverture
      }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Page_Reglage(ble: widget.ble, num: widget.num),
      ),
    );
  },




      style: ElevatedButton.styleFrom(
      backgroundColor: _colors[_colorIndex], 
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // coins arrondies
        ),
      ),
      child: Text(widget.label,
        style: TextStyle(
        fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

//classe qui gère la liste de Control change pour les potentiomètres
class DropdownButtons extends StatefulWidget {
  final int numero; //numéro du potentiomère 
  final GestionBLE ble; //gestion du ble
  final String text;
  final String Mode;

  final String? initialValue;
  final Function(String)? onChanged;

  const DropdownButtons({super.key, 
  required this.numero, 
  required this.Mode,
  required this.text,
  required this.ble,
  this.onChanged,
  this.initialValue
  });

  @override
  State<DropdownButtons> createState() => _DropdownButtonsState();
}
class _DropdownButtonsState extends State<DropdownButtons> {
  late String dropdownValue;        // valeur sélectionnée (en texte)
  late List<String> optionsText;    // liste affichée dans le dropdown

  @override
  void initState() {
    super.initState();

    // On choisit la liste à afficher en fonction du Mode
    switch (widget.Mode) {
      case "CC":
        optionsText = list;              // liste de noms de CC
        dropdownValue = list.first;
        break;

      case "Mode":
        optionsText = listMode;          // liste de modes
        dropdownValue = listMode.first;
        break;

      case "preset":
        optionsText = listpreset;          // liste des presets
        dropdownValue = listpreset.first;
        break;

      case "Canal":
        optionsText = List.generate(16, (i) => "Canal ${i + 1}");
        break;

      case "Note":
        optionsText = notesMidi;
        break;

      case "PC":
        optionsText = programChangeList;
        break;

      case "velocite": 
        optionsText = listVelocite;
        break;

      case "7b": 
        optionsText = liste0127;
        break;

      default:
        optionsText = ["Aucun"];
        dropdownValue = "Aucun";
        break;
    }
    if (widget.initialValue != null && optionsText.contains(widget.initialValue)) { //on vérifie que le ce qui est dans intialvalue correspond à un élément de la liste
     dropdownValue = widget.initialValue!; 
     } 
    else { 
      dropdownValue = optionsText.first; 
    }
  }

  // Fonction qui s'occupe d'envoyer selon le Mode
  void _handleChange(String selected) {
    int index = optionsText.indexOf(selected);

    switch (widget.Mode) {
      case "CC":
        // On récupère le numéro de CC depuis ccList via l'index
        int ccNumber = ccList[index];
        print("Numéro CC : $ccNumber");

        // envoi de la valeur dans la bonne caractéristique selon le numéro du potentiomètre
        if (widget.numero == 1) {
          widget.ble.writeToCharacteristic(
            "6fe3f4e0-9835-48e5-9e44-74a5d48675d5",
            "64306d43-dc18-421a-a9ab-a8b1d20799e8",
            [ccNumber],
          );
        } else if (widget.numero == 2) {
          widget.ble.writeToCharacteristic(
            "6fe3f4e0-9835-48e5-9e44-74a5d48675d5",
            "85a48dad-e829-445d-a3e5-eeba64d897cb",
            [ccNumber],
          );
        } else if (widget.numero == 3) {
          widget.ble.writeToCharacteristic(
            "6fe3f4e0-9835-48e5-9e44-74a5d48675d5",
            "eafceaa7-9db4-45c3-add4-fc56d39b922d",
            [ccNumber],
          );
        } else if (widget.numero == 4) {
          widget.ble.writeToCharacteristic(
            "6fe3f4e0-9835-48e5-9e44-74a5d48675d5",
            "33d0e5ba-f361-45ca-b383-a31e3c2f9fe2",
            [ccNumber],
          );
        }
        break;

      case "Mode":
        // index = numéro du mode choisi
        print("Mode choisi index = $index");
        modeActuel = index;
        widget.ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "7997337d-892c-4b9b-9855-f011502d8052", [index]);
        break;

      case "preset":
        
        break;


      default:
        print("Mode inconnu : ${widget.Mode}");
        break;
    }
    if (widget.onChanged != null) { widget.onChanged!(selected); }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          " ${widget.text}:",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          style: const TextStyle(color: Colors.black),
          underline: Container(height: 2, color: Colors.blue),
          onChanged: (String? value) {
            if (value == null) return;
            setState(() {
              dropdownValue = value;
            });
            _handleChange(value); 
          },
          items: optionsText.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  } 
}

//classe qui gère la partie visible de la connection et déconnection BLE
class BleScannerWidget extends StatefulWidget {
  final GestionBLE ble;
  const BleScannerWidget({super.key, required this.ble});
  
  @override
  State<BleScannerWidget> createState() => _BleScannerWidgetState();
}
class _BleScannerWidgetState extends State<BleScannerWidget> {
  String _status = "Non connecté"; // état initial

  //fonction qui scan le BLE et se connecte à l'appareil MIDI player
  Future<void> _scan() async {
    setState(() {
      _status = "Scan en cours...";
    });

    bool found = await widget.ble.scanAndConnectMidiPlayer();

    setState(() {
      _status = found ? "Clavier connecté" : "Clavier non connecté";
    });
  }

  //fonction de déconnection
  Future<void> _deconnection() async {
    setState(() {
      _status = "Non connecté";
    });

    widget.ble.disconnect();
  }

 @override
 Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          ElevatedButton(
            onPressed: _scan, //quand appuie sur le bouton, on appelle la fonction scan
            child: const Text("Scanner BLE"),
          ),
          const SizedBox(width: 20),
          Text(
            _status,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),  
          ],
          ),

          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: _deconnection, //quand on appuie sur le bouton on appelle la fonction deconnection
            child: const Text("Déconnexion"),
       ),
    ],
  );
 }
}

//Page secondaire qui sert en mode custom pour gerer les paramètres de chaque bouton 
class Page_Reglage extends StatefulWidget { 
  final GestionBLE ble;
  final int num; 
  const Page_Reglage({ super.key, 
    required this.ble,
    required this.num, 
    }
    ); 
  @override State<Page_Reglage> createState() => _Page_ReglageState(); 
  }
class _Page_ReglageState extends State<Page_Reglage> {
  
  int canal = 0; int note = 0; int velocite = 1; int pc = 0; int volume = 0; int Panoramique = 0; int expression = 0; int brillance = 0; int tremolo = 0; int chorus = 0; int timbre = 0; int vibrato = 0; int phaser = 0;
  
  late int numero;  //num - 1
  late BoutonConfig bouton; // configuration du bouton 

  @override void initState() { super.initState(); // 
  numero = widget.num - 1; 
  bouton = configBoutons[numero];  //configuration du bouton n°x
  //On récupère les parammètres enregistré
  canal = bouton.canal;
  note = bouton.note;
  velocite = bouton.velocite;
  pc = bouton.pc;
  volume = bouton.volume;
  Panoramique = bouton.pan;
  expression = bouton.expression;
  brillance = bouton.brillance;
  tremolo = bouton.tremolo;
  chorus = bouton.chorus;
  timbre = bouton.timbre;
  vibrato = bouton.vibrato;
  phaser = bouton.phaser;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Réglage du bouton $numero")
        ),
      body: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [ 
              DropdownButtons( numero: 0, ble: widget.ble, text: " Le Canal N° ", Mode: "Canal", initialValue: "Canal $canal",
              onChanged: (value) { 
                canal = int.parse(value.replaceAll("Canal ", "")); 
                },
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Le numéro de la note", Mode: "Note", initialValue: notesMidi[note],
              onChanged: (value) { 
                note = notesMidi.indexOf(value); 
              }
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Vélocité", Mode: "velocite", initialValue: liste0127[velocite],
              onChanged: (value) { 
                velocite = liste0127.indexOf(value); 
                velocite = listeMidi0127[velocite];
              }
              ),
              DropdownButtons( numero: 0, ble: widget.ble, text: "Programme change", Mode: "PC", initialValue: programChangeList[pc],
              onChanged: (value) { 
                pc = programChangeList.indexOf(value); 
                pc = listeMidi0127[pc];
              }
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Volume", Mode: "7b", initialValue: liste0127[volume],
              onChanged: (value) { 
                volume = liste0127.indexOf(value); 
                volume = listeMidi0127[volume];
              }
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Panoramique", Mode: "7b", initialValue: liste0127[Panoramique],
              onChanged: (value) { 
                Panoramique = liste0127.indexOf(value); 
                Panoramique = listeMidi0127[Panoramique];
              }
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Expression", Mode: "7b", initialValue: liste0127[expression],
              onChanged: (value) { 
                expression = liste0127.indexOf(value); 
                expression = listeMidi0127[expression];
              }
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Brillance", Mode: "7b", initialValue: liste0127[brillance],
              onChanged: (value) { 
                brillance = liste0127.indexOf(value); 
                brillance = listeMidi0127[brillance];
              }
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Niveau de trémolo", Mode: "7b", initialValue: liste0127[tremolo],
              onChanged: (value) { 
                tremolo = liste0127.indexOf(value); 
                tremolo = listeMidi0127[tremolo];
              }
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Niveau de chorus", Mode: "7b", initialValue: liste0127[chorus],
              onChanged: (value) { 
                chorus = liste0127.indexOf(value); 
                chorus = listeMidi0127[chorus];
              }
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Timbre", Mode: "7b", initialValue: liste0127[timbre],
              onChanged: (value) { 
                timbre = liste0127.indexOf(value); 
                timbre = listeMidi0127[timbre];
              }
              ),
              DropdownButtons( numero: 0, ble: widget.ble, text: "Niveau de vibrato", Mode: "7b", initialValue: liste0127[vibrato],
              onChanged: (value) { 
                vibrato = liste0127.indexOf(value); 
                vibrato = listeMidi0127[vibrato];
              }
              ), 
              DropdownButtons( numero: 0, ble: widget.ble, text: "Niveau de phaser", Mode: "7b", initialValue: liste0127[phaser],
              onChanged: (value) { 
                phaser = liste0127.indexOf(value); 
                phaser = listeMidi0127[phaser];
              }
              ), 
              Center( 
                child: ElevatedButton( 
                  onPressed: () { 
                    widget.ble.writeToCharacteristic("6fe3f4e0-9835-48e5-9e44-74a5d48675d5", "68dc20a1-9f30-4166-a142-171ccf6d5a39",
                     [numero, canal-1, note, velocite, pc,volume, Panoramique, expression, brillance, tremolo, chorus, timbre, vibrato, phaser]);
                     //enregistrement des paramètres modifiés
                     bouton.canal = canal; 
                     bouton.note = note; 
                     bouton.pc = pc; 
                     bouton.velocite = velocite;
                     bouton.volume = volume; 
                     bouton.pan = Panoramique; 
                     bouton.expression = expression; 
                     bouton.brillance = brillance; 
                     bouton.tremolo = tremolo; 
                     bouton.chorus = chorus; 
                     bouton.timbre = timbre; 
                     bouton.vibrato = vibrato; 
                     bouton.phaser = phaser; 
                     
                     Navigator.pop(context); //on ferme la page secondaire 
                  }, 
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.blue, 
                     foregroundColor: Colors.white, 
                     padding: const EdgeInsets.symmetric( horizontal: 25, vertical: 16),
                     textStyle: const TextStyle( 
                      fontSize: 18, fontWeight: FontWeight.bold,
                      ), 
                  ), 
                  child: const Text("Valider"), 
                 ),
              ),
             ], 
        ), 
      );
  }
}

//Classe non visuel (uniquement pour le bluetooth)
class GestionBLE {
  BluetoothDevice? _connectedDevice;
  List<BluetoothService> _services = [];


  //fonction de scan qui renvoie un booléen qui indique si MIDI_PLAYER à été trouvé
  Future<bool> scanForMidiPlayer() async {
  final completer = Completer<bool>();


  // Démarre le scan
  await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

  StreamSubscription<List<ScanResult>>? sub;

  sub = FlutterBluePlus.scanResults.listen((results) async {
    final found = results.any((r) => r.device.platformName == "MIDI_PLAYER");

    if (found && !completer.isCompleted) {
      await FlutterBluePlus.stopScan(); // arrête le scan
      await sub?.cancel();              // annule l’écoute
      completer.complete(true);         //trouvé
    }
  });

  // ⚡️ Après le timeout, si rien n’a été trouvé, on complète avec false
  Future.delayed(const Duration(seconds: 4), () async {
    if (!completer.isCompleted) {
      await FlutterBluePlus.stopScan();
      await sub?.cancel();
      completer.complete(false);        //pas trouvé
    }
  });

  return completer.future;
}

  /// Scanne et se connecte directement à MIDI_PLAYER
  Future<bool> scanAndConnectMidiPlayer({Duration timeout = const Duration(seconds: 4)}) async {
    final completer = Completer<bool>();

    // Démarre le scan
    await FlutterBluePlus.startScan(timeout: timeout);

    StreamSubscription<List<ScanResult>>? sub;

    sub = FlutterBluePlus.scanResults.listen((results) async {
    final candidates = results.where((r) => r.device.platformName == "MIDI_PLAYER");
    final target = candidates.isNotEmpty ? candidates.first : null;

      if (target != null && !completer.isCompleted) {
        try {
          await FlutterBluePlus.stopScan();
          await sub?.cancel();

          // Connexion directe
          await target.device.connect(license: License.free);
          _connectedDevice = target.device;
          
          // Découverte des services
          _services = await _connectedDevice!.discoverServices();
          await Future.delayed(const Duration(seconds: 2));
      
          completer.complete(true); // ✅ connecté
        } catch (e) {
          completer.complete(false); // ❌ erreur de connexion
        }
      }
    });

    // Timeout : si rien trouvé
    Future.delayed(timeout, () async {
      if (!completer.isCompleted) {
        await FlutterBluePlus.stopScan();
        await sub?.cancel();
        completer.complete(false); // ❌ pas trouvé
      }
    });

    return completer.future;
  }

  // Scanner les périphériques BLE
  void scanDevices() {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 1));   // Démarre le scan pendant 1 secondes
    FlutterBluePlus.scanResults.listen((results) {                    // Écoute les résultats du scan
      for (var r in results) {
        if (r.device.platformName == 'MIDI_PLAYER');
        print(("Trouvé: ${r.device.platformName} - ${r.device.remoteId} (RSSI: ${r.rssi})"));
      } 
      });
   
   
   }
  //fonction de déconnection
  Future<void> disconnect() async {
      if (_connectedDevice != null) {
        await _connectedDevice!.disconnect();
        
        _connectedDevice = null;
        _services = [];
      }
    }
  //Fonction qui écrit dans la caractéristique et le service choisi, il écrit une liste en int
  Future<void> writeToCharacteristic(
    String serviceUuid, 
    String characteristicUuid, 
    List<int> data) async {
  
  if (_connectedDevice == null) {
    print("⚠️ Aucun périphérique connecté");
    return;
  }

  if (_services.isEmpty) {
    print("⚠️ Aucun service découvert");
    return;
  }

  try {
    // Cherche le service par UUID
    final service = _services.firstWhere(
      (s) => s.serviceUuid.toString().toLowerCase() == serviceUuid.toLowerCase(),
      orElse: () => throw Exception("Service $serviceUuid introuvable"),
    );

    // Cherche la caractéristique par UUID
    final characteristic = service.characteristics.firstWhere(
      (c) => c.characteristicUuid.toString().toLowerCase() == characteristicUuid.toLowerCase(),
      orElse: () => throw Exception("Caractéristique $characteristicUuid introuvable"),
    );

    // Vérifie que la caractéristique est bien en écriture
    if (!characteristic.properties.write && !characteristic.properties.writeWithoutResponse) {
      throw Exception("Caractéristique $characteristicUuid non inscriptible");
    }

    // Écrit les données
    await characteristic.write(data, withoutResponse: true);
    print("Données écrites: $data");
  } catch (e) {
    print("Erreur lors de l'écriture: $e");
  }
}
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Initialisation de Hive 
  await Hive.initFlutter(); // Enregistrement de l'adapter généré automatiquement 
  Hive.registerAdapter(BoutonConfigAdapter()); // Ouverture de la box des presets 
  await Hive.openBox('presets');
  runApp(MyApp());
}
 