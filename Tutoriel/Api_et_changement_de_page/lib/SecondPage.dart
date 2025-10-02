
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/Todo.dart';
import 'dart:convert';

class SecondPage extends StatefulWidget
{
  int nombre;

  SecondPage({required this.nombre});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  List<Todo> todos = [];

  Future<void> _apiCall() async {
    
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1/todos'));

    if (response.statusCode == 200) {
      setState(() {
        todos = List<Todo>.from(jsonDecode(response.body).map((data) => Todo.fromJson(data)).toList());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiCall();
  }

  @override
  Widget build(BuildContext context) {

    //int arg = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('seconde page'),
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Center(
            child: Text('seconde page ${widget.nombre} !!'),
          ),
          ElevatedButton(onPressed: _apiCall, child: Text('Call API')),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(todos[index].name ?? ''),
                  leading: todos[index].isCompleted ? Icon(Icons.check) : Icon(Icons.access_alarms_sharp),
                );
              }),
          ),
        ],
      )
    );
  }
}