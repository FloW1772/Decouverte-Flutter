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

/// Page d’accueil (maintenant Stateful)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // index sélectionné
  int _counter = 3; // pour l'incrémentation des projets

  // Liste initiale des projets
  final List<Projet> _projets = [
    Projet("Projet Mannhattan", "un projet vraiment énorme"),
    Projet("Projet important", "un projet très important"),
  ];

  // Liste des pages affichées en fonction de _selectedIndex
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildProjectsPage(), // index 0
      const ContributionPage(), // index 1
    ];
  }

  /// Page qui affiche la liste des projets
  Widget _buildProjectsPage() {
    return ListView.builder(
      itemCount: _projets.length,
      itemBuilder: (context, index) {
        final projet = _projets[index];
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
    );
  }

  /// Fonction appelée quand on clique sur la BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Fonction pour ajouter un projet via le FAB
  void _addProject() {
    setState(() {
      _projets.add(
        Projet("Projet n°$_counter", "Un projet ajouté automatiquement"),
      );
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: _selectedIndex == 0 ? _buildProjectsPage() : _pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: _addProject,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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

/// Nouvelle page Contribution (Stateless)
class ContributionPage extends StatelessWidget {
  const ContributionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Page de contribution",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
