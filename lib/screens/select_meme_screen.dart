import 'dart:math';

import 'package:flutter/material.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';

import 'package:share/share.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class SelectMeme extends StatefulWidget {
  final String memePath;
  SelectMeme(this.memePath);

  @override
  State<SelectMeme> createState() => _SelectMemeState();
}

class _SelectMemeState extends State<SelectMeme> {
  String topText = 'top text';
  String bottomText = 'buttom text';
  double xt = 60, yt = 0, xb = 60, yb = 100;
  // double fontSizeT = 40, fontSizeB = 40;
  double _initialScale = 1.0;
  double _scaleFactor = 1.0;
  double _initialRotate = 1.0;
  double _rotation = 1.0;

  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit meme'),
        actions: [
          IconButton(
            onPressed: () {
              exportMeme();
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Stack(
                children: [
                  DragTarget<String>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return GestureDetector(
                        onScaleStart: (details) {
                          _initialScale = _scaleFactor;
                          _initialRotate = _rotation;
                        },
                        onScaleUpdate: (details) {
                          setState(() {
                            _scaleFactor = _initialScale * details.scale;
                            _rotation =
                                _initialRotate + details.rotation * (180 / pi);
                            // print(details.rotation * (180 / pi));
                          });
                        },
                        child: Container(
                          child: Image.asset(widget.memePath),
                        ),
                      );
                    },
                    onAcceptWithDetails: (details) {
                      var newX = details.offset.dx -
                          MediaQuery.of(context).padding.left;
                      var newY = details.offset.dy -
                          AppBar().preferredSize.height -
                          MediaQuery.of(context).padding.top;
                      setState(() {
                        if (details.data == 'top') {
                          xt = newX;
                          yt = newY;
                        } else if (details.data == 'bottom') {
                          xb = newX;
                          yb = newY;
                        }
                      });
                    },
                  ),
                  Positioned(
                    top: yt,
                    left: xt,
                    child: Draggable(
                      data: 'top',
                      feedback: Material(
                        child: strokeText(topText, _scaleFactor, _rotation),
                        color: Color.fromRGBO(0, 0, 0, 0),
                      ),
                      childWhenDragging: Container(),
                      maxSimultaneousDrags: 1,
                      child: strokeText(topText, _scaleFactor, _rotation),
                    ),
                  ),
                  // Positioned(
                  //   top: yt,
                  //   left: xt,
                  //   child: Draggable(
                  //     data: 'top',
                  //     child: strokeText(topText, 40),
                  //     feedback: Material(
                  //       child: strokeText(topText, 40),
                  //       color: Color.fromRGBO(0, 0, 0, 0),
                  //     ),
                  //     childWhenDragging: Container(),
                  //     maxSimultaneousDrags: 1,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: yb,
                  //   left: xb,
                  //   child: Draggable(
                  //     data: 'bottom',
                  //     child: GestureDetector(
                  //       onScaleUpdate: (ScaleUpdateDetails details) {
                  //         setState(() {
                  //           _height = _initHeight +
                  //               (_initHeight * (details.scale * .35));
                  //           print(
                  //               "scale=${details.scale} height=$_height ih=$_initHeight");
                  //         });
                  //       },
                  //       onScaleEnd: (ScaleEndDetails details) {
                  //         setState(() {
                  //           _initHeight = _height;
                  //         });
                  //       },
                  //       child: strokeText(bottomText, _height),
                  //     ),
                  //     feedback: Material(
                  //       child: strokeText(bottomText, _height),
                  //       color: Color.fromRGBO(0, 0, 0, 0),
                  //     ),
                  //     childWhenDragging: Container(),
                  //     maxSimultaneousDrags: 1,
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      label: Text('Top Text'),
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     width: 2,
                      //     color: Colors.amber,
                      //   ),
                      // ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      setState(() {
                        topText = text;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: Text('Top Text'),
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     width: 2,
                      //     color: Colors.amber,
                      //   ),
                      // ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      setState(() {
                        bottomText = text;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget strokeText(String text, double scale, double rotate) {
    double fontSize = 40;
    return RotationTransition(
      turns: AlwaysStoppedAnimation(rotate / 360),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0),
        padding: EdgeInsets.all(30),
        height: scale * 100,
        child: FittedBox(
          child: Stack(
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                // textScaleFactor: scale,
                style: TextStyle(
                  // fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.black,
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                // textScaleFactor: scale,
                style: TextStyle(
                  // fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void exportMeme() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();

      final directory = (await getApplicationDocumentsDirectory()).path;

      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      Uint8List pngByte = byteData.buffer.asUint8List();

      File imageFile = File('$directory/meme.png');
      imageFile.writeAsBytesSync(pngByte);

      Share.shareFiles(['$directory/meme.png']);
    } catch (e) {
      print(e);
    }
  }
}
