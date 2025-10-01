import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// 🔹 You forgot this StatefulWidget
class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _content = 'Je suis un container';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: const Icon(Icons.account_circle_sharp),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Titre',
              style: Theme.of(context).textTheme.titleMedium,
            ),
        
            Container(
              color: Colors.orange,
              height: 200.0,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 20.0, left: 20.0),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _content,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        
            Container(
              color: Colors.cyan,
              width: 300.0,
              height: 200.0,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 20.0, left: 20.0),
              padding: const EdgeInsets.all(10.0),
              child: const Text('Je suis un autre container'),
            ),
        
            const SizedBox(height: 20.0),
        
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _content = _content + ' ' + _content;
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                surfaceTintColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text('Bouton'),
            ),
          ],
        ),
      ),
    );
  }
}
