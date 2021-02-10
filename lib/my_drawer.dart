import 'package:flutter/material.dart';
import 'package:note_canvas_v3/home.dart';

import 'drawer_card.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: Container(color: Colors.lightGreen),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.lightGreen,
                  child: IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 80,
            child: Container(color: Colors.lightGreen),
          ),
          DrawerCard(
            icon: Icon(
              Icons.notes,
              color: Colors.white,
              size: 30,
            ),
            text: "Notes",
            actionFunction: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route<dynamic> route) => false);
            },
          ),
          DrawerCard(
            icon: Icon(
              Icons.bookmark,
              color: Colors.white,
              size: 30,
            ),
            text: "Bookmarks",
            actionFunction: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (Route<dynamic> route) => false,
                arguments: HomeArgs(viewType: "bookmarks"),
              );
            },
          ),
          DrawerCard(
            icon: Icon(
              Icons.archive,
              color: Colors.white,
              size: 30,
            ),
            text: "Archive",
            actionFunction: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (Route<dynamic> route) => false,
                arguments: HomeArgs(viewType: "archives"),
              );
            },
          ),
          DrawerCard(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            text: "Trash",
            actionFunction: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (Route<dynamic> route) => false,
                arguments: HomeArgs(viewType: "deletes"),
              );
            },
          ),
          SizedBox(
            height: 50,
            child: Container(color: Colors.lightGreen),
          ),
          DrawerCard(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
            text: "Settings",
          ),
          DrawerCard(
            icon: Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            text: "About",
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: Container(color: Colors.lightGreen),
            ),
          ),
        ],
      ),
    );
  }
}
