import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Application principale
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mes Projets',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xffeceaea),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Classe Projet avec attributs privés et getters
class Projet {
  final String _title;
  final String _desc;

  Projet(this._title, this._desc);

  String get title => _title;
  String get desc => _desc;
}

/// Page d’accueil
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Quelques projets en dur (⚡ déplacés dans build)
    final List<Projet> projets = [
      Projet("Projet Mannhattan", "un projet vraiment énorme"),
      Projet("Projet important", "un projet très important"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.rocket_launch, color: Colors.white),
            SizedBox(width: 8),
            Text("Mes Projets"),
          ],
        ),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: projets.length,
        itemBuilder: (context, index) {
          final projet = projets[index];
          return Card(
            color: Colors.black87,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.work, color: Colors.indigo),
              title: Text(
                projet.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                projet.desc,
                style: const TextStyle(color: Colors.white70),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Projets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Contribuer",
          ),
        ],
        selectedItemColor: Colors.indigo,
      ),
    );
  }
}
