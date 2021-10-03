import 'package:flutter/material.dart';
import 'package:mobile/widgets/TopBar.dart';

class DisposalResource extends StatefulWidget {
  final String category;

  DisposalResource({Key? key, required this.category}) : super(key: key);

  _DisposalResourceState createState() => _DisposalResourceState();
}

class _DisposalResourceState extends State<DisposalResource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: Text('${widget.category} Disposal Resources')),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Bureau En Gros Greenfield Park', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            Text('3344 Boul. Taschereau, Greenfield Park, QC J4V 2H7'),
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      color: Colors.black38,
                      offset: Offset.fromDirection(1.58, 3.0),
                      spreadRadius: 1.0)
                ],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset('assets/images/bureau-en-gros.jpg'),
              ),
            ),
            Container(margin: EdgeInsets.only(top: 30), child: Text('Open on weekdays 9-6')),
            Container(margin: EdgeInsets.only(top: 10), child: Text('0.6km away', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),)),
          ],
        ),
      ),
    );
  }
}