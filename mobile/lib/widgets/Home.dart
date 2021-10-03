import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mobile/widgets/Camera.dart';
import 'package:mobile/widgets/DisposalResource.dart';
import 'package:mobile/widgets/TopBar.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key, required this.title, required this.cameras})
      : super(key: key);

  final String title;
  final List<CameraDescription> cameras;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CameraController cameraController;
  UploadedImage uploadedImage = UploadedImage(taskid: '', status: '');
  ImageResult imageResult = ImageResult(status: '', result: '');
  bool buttonPressed = false;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(
        widget.cameras[0], ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 30),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
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
              child: Camera(cameraController: cameraController),
            ),
            Container(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      width: 140,
                      height: 50,
                      child: TextButton(
                        child: Text("Scan Once",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        onPressed: buttonPressed
                            ? null
                            : () async {
                                setState(() {
                                  imageResult =
                                      ImageResult(status: '', result: '');
                                  uploadedImage =
                                      UploadedImage(status: '', taskid: '');
                                  buttonPressed = true;
                                });
                                final image =
                                    await cameraController.takePicture();
                                final List<int> imageBytes =
                                    await image.readAsBytes();
                                final String base64Image =
                                    base64Encode(imageBytes);
                                final http.Response response = await http.post(
                                    Uri.parse(
                                        'http://10.0.2.2:8000/api/uploadimage'),
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: json.encode({"image": base64Image}));

                                setState(() {
                                  uploadedImage = UploadedImage.fromJson(
                                      jsonDecode(response.body));
                                });
                                if (uploadedImage.status == 'Failure') {
                                  return;
                                }
                                while (imageResult.status == '' ||
                                    imageResult.status == 'Ongoing') {
                                  sleep(Duration(seconds: 3));
                                  final http.Response periodicResponse =
                                      await http.get(Uri.parse(
                                          "http://10.0.2.2:8000/api/getimageresult/${uploadedImage.taskid}"));

                                  setState(() {
                                    imageResult = ImageResult.fromJson(
                                        json.decode(periodicResponse.body));
                                  });
                                }
                                final http.Response periodicResponse =
                                    await http.get(Uri.parse(
                                        "http://10.0.2.2:8000/api/getimageresult/${uploadedImage.taskid}"));

                                setState(() {
                                  imageResult = ImageResult.fromJson(
                                      json.decode(periodicResponse.body));
                                  buttonPressed = false;
                                });
                              },
                        style: ButtonStyle(
                          backgroundColor:
                              buttonPressed ? MaterialStateProperty.all(Colors.grey) : MaterialStateProperty.all(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 30, bottom: 30),
                      width: 140,
                      height: 50,
                      child: TextButton(
                        child: Text("Scan Continuously",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            )),
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(30),
                child: Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (uploadedImage.status == 'Success' &&
                          (imageResult.status == 'Ongoing' ||
                              imageResult.status == ''))
                        ListTile(
                          title: Text('Classifying the garbage',
                              textAlign: TextAlign.center),
                        )
                      else if (uploadedImage.status == 'Success' &&
                          imageResult.status == 'Done')
                        ListTile(
                          title: Text(imageResult.result,
                              textAlign: TextAlign.center),
                          subtitle: Text(
                              'The ${imageResult.result} will now be moved',
                              textAlign: TextAlign.center),
                        )
                      else if (uploadedImage.status == '')
                        ListTile(
                          title: Text('Waiting for garbage',
                              textAlign: TextAlign.center),
                        )
                      else if (uploadedImage.status == 'Failure')
                        ListTile(
                          title: Text('Failed to send image for processing',
                              textAlign: TextAlign.center),
                        ),
                      if (uploadedImage.status == 'Success' &&
                          imageResult.status == 'Done' && imageResult.result == 'batteries') Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Where can I dispose of it?'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DisposalResource(category: imageResult.result)),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadedImage {
  final String taskid;
  final String status;

  UploadedImage({
    required this.taskid,
    required this.status,
  });

  factory UploadedImage.fromJson(Map<String, dynamic> json) {
    return UploadedImage(taskid: json['taskid'], status: json['status']);
  }
}

class ImageResult {
  final String status;
  final String result;

  ImageResult({
    required this.status,
    required this.result,
  });

  factory ImageResult.fromJson(Map<String, dynamic> json) {
    return ImageResult(status: json['status'], result: json['result']);
  }
}
