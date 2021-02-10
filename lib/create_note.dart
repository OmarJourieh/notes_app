import 'package:flutter/material.dart';
import 'package:note_canvas_v3/constants.dart';
import 'package:note_canvas_v3/database/database_provider.dart';

import 'models/note.dart';

class CreateNote extends StatefulWidget {
  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  Note note;
  // TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController(text: note.title);
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
    note = Note();
    DatabaseProvider db = DatabaseProvider.db;

    final CreateArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          _formKey.currentState.save();
          _formKey2.currentState.save();
          note.isBookmarked = 0;
          note.isArchived = 0;
          note.isDeleted = 0;
          if (note.body.length > 0) {
            db.addNoteToDatabase(note);
            args.callBack(() {}); //rebuilding the parent widget
            Navigator.pop(context);
          }

          // db.deleteAllNotes();
          // List<Note> notes = await db.getAllNotes();
          // print("------------------------");
          // print(notes.length);
        },
      ),
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text("New Note"),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: kSecondaryColor,
            ),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: "Title",
                  border: InputBorder.none,
                ),
                onSaved: (String value) {
                  note.title = value;
                  print("Note title: " + value);
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: kSecondaryColor,
              ),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Form(
                key: _formKey2,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    labelText: "Note",
                    fillColor: kMainColor,
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onSaved: (String value) {
                    note.body = value;
                    print("Note body: " + value);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateArgs {
  final Note note;
  final Function callBack;

  CreateArgs({this.note, this.callBack});
}
