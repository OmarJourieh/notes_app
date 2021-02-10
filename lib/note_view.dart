import 'package:flutter/material.dart';
import 'package:note_canvas_v3/constants.dart';
import 'package:note_canvas_v3/database/database_provider.dart';
import 'package:note_canvas_v3/edit_note.dart';

import 'models/note.dart';

class NoteView extends StatefulWidget {
  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final db = DatabaseProvider.db;
  Note note;

  @override
  Widget build(BuildContext context) {
    print("building note view");
    final CardArgs args = ModalRoute.of(context).settings.arguments;
    print(args.note.isArchived);
    // note = db.getNoteWithId(args.note.id);
    return FutureBuilder(
      future: db.getNoteWithId(args.note.id),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return CircularProgressIndicator();
        }
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: args.viewType == "deletes"
              ? null
              : FloatingActionButton(
                  child: Icon(Icons.edit),
                  backgroundColor: kMainBlue,
                  splashColor: kInverseColor,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/edit',
                      arguments: EditArgs(
                          note: args.note,
                          callBack: args.callBack,
                          secondaryCallBack: setState),
                    );
                  },
                ),
          appBar: AppBar(
            backgroundColor: kMainColor,
            actions: args.viewType == "deletes"
                ? [
                    IconButton(
                      icon: Icon(
                        Icons.restore,
                        color: Colors.orange,
                        size: 35,
                      ),
                      onPressed: () {
                        Note newNote = Note(
                          body: snapshot.data.body,
                          category: snapshot.data.category,
                          createdAt: snapshot.data.createdAt,
                          id: snapshot.data.id,
                          image: snapshot.data.image,
                          isArchived: snapshot.data.isArchived,
                          isBookmarked: snapshot.data.isBookmarked,
                          isDeleted: snapshot.data.isDeleted == 0 ? 1 : 0,
                          title: snapshot.data.title,
                        );
                        db.updateNote(newNote);
                        args.callBack(() {});
                        setState(() {});
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[400],
                        size: 35,
                      ),
                      onPressed: () {
                        db.deleteNoteWithId(snapshot.data.id);
                        args.callBack(() {});
                        setState(() {});
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                    SizedBox(width: 20),
                  ]
                : [
                    IconButton(
                      icon: Icon(
                        Icons.archive,
                        size: 35,
                      ),
                      color: snapshot.data.isArchived == 1
                          ? kMainBlue
                          : kInverseColor,
                      onPressed: () {
                        Note newNote = Note(
                          body: snapshot.data.body,
                          category: snapshot.data.category,
                          createdAt: snapshot.data.createdAt,
                          id: snapshot.data.id,
                          image: snapshot.data.image,
                          isArchived: snapshot.data.isArchived == 0 ? 1 : 0,
                          isBookmarked: snapshot.data.isBookmarked,
                          isDeleted: snapshot.data.isDeleted,
                          title: snapshot.data.title,
                        );
                        db.updateNote(newNote);
                        args.callBack(() {});
                        setState(() {});
                        print(snapshot.data.isArchived);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.bookmark,
                        size: 35,
                      ),
                      color: snapshot.data.isBookmarked == 1
                          ? Colors.yellow
                          : kInverseColor,
                      onPressed: () {
                        Note newNote = Note(
                          body: snapshot.data.body,
                          category: snapshot.data.category,
                          createdAt: snapshot.data.createdAt,
                          id: snapshot.data.id,
                          image: snapshot.data.image,
                          isArchived: snapshot.data.isArchived,
                          isBookmarked: snapshot.data.isBookmarked == 0 ? 1 : 0,
                          isDeleted: snapshot.data.isDeleted,
                          title: snapshot.data.title,
                        );
                        db.updateNote(newNote);
                        args.callBack(() {});
                        setState(() {});
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[400],
                        size: 35,
                      ),
                      onPressed: () {
                        Note newNote = Note(
                          body: snapshot.data.body,
                          category: snapshot.data.category,
                          createdAt: snapshot.data.createdAt,
                          id: snapshot.data.id,
                          image: snapshot.data.image,
                          isArchived: snapshot.data.isArchived,
                          isBookmarked: snapshot.data.isBookmarked,
                          isDeleted: snapshot.data.isDeleted == 0 ? 1 : 0,
                          title: snapshot.data.title,
                        );
                        db.updateNote(newNote);
                        args.callBack(() {});
                        setState(() {});
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                    SizedBox(width: 10),
                  ],
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kMainColor[200],
                ),
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  snapshot.data.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kMainColor[200],
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text(
                    (snapshot.data.body),
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CardArgs {
  final Note note;
  final Function callBack;
  final String viewType;

  CardArgs({this.note, this.callBack, this.viewType});
}
