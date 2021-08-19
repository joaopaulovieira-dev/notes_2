import 'package:flutter/material.dart';

class CreateNotePages extends StatefulWidget {
  const CreateNotePages({Key? key}) : super(key: key);

  @override
  _CreateNotePagesState createState() => _CreateNotePagesState();
}

class _CreateNotePagesState extends State<CreateNotePages> {
  var description = '';
  var textcontroller = TextEditingController();
  var isEdit = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        if (ModalRoute.of(context)!.settings.arguments != null) {
          description = ModalRoute.of(context)!.settings.arguments as String;
          textcontroller.text = description;
          isEdit = true;
          setState(() {});
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Note' : 'Create Note'),
        centerTitle: true,
        actions: [
          if (isEdit)
            IconButton(
              onPressed: () {
                Navigator.pop(context, '');
              },
              icon: Icon(Icons.delete),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textcontroller,
              maxLines: null,
              maxLength: 400,
              onChanged: (value) {
                description = value;
                setState(() {});
              },
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(
              height: 12,
            ),
            if (description.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, description);
                      },
                      child: Text(isEdit ? 'Editar' : 'Salvar'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
