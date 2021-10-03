import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  Camera({Key? key, required this.cameraController})
      : super(key: key);

  final CameraController cameraController;

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    if (!widget.cameraController.value.isInitialized) {
      return Container();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: AspectRatio(
        aspectRatio: widget.cameraController.value.aspectRatio,
        child: CameraPreview(widget.cameraController),
      ),
    );
  }
}
