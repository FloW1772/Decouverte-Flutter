import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage('Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  String title;

  MyHomePage(this.title);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Barre supérieur"),
        leading: Icon(Icons.account_circle_sharp),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.orange,
            height: 200.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 20.0, left: 20.0),
            padding: EdgeInsets.all(10.0),
            child: Text('je suis un container'),

          ),
          Container(
            color: Colors.cyan,
            width: 300.0,
            height: 200.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 20.0, left: 20.0),
            padding: EdgeInsets.all(10.0),
            child: Text('je suis un autre container'),

          ),
        ],

      ),
    );
  }
  
}