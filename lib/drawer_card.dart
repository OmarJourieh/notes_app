import 'package:flutter/material.dart';
import 'package:note_canvas_v3/constants.dart';

class DrawerCard extends StatefulWidget {
  final Icon icon;
  final String text;
  final Function actionFunction;

  DrawerCard({this.icon, this.text, this.actionFunction});

  @override
  _DrawerCardState createState() => _DrawerCardState();
}

class _DrawerCardState extends State<DrawerCard> {
  Color currentTextColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white,
          highlightColor: Colors.grey,
          onTap: widget.actionFunction,
          child: Container(
            child: Row(
              children: [
                widget.icon,
                SizedBox(width: 10),
                Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 20, letterSpacing: 2, color: currentTextColor),
                ),
              ],
            ),
            // color: kMainColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          ),
        ),
      ),
    );
  }
}
