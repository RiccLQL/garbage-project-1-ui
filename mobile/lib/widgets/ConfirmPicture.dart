import 'dart:io';

import 'package:flutter/material.dart';

class ConfirmPicture extends StatelessWidget {
  final File image;
  const ConfirmPicture({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: Container(child: Image.file(image, fit: BoxFit.cover),
      ),
    );
  }
}