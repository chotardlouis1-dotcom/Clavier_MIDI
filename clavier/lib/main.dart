import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';


const List<String> list = <String>["Volume", "Balance", "Timbre", "Brillance"];
//'Roue de modulation', 'Controleur de souffle','Pedale de pied continue','Temps de portamento','Curseur entrée de données','Volume','Balance','Panoramique','Expression','Controle d effet 1','Controle d effet 2 ',' Réglage continu général 1' 
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GestionBLE ble = GestionBLE();
  
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
        body: Center(
          child: Column(
          children: [
            BleScannerWidget(ble: ble),

            for (int k = 1; k <= 4; k++)
              DropdownButtonPot(numero: k),
            

            SizedBox(
              height: 220, // hauteur fixe du tableau
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: GridView.count(
                  crossAxisCount: 8, // 8 colonnes
                  mainAxisSpacing: 2, // espace vertical
                  crossAxisSpacing: 2, // espace horizontal
                  shrinkWrap: true, // ✅ réduit la taille au contenu
                  children: [
                    for (int i = 1; i <= 32; i++) ...[
                      if (i >= 1 && i <= 4 || i>=29 && i<=32)
                        CustomButton(
                        label: "N°$i",
                        num: i,
                        ble: ble,
                        /*onPressed: () async {
                        // Exemple : écrire 8 octets dans la caractéristique MIDI BLE
                        await ble.writeToCharacteristic(
                        "4fafc201-1fb5-459e-8fcc-c5c9c331914b", // Service MIDI BLE
                        "beb5483e-36e1-4688-b7f5-ea07361b26a8", // Caractéristique MIDI BLE
                        [0x41, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0XFF, 0xFF],               // tableau de 8 octets
                        );
                      },*/
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
          
          
          
          ],
        ),
      ),
     )
    );
  }
}

class CustomButton extends StatefulWidget {
  final String label;          // texte du bouton
  final int num;               //numéro du bouton
  final GestionBLE ble;

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
    print(number);
    int octetIndex = (number - 1) ~/ 4;        // quel octet
    int position   = ((number - 1) % 4) * 2;   // position des 2 bits

    // Efface les 2 bits existants
    trame[octetIndex] &= ~(0x03 << position);

    // Insère la nouvelle valeur (0..3)
    trame[octetIndex] |= (valeur & 0x03) << position;

   // Envoie la trame complète via BLE
    await widget.ble.writeToCharacteristic(
    "4fafc201-1fb5-459e-8fcc-c5c9c331914b",
    "beb5483e-36e1-4688-b7f5-ea07361b26a8",
    trame,
  );

    return trame;
  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { 
        // et on modifie l'état interne
        setState(() {
          _colorIndex = (_colorIndex + 1) % _colors.length;
        });
     
        // on exécute l'action passée en paramètre
        Traitement(widget.num, _colorIndex );
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

class DropdownButtonPot extends StatefulWidget {
  final int numero; // <-- on ajoute un paramètre

  const DropdownButtonPot({super.key, required this.numero});

  @override
  State<DropdownButtonPot> createState() => _DropdownButtonPotState();
}

class _DropdownButtonPotState extends State<DropdownButtonPot> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Affiche le numéro au-dessus
        Text(
          " Potentiomètre ${widget.numero} : ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          style: const TextStyle(color: Colors.blue),
          underline: Container(height: 2, color: Colors.blue),
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
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

class BleScannerWidget extends StatefulWidget {
  final GestionBLE ble;
  const BleScannerWidget({super.key, required this.ble});
  
  @override
  State<BleScannerWidget> createState() => _BleScannerWidgetState();
}

class _BleScannerWidgetState extends State<BleScannerWidget> {
  String _status = "Non connecté"; // état initial

  // Ici tu appelles ta classe GestionBLE
  Future<void> _scan() async {
    setState(() {
      _status = "Scan en cours...";
    });

    bool found = await widget.ble.scanAndConnectMidiPlayer();

    setState(() {
      _status = found ? "Clavier connecté" : "Clavier non connecté";
    });
  }

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
            onPressed: _scan,
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
            onPressed: _deconnection,
            child: const Text("Déconnexion"),
       ),
    ],
  );
 }
}

class GestionBLE {
  BluetoothDevice? _connectedDevice;
  List<BluetoothService> _services = [];

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
      completer.complete(true);         // ✅ trouvé
    }
  });

  // ⚡️ Après le timeout, si rien n’a été trouvé, on complète avec false
  Future.delayed(const Duration(seconds: 4), () async {
    if (!completer.isCompleted) {
      await FlutterBluePlus.stopScan();
      await sub?.cancel();
      completer.complete(false);        // ❌ pas trouvé
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

  Future<void> disconnect() async {
      if (_connectedDevice != null) {
        await _connectedDevice!.disconnect();
        _connectedDevice = null;
        _services = [];
      }
    }

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

    // Écrit les données (8 octets)
    await characteristic.write(data, withoutResponse: true);
    print("✅ Données écrites: $data");
  } catch (e) {
    print("❌ Erreur lors de l'écriture: $e");
  }
}



}

void main() {
    runApp(MyApp());
}
