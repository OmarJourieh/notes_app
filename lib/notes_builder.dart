import 'package:flutter/material.dart';
import 'package:note_canvas_v3/constants.dart';
import 'package:note_canvas_v3/database/database_provider.dart';
import 'package:note_canvas_v3/home.dart';

import 'models/note.dart';
import 'note_card.dart';

class NotesBuilder extends StatelessWidget {
  final db = DatabaseProvider.db;
  Function callBack;
  String viewType;

  NotesBuilder({this.callBack, this.viewType});

  List<Note> notes;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.getAllNotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            Note note = snapshot.data[index];
            print(viewType);
            if (viewType != "any") {
              switch (viewType) {
                case "bookmarks":
                  if (note.isBookmarked == 1 && note.isDeleted == 0)
                    return NoteCard(
                      note: note,
                      callBack: callBack,
                      viewType: viewType,
                    );
                  break;
                case "archives":
                  if (note.isArchived == 1 && note.isDeleted == 0)
                    return NoteCard(
                      note: note,
                      callBack: callBack,
                      viewType: viewType,
                    );
                  break;
                case "deletes":
                  if (note.isDeleted == 1)
                    return NoteCard(
                      note: note,
                      callBack: callBack,
                      viewType: viewType,
                    );
                  break;
              }
            } else {
              if (note.isDeleted == 0 && note.isArchived == 0)
                return NoteCard(
                  note: note,
                  callBack: callBack,
                      viewType: viewType,
                );
            }
            return Center();
          },
        );
      },
    );
  }
}
