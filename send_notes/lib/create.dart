import 'package:http/http.dart';

import 'package:flutter/material.dart';


class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({
    Key? key,
    required this.client,
    }) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();
  var createUrl = Uri.parse('http://10.0.2.2:8000/notes/create/');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Note"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
            ),
            ElevatedButton(onPressed: () {
              widget.client.post(createUrl, body: {'body':controller.text});
              Navigator.pop(context);
            }, child: Text("Create Note"))
          ],
        ),
      ),
    );
  }
}