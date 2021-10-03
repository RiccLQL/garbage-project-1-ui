import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  TopBar({Key? key, required this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  final Text title;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title,
      backgroundColor: Colors.brown,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white, 
        fontSize: 24.0),
      elevation: 0.0,
    );
  }
}
