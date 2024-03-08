import 'package:http/http.dart';

import 'package:flutter/material.dart';


class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String note;
  const UpdatePage({
    Key? key,
    required this.client,
    required this.id,
    required this.note,
    }) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();
  Uri updateUrl(int id) {
    var updtUrl = Uri.parse('http://10.0.2.2:8000/notes/$id/update/');
    return updtUrl;
  }


  @override
  void initState() {
    controller.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Note"),
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
              widget.client.put(updateUrl(widget.id), body: {'body':controller.text});
              Navigator.pop(context);
            }, child: Text("Update Note"))
          ],
        ),
      ),
    );
  }
}