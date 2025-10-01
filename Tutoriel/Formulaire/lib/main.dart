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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Demo Form'),
        ),
        body: MyFormPage(),
      ),
    );
  }
}

class MyFormPage extends StatefulWidget
{
  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {

  final _key = GlobalKey<FormState>();
  bool _switchValue = false;
  String? _dropDownValue;
  String? _dropDownMenuValue;
  String? _email;

  _onSwichChanged(value) {
    setState(() {
      _switchValue = value;
    });
  }

  void _onSubmit() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      print('Validation OK : ${_email}');
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Veuillez saisir votre email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return  "Remplis moi ce champ !!!";
                  }
                  if (!RegExp(r"(^((?!\.)[\w-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$)").hasMatch(value)) {
                    return "Veuillez saisir un email valide";
                  }

                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Veuillez saisir votre MdP',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              SwitchListTile(
                  title: Text('Clim'),
                  value: _switchValue,
                  onChanged: _onSwichChanged,
                  secondary: Icon(Icons.ac_unit_sharp),
              ),
              SizedBox(
                height: 10.0,
              ),
              DropdownButton(
                  value: _dropDownValue,
                  items: const [
                    DropdownMenuItem(value: "apple", child: Text('Pomme')),
                    DropdownMenuItem(value: "grape", child: Text('Raisin')),
                    DropdownMenuItem(value: "lemon", child: Text('Citron')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _dropDownValue = value;
                    });
                  }
              ),
              SizedBox(
                height: 10.0,
              ),
              DropdownMenu(
                  initialSelection: _dropDownMenuValue,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: "apple", label: 'Pomme'),
                    DropdownMenuEntry(value: "grape", label: 'Raisin'),
                    DropdownMenuEntry(value: "lemon", label: 'Citron'),
                  ],
                  onSelected: (value) {
                    setState(() {
                      _dropDownMenuValue = value;
                    });
                  }
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text('Soumettre'),
              ),
            ],
          ),
        ),
    );
  }
}


