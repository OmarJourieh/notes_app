import 'package:flutter/material.dart';
import 'package:note_canvas_v3/constants.dart';
import 'package:note_canvas_v3/database/database_provider.dart';

import 'models/note.dart';

class EditNote extends StatefulWidget {
  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
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
    DatabaseProvider db = DatabaseProvider.db;

    note = Note();
    final EditArgs args = ModalRoute.of(context).settings.arguments;
    note = args.note;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          _formKey.currentState.save();
          _formKey2.currentState.save();
          // print("========================");
          // print(note.title);
          // print(note.body);
          // print("========================");
          db.updateNote(note);
          args.secondaryCallBack(() {});
          args.callBack(() {});       //rebuilding the parent widget
          Navigator.pop(context);
        },
      ),
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text("Edit Note"),
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
                initialValue: args.note.title,
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
                initialValue: args.note.body,
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

class EditArgs {
  final Note note;
  final Function callBack;
  final Function secondaryCallBack;

  EditArgs({this.note, this.callBack, this.secondaryCallBack});
}
