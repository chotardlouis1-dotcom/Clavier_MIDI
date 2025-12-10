import 'package:flutter/material.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';

const List<String> list = <String>["Selectiondrebanque"];
//'Roue de modulation', 'Controleur de souffle','Pedale de pied continue','Temps de portamento','Curseur entrée de données','Volume','Balance','Panoramique','Expression','Controle d effet 1','Controle d effet 2 ',' Réglage continu général 1' 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon App Fixe',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Clavier Midi'),
        ),
        body: Center(
          child: Column(
          children: [
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
                        onPressed: () {},
                       ),
                      if (i >= 5 && i <= 8)
                       CustomButton(
                       label: "N°${i + 12}",
                       onPressed: () {},
                      ),
                      if (i >=9  && i <=12)
                       CustomButton(
                       label: "N°${i -4}",
                       onPressed: () {},
                      ),
                      if (i >= 13 && i <= 16)
                       CustomButton(
                       label: "N°${i + 8}",
                       onPressed: () {},
                      ),
                      if (i >= 17 && i <= 20)
                       CustomButton(
                       label: "N°${i - 8}",
                       onPressed: () {},
                      ),
                      if (i >= 21 && i <= 24)
                       CustomButton(
                       label: "N°${i + 4}",
                       onPressed: () {},
                      ),
                      if (i >= 25 && i <= 28)
                       CustomButton(
                       label: "N°${i - 12}",
                       onPressed: () {},
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
  final VoidCallback onPressed; // action quand on clique

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  int _colorIndex = 0; // commence à 0

  final List<Color> _colors = [
    Colors.grey,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // on exécute l'action passée en paramètre
        widget.onPressed();

        // et on modifie l'état interne
        setState(() {
          _colorIndex = (_colorIndex + 1) % _colors.length;
        });
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
      children: [
        // Affiche le numéro au-dessus
        Text(
          "Potentiomètre ${widget.numero} :",
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

/*class GestionBLE {
  
  BluetoothDevice? _connectedDevice;
  List<BluetoothService> _services = [];
}*/



void main() {
    runApp(const MyApp());
}
