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
        primaryColor: Colors.deepOrange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        scaffoldBackgroundColor: Colors.lightGreen,
        textTheme: TextTheme(
          titleMedium: TextStyle(fontSize: 32, color: Color(0xffeceaea)),
          bodySmall: TextStyle(fontSize: 18, color: Color(0xffeceaea)),
        ),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.tealAccent,
          elevation: 2,
          shadowColor: Colors.black,
        ),
        iconTheme: IconThemeData(

        )
      ),
      debugShowCheckedModeBanner: false,
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
        title: Text("$title"),
        leading: Icon(Icons.account_circle_sharp),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Titre', style: Theme.of(context).textTheme.titleMedium),
          Container(
            color: Colors.orange,
            height: 200.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 20.0, left: 20.0),
            padding: EdgeInsets.all(10.0),
            child: Text('Je suis un container', style: Theme.of(context).textTheme.bodySmall),
          ),
          Container(
            color: Colors.cyan,
            width: 300.0,
            height: 200.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 20.0, left: 20.0),
            padding: EdgeInsets.all(10.0),
            child: Text('Je suis un autre container'),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text('Bouton'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              surfaceTintColor: Theme.of(context).colorScheme.primary
            )
          )
        ],
      ),
    );


  }



}
