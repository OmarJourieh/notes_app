import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:note_canvas_v3/models/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider with ChangeNotifier {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "note_canvas.db");
    // await deleteDatabase(path);
    // print(path);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Note (
          id integer primary key autoincrement,
          title text,
          body text,
          isDeleted integer,
          isArchived integer,
          isBookmarked integer,
          image text,
          category text,
          createdAt text
        )   
      ''');
    });
  }

  addNoteToDatabase(Note note) async {
    final db = await database;
    var raw = await db.insert(
      "Note",
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
    return raw;
  }

  updateNote(Note note) async {
    final db = await database;
    var response = await db
        .update("Note", note.toJson(), where: "id = ?", whereArgs: [note.id]);
    notifyListeners();
    return response;
  }

  Future<Note> getNoteWithId(int id) async {
    final db = await database;
    var response = await db.query("Note", where: "id = ?", whereArgs: [id]);
    notifyListeners();
    return response.isNotEmpty ? Note.fromJson(response.first) : null;
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    var response = await db.query("Note");
    List<Note> list = response.map((c) => Note.fromJson(c)).toList();
    notifyListeners();
    return list;
  }

  deleteNoteWithId(int id) async {
    final db = await database;
    var response =  db.delete("Note", where: "id = ?", whereArgs: [id]);
    notifyListeners();
    return response;
  }

  deleteAllNotes() async {
    final db = await database;
    db.delete("Note");
    notifyListeners();
  }
}
