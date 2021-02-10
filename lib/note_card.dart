import 'package:flutter/material.dart';
import 'package:note_canvas_v3/database/database_provider.dart';

import 'models/note.dart';
import 'note_view.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  Function callBack;
  String viewType;

  NoteCard({this.note, this.callBack, this.viewType});
  final db = DatabaseProvider.db;

  @override
  Widget build(BuildContext context) {
    // final notesProvider = Provider.of<NotesProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.lightGreen[200],
      ),
      child: ListTile(
        title: Text(
          note.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        subtitle: Text(
          (note.body),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
        trailing: viewType == "deletes"
            ? IconButton(
                icon: Icon(Icons.restore),
                color: Colors.orange,
                iconSize: 35,
                onPressed: () {
                  Note newNote = Note(
                    body: note.body,
                    category: note.category,
                    createdAt: note.createdAt,
                    id: note.id,
                    image: note.image,
                    isArchived: note.isArchived,
                    isBookmarked: note.isBookmarked,
                    isDeleted: note.isDeleted == 0 ? 1 : 0,
                    title: note.title,
                  );
                  db.updateNote(newNote);
                  callBack(() {});
                  print("restored note at: " + note.id.toString());
                },
              )
            : IconButton(
                icon: Icon(Icons.bookmark),
                color: note.isBookmarked == 1 ? Colors.yellow : Colors.white,
                iconSize: 35,
                onPressed: () {
                  Note newNote = Note(
                    body: note.body,
                    category: note.category,
                    createdAt: note.createdAt,
                    id: note.id,
                    image: note.image,
                    isArchived: note.isArchived,
                    isBookmarked: note.isBookmarked == 0 ? 1 : 0,
                    isDeleted: note.isDeleted,
                    title: note.title,
                  );
                  db.updateNote(newNote);
                  callBack(() {});
                  print("bookmarked note at: " + note.id.toString());
                },
              ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/note',
            arguments:
                CardArgs(note: note, callBack: callBack, viewType: viewType),
          );
        },
      ),
    );
  }
}
