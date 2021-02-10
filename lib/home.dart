import 'package:flutter/material.dart';
import 'package:note_canvas_v3/constants.dart';
import 'package:note_canvas_v3/database/database_provider.dart';
import 'package:note_canvas_v3/notes_builder.dart';

import 'create_note.dart';
import 'models/note.dart';
import 'my_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = DatabaseProvider.db;
  String defaultViewType = "any";
  
  @override
  Widget build(BuildContext context) {
    print("Building the home stuff");
    Note temp_note = Note(id: 1, title: "Hello", body: "SADSADSA");
    final HomeArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: kMainColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(
            Icons.add,
          ),
          splashRadius: 28,
          iconSize: 30,
          splashColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/create',
              arguments: CreateArgs(note: temp_note, callBack: setState),
            );
          },
        ),
        backgroundColor: kMainColor,
      ),
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Container(
          child: Text(
            args == null
                ? "Notes"
                : args.viewType == "any"
                    ? "Notes"
                    : args.viewType == "bookmarks"
                        ? "Bookmarks"
                        : args.viewType == "archives"
                            ? "Archive"
                            : args.viewType == "deletes"
                                ? "Trash"
                                : "Notes",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        actions: [
          Container(
            // margin: EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                print("Search for notes!");
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.more_vert,
                size: 30,
              ),
              onPressed: () {
                print("See more options!");
              },
            ),
          ),
        ],
      ),
      body: NotesBuilder(
        callBack: setState,
        viewType: args == null ? defaultViewType : args.viewType,
      ),
    );
  }
}

class HomeArgs {
  String viewType;

  HomeArgs({this.viewType});
}
