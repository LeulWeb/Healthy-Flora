// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy_flora/utils/Colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  // const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  // Function to classify the Image
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 4,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    }

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  //Take Image from Camera
  takeImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    }

    setState(() {
      _image = File(image.path);
    });

    classifyImage(_image);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png',
              height: 300,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 13),
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                    color: softGreen,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Healthy Flora",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _loading
                          ? Container(
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    "Take a picture of your mango leaf, or insert from your Image Gallery.",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Image.asset(
                                  'assets/images/mango.png',
                                  height: 200,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            takeImage();
                                          },
                                          splashColor: darkGreen,
                                          splashRadius: 20,
                                          icon: Icon(Icons.camera_alt,
                                              size: 40, color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Take Picture",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            pickImage();
                                          },
                                          splashColor: darkGreen,
                                          splashRadius: 20,
                                          icon: Icon(Icons.photo,
                                              size: 40, color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Choose from Gallery",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ]),
                            )
                          : Column(children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        width: 200,
                                        height: 200,
                                        child: Image.file(_image)),
                                    _output != null
                                        ? Text(
                                            "${_output[0]['label']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          )
                                        : Container()
                                  ]),
                              // !
                              SizedBox(
                                height: 30,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          takeImage();
                                        },
                                        splashColor: darkGreen,
                                        splashRadius: 20,
                                        icon: Icon(Icons.camera_alt,
                                            size: 50, color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Take Picture",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          pickImage();
                                        },
                                        splashColor: darkGreen,
                                        splashRadius: 20,
                                        icon: Icon(Icons.photo,
                                            size: 50, color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Choose from Gallery",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ])
                    ]),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(Icons.home),
            //       ),
            //       IconButton(
            //         onPressed: () {
            //           Navigator.pushNamed(context, 'about');
            //         },
            //         icon: Icon(Icons.book),
            //       ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(Icons.language),
            //       ),
            //       IconButton(onPressed: () {}, icon: Icon(Icons.info))
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
