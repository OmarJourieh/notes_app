// import 'package:flutter/material.dart';
// import 'package:note_canvas_v3/constants.dart';
// import 'package:note_canvas_v3/database/database_provider.dart';

// import 'create_note.dart';
// import 'models/note.dart';
// import 'my_drawer.dart';
// import 'note_card.dart';

// class BookmarksBuilder extends StatelessWidget {
//   final db = DatabaseProvider.db;
//   final Function callBack;

//   BookmarksBuilder({this.callBack});

//   List<Note> notes;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         drawerScrimColor: kMainColor,
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           child: IconButton(
//             icon: Icon(
//               Icons.add,
//             ),
//             splashRadius: 28,
//             iconSize: 30,
//             splashColor: Colors.white,
//             onPressed: () {
//               // Navigator.pushNamed(
//               //   context,
//               //   '/create',
//               //   arguments: CreateArgs(note: temp_note, callBack: setState),
//               // );
//             },
//           ),
//           backgroundColor: kMainColor,
//         ),
//         drawer: MyDrawer(),
//         appBar: AppBar(
//           backgroundColor: kMainColor,
//           title: Container(
//             child: Text("Notes Canvas"),
//           ),
//           actions: [
//             Container(
//               // margin: EdgeInsets.only(right: 20.0),
//               child: IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   print("Search for notes!");
//                 },
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(right: 10.0),
//               child: IconButton(
//                 icon: Icon(Icons.more_vert),
//                 onPressed: () {
//                   print("See more options!");
//                 },
//               ),
//             ),
//           ],
//         ),
//         body: FutureBuilder(
//           future: db.getAllNotes(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData == false) {
//               return CircularProgressIndicator();
//             }
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (context, index) {
//                 Note note = snapshot.data[index];
//                 if (note.isBookmarked == 1)
//                   return NoteCard(
//                     note: note,
//                     callBack: callBack,
//                   );
//                 else return Center();
//               },
//             );
//           },
//         ));
//   }
// }
