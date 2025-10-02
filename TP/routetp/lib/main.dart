import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart'; // ✅ Router séparé

/// Enum pour les statuts du projet
enum ProjetStatus { enCours, termine, aVenir }

/// Classe Projet
class Projet {
  String _title;
  String _desc;
  ProjetStatus _status;
  DateTime? _date;

  Projet(this._title, this._desc,
      {ProjetStatus status = ProjetStatus.aVenir, DateTime? date})
      : _status = status,
        _date = date;

  String get title => _title;
  String get desc => _desc;
  ProjetStatus get status => _status;
  DateTime? get date => _date;

  set title(String t) => _title = t;
  set desc(String d) => _desc = d;
  set status(ProjetStatus s) => _status = s;
  set date(DateTime? d) => _date = d;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mes Projets',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xffeceaea),
      ),
      routerConfig: appRouter, // ✅ utilisation du router séparé
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Page d’accueil
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Projet> _projets = [
    Projet("Projet Mannhattan", "un projet vraiment énorme",
        status: ProjetStatus.enCours, date: DateTime(2024, 1, 1)),
    Projet("Projet important", "un projet très important",
        status: ProjetStatus.termine, date: DateTime(2023, 12, 15)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addProjectFromForm(Projet projet) {
    setState(() {
      _projets.add(projet);
      _selectedIndex = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Le projet ${projet.title} a été créé")),
    );
  }

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
              "${projet.desc}\n"
                  "Statut : ${projet.status.name} "
                  "${projet.date != null ? "| Début : ${projet.date!.toLocal().toString().split(' ')[0]}" : ""}",
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                setState(() {
                  _projets.removeAt(index);
                });
              },
            ),
            onTap: () {
              // 👉 Navigation vers la page détails
              context.push('/details', extra: projet);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildProjectsPage(),
      ContributionPage(onProjectCreated: _addProjectFromForm),
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
      body: pages[_selectedIndex],
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

/// Page de détails projet
class ProjectDetailsPage extends StatelessWidget {
  final Projet projet;

  const ProjectDetailsPage({super.key, required this.projet});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(projet.title),
          backgroundColor: Colors.indigo,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Allez dans l’onglet Éditer pour modifier")),
                );
              },
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Détails"),
              Tab(text: "Éditer"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Détails
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Titre : ${projet.title}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text("Description : ${projet.desc}"),
                  const SizedBox(height: 8),
                  Text("Statut : ${projet.status.name}"),
                  const SizedBox(height: 8),
                  Text(projet.date != null
                      ? "Date début : ${projet.date!.toLocal().toString().split(' ')[0]}"
                      : "Pas de date définie"),
                ],
              ),
            ),
            // Formulaire de modification
            ContributionFormEdit(projet: projet),
          ],
        ),
      ),
    );
  }
}

/// Formulaire réutilisé pour éditer un projet
class ContributionFormEdit extends StatefulWidget {
  final Projet projet;
  const ContributionFormEdit({super.key, required this.projet});

  @override
  State<ContributionFormEdit> createState() => _ContributionFormEditState();
}

class _ContributionFormEditState extends State<ContributionFormEdit> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _desc;
  late ProjetStatus _status;
  DateTime? _date;

  @override
  void initState() {
    super.initState();
    _title = widget.projet.title;
    _desc = widget.projet.desc;
    _status = widget.projet.status;
    _date = widget.projet.date;
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        widget.projet.title = _title;
        widget.projet.desc = _desc;
        widget.projet.status = _status;
        widget.projet.date = _date;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Le projet ${widget.projet.title} a été modifié")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: "Titre"),
              validator: (value) =>
              value == null || value.isEmpty ? "Titre requis" : null,
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              initialValue: _desc,
              decoration: const InputDecoration(labelText: "Description"),
              validator: (value) =>
              value == null || value.isEmpty ? "Description requise" : null,
              onSaved: (value) => _desc = value!,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ProjetStatus>(
              value: _status,
              items: ProjetStatus.values
                  .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status.name),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Statut"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _date == null
                        ? "Aucune date choisie"
                        : "Date : ${_date!.toLocal().toString().split(' ')[0]}",
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text("Choisir une date"),
                )
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.save),
              label: const Text("Enregistrer les modifications"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Page Contribution (ajout)
class ContributionPage extends StatefulWidget {
  final Function(Projet) onProjectCreated;

  const ContributionPage({super.key, required this.onProjectCreated});

  @override
  State<ContributionPage> createState() => _ContributionPageState();
}

class _ContributionPageState extends State<ContributionPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _desc = "";
  ProjetStatus _status = ProjetStatus.aVenir;
  DateTime? _date;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final projet = Projet(_title, _desc, status: _status, date: _date);
      widget.onProjectCreated(projet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Titre"),
              validator: (value) =>
              value == null || value.isEmpty ? "Titre requis" : null,
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              validator: (value) =>
              value == null || value.isEmpty ? "Description requise" : null,
              onSaved: (value) => _desc = value!,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ProjetStatus>(
              value: _status,
              items: ProjetStatus.values
                  .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status.name),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              decoration: const InputDecoration(labelText: "Statut"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _date == null
                        ? "Aucune date choisie"
                        : "Date : ${_date!.toLocal().toString().split(' ')[0]}",
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text("Choisir une date"),
                )
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.check),
              label: const Text("Créer le projet"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
