import 'package:flutter/material.dart';
import 'package:mobile/widgets/TopBar.dart';

class DisposalResource extends StatefulWidget {
  final String category;

  DisposalResource({Key? key, required this.category}) : super(key: key);

  _DisposalResourceState createState() = _DisposalResourceState();
}

class _DisposalResourceState extends State<DisposalResource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: Text('${widget.category} Disposal Resources')),
      
    );
  }
}