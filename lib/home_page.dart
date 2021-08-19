import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notes = <String>['Item 0'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < notes.length; i++)
              Card(
                child: ListTile(
                  title: Text(notes[i]),
                  onTap: () async {
                    var response = await Navigator.pushNamed(
                        context, '/create-note',
                        arguments: notes[i]);
                    if (response != null) {
                      var description = response as String;
                      if (response.isEmpty) {
                        notes.removeAt(i);
                      } else {
                        notes[i] = description;
                      }

                      setState(() {});
                    }
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: OutlinedButton(
        child: Text('Adicionar Nota'),
        onPressed: () async {
          var description = await Navigator.pushNamed(context, '/create-note');
          if (description != null) {
            notes.add(description as String);
            setState(() {});
          }
        },
      ),
    );
  }
}
