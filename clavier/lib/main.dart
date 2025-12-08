import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon App Fixe',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor : Colors.blue,
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text('Clavier Midi'), 
        ),


        body: Column(
          children: [
            Align(
            alignment: Alignment.topCenter,
            child: Text(
                'Bienvenue dans les configurations du Clavier !',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ),

            Expanded(
            child: Center(
            child: Text(
              'cheval',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
           ),
          ),
         ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
