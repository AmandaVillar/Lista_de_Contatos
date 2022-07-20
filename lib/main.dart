// ignore_for_file: unnecessary_new

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teste/person-info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Person> _personList = [];

  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _photo = TextEditingController();
  final _search = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.red),
      ),
      home: MyHomePage(),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

//============================================        MY HOME PAGE       ==================================

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Person> personList = [];

  final _name = TextEditingController();

  final _mobile = TextEditingController();

  final _image = TextEditingController();

  final _search = TextEditingController();

  final _formKey = new GlobalKey<FormState>();
// to not reset with build

  int listSize = 0;

//       ==========================================    EACH TITLE  ======================================

  @override
  Widget build(BuildContext context) {
    List<Widget> listItems = [];

    print(personList.length);
    personList.forEach((person) {
      listItems.add(ListTile(
          leading: CircleAvatar(
            radius: 20,
            // ignore: sort_child_properties_last
            child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Image(
                  image: NetworkImage(person.image),
                )),
            backgroundColor: Colors.lightBlueAccent,
          ),
          title: Text(person.name),
          subtitle: Text(person.mobile),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  _editContact(context, person);
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  // int person = int.parse(stdin.readLineSync());
                  setState(() {
                    personList
                        .removeWhere((element) => element.id == person.id);
                  });
                  //Navigator.of(context).pop();
                },
                icon: Icon(Icons.delete),
              )
            ],
          )));
    });

//     ======================================              LAYOUT                    ============================

    return Scaffold(
      appBar: AppBar(
        //appBar = parte de cima do app
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        elevation: 0, // elevacao 0. nao fica com sombra em baixo5
        centerTitle: true,
        title: const Text(
          'Lista de Contatos',
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addContact(context);
            },
          ),
          IconButton(
              onPressed: () {
                _searchContact(context);
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Scrollbar(
        // ignore: sort_child_properties_last
        child: ListView(
          restorationId: 'Lista de Contatos',
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: listItems,
        ),
      ),
    );
  }

//            ============================             FUNCTIONS ADD, EDIT, DELETE      ===============================

  void _addContact(BuildContext context) {
    _mobile.text = '';
    _name.text = '';
    _image.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("New Contact"),
          content: new Container(
            child: new Form(
              key: _formKey,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  nameField(),
                  const Divider(
                    color: Colors.transparent,
                    height: 20.0,
                  ),
                  mobileField(),
                  const Divider(
                    color: Colors.transparent,
                    height: 20.0,
                  ),
                  photoField()
                ],
              ),
            ),
          ),
          actions: <Widget>[
            //  ====== AQUI ======
            new FlatButton(
              child: new Text("Save"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var rng = new Random();

                  setState(() {
                    personList.add(Person(_name.text, _mobile.text, _image.text,
                        rng.nextInt(100)));
                  });
                  print(personList);

                  // remove o AlertDialog da tela;
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _editContact(BuildContext context, Person person) {
    _mobile.text = person.mobile;
    _name.text = person.name;
    _image.text = person.image;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Edit Contact"),
          content: new Container(
            child: new Form(
              key: _formKey,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  nameField(),
                  const Divider(
                    color: Colors.transparent,
                    height: 20.0,
                  ),
                  mobileField(),
                  const Divider(
                    color: Colors.transparent,
                    height: 20.0,
                  ),
                  photoField()
                ],
              ),
            ),
          ),
          actions: <Widget>[
            //  ====== AQUI ======
            new FlatButton(
              child: new Text("Save"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var rng = new Random();

                  setState(() {
                    personList.add(Person(
                        _name.text, _mobile.text, _image.text, person.id));
                  });
                  // remove o AlertDialog da tela;
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _searchContact(BuildContext context) {
    _search.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Search Contact"),
          content: new Container(
            child: new Form(
              key: _formKey,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  searchField(),
                  const Divider(
                    color: Colors.transparent,
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            //  ====== AQUI ======
            new FlatButton(
              child: new Text("Search"),
              onPressed: () {
                var search = _search.text;

                setState(() {
                  personList.where((element) => element.name == search);
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//    ===============================                  ALERT DIALOG FIELDS                ============================

  Widget nameField() {
    return new TextFormField(
      controller: _name,
      keyboardType: TextInputType.text,
      validator: (valor) {
        if (valor!.isEmpty && valor.length == 0) {
          return "Campo Obrigatório"; // retorna a mensagem
          //caso o campo esteja vazio
        }
      },
      // ignore: prefer_const_constructors
      decoration: new InputDecoration(
        hintText: 'Name',
        labelText: 'Complete Name',
        // ignore: prefer_const_constructors
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget mobileField() {
    return new TextFormField(
      controller: _mobile,
      validator: (valor) {
        if (valor!.isEmpty && valor.length == 0) {
          return "Required Field"; // retorna a mensagem
          // caso o campo esteja vazio
        }
      },
      // ignore: prefer_const_constructors
      decoration: new InputDecoration(
        hintText: 'Mobile',
        labelText: 'Mobile',
        // ignore: prefer_const_constructors
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget photoField() {
    return new TextFormField(
        controller: _image,
        validator: (valor) {
          if (valor!.isEmpty && valor.length == 0) {
            return 'Required Field';
          }
        },
        // ignore: prefer_const_constructors
        decoration: new InputDecoration(
          hintText: 'Upload Photo url',
          labelText: 'Photo URL',
          // ignore: prefer_const_constructors
          border: OutlineInputBorder(),
        ));
  }

  Widget searchField() {
    return new TextFormField(
      controller: _search,
      keyboardType: TextInputType.text,
      validator: (valor) {
        if (valor!.isEmpty && valor.length == 0) {
          return "Please Enter Contact"; // retorna a mensagem
          //caso o campo esteja vazio
        }
      },
      // ignore: prefer_const_constructors
      decoration: new InputDecoration(
        hintText: 'Contact Name',
        labelText: 'Search Contact',
        // ignore: prefer_const_constructors
        border: OutlineInputBorder(),
      ),
    );
  }
}
