import 'package:flutter/material.dart';
import 'package:mobile/widgets/TopBar.dart';
import 'package:mobile/widgets/Camera.dart';
import 'package:camera/camera.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title, required this.cameras}) : super(key: key);

  final String title;
  final List<CameraDescription> cameras;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Sample Item of Result'),
                          subtitle: Text('Sample Category of Result'),
                        ),
                        TextButton(
                          child: Text('Show disposal locations near me'),
                          onPressed: () async {
                            /* ... */
                          },
                        )
                      ]),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(Icons.arrow_upward),
                        title: Text('SWIPE UP TO TAKE A PHOTO'),
                      )
                    ],
                  ) 
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
