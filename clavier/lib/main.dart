import 'package:flutter/material.dart';

const List<String> list = <String>['Cheval', 'Tristan', 'Enzo', 'le cheval de potter'];

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
        body: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Bienvenue dans les configurations du Clavier !',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250, // hauteur fixe du tableau


            ),
            
            
            SizedBox(
              height: 250, // hauteur fixe du tableau
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: GridView.count(
                  crossAxisCount: 8, // 8 colonnes
                  mainAxisSpacing: 3, // espace vertical
                  crossAxisSpacing: 5, // espace horizontal
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
  const DropdownButtonPot({super.key});

  @override
  State<DropdownButtonPot> createState() => _DropdownButtonPotState();
}

class _DropdownButtonPotState extends State<DropdownButtonPot> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(height: 2, color: Colors.deepPurpleAccent),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
  }
}




void main() {
    runApp(const MyApp());
}
