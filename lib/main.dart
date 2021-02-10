import 'package:flutter/material.dart';
import 'package:note_canvas_v3/bookmarks_builder.dart';
import 'package:note_canvas_v3/database/database_provider.dart';
import 'package:note_canvas_v3/edit_note.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'create_note.dart';
import 'home.dart';
import 'note_view.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  DatabaseProvider db = DatabaseProvider.db;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Home(),
        '/note': (context) => NoteView(),
        '/create': (context) => CreateNote(),
        '/edit': (context) => EditNote(),
      },
      initialRoute: '/',
    );
  }
}
