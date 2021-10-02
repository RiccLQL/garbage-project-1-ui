import 'package:flutter/material.dart';
import 'package:mobile/widgets/Home.dart';
import 'package:mobile/widgets/Camera.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(Garbage(cameras: cameras));
}

class Garbage extends StatelessWidget {
  final List<CameraDescription> cameras;
  const Garbage({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return MaterialApp(
      title: 'Garbage',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: PageView(
        scrollDirection: Axis.vertical,
        controller: controller,
        children: <Widget>[
          Center(
            child: Home(title: 'Got any trash?', cameras: cameras),
          ),
          Center(
            child: Camera(cameras: cameras),
          ),
        ],
      ),
    );
  }
}
