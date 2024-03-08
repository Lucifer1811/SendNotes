import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:send_notes/create.dart';
import 'package:send_notes/note.dart';
import 'package:send_notes/update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Send Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(); //
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retriveNotes();
    super.initState();
  }

  _retriveNotes() async {
    notes = [];
    var url = Uri.parse('http://10.0.2.2:8000/notes/');
  List response = json.decode((await client.get(url)).body);
    response.forEach((element) {
      notes.add(Note.fromMap(element));
     });
     setState(() {
       
     });
  }

  void _deleteNote(int id) {
    var delUrl= Uri.parse('http://10.0.2.2:8000/notes/$id/delete/');
    client.delete(delUrl);
    _retriveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retriveNotes();
        },
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder:(BuildContext context, int index) {
            return ListTile(
              title: Text(notes[index].note),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UpdatePage(
                  client: client,
                  id: notes[index].id,
                  note: notes[index].note,
                )
              )),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () => _deleteNote(notes[index].id),
              ),
            );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreatePage(
          client: client,
          )
        )),
        tooltip: 'add',
        child: Icon(Icons.add),
      ),
    );
  }
}
