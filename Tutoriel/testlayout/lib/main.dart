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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  String title;

  MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Layout'),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
        },
        indicatorColor: Colors.amber,
        selectedIndex: 0,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Messages',
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('element 1'),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('element 2 ffffffffffffffffffffffffffffffffffffffffffffffffff'),
                      ),
                      Text('element 3'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('element 1'),
                      Text('element 2'),
                      Text('element 3'),
                    ],
                  ),
                ),
              ],
            ),
            Image.network(
              'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/logo-design-template-7b59aa2aee8a97a9eefe8b8571955ec2_screen.jpg',
              width: 150.0,
            ),
          ],
        ),
      )
    );

  }


}
