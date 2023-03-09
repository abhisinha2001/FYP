import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;

const URL = "https://78b6-89-101-60-203.eu.ngrok.io";

class MyPhotoPage extends StatefulWidget {
  const MyPhotoPage({super.key});

  @override
  State<MyPhotoPage> createState() => _MyPhotoPageState();
}

class _MyPhotoPageState extends State<MyPhotoPage> {
  File _image = File('');
  String? message = "";

  final imagePicker = ImagePicker();

  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  uploadImage() async {
    final request = http.MultipartRequest("POST", Uri.parse(URL + "/upload"));

    final headers = {"Content-type": "multipart/form-data"};

    request.files.add(http.MultipartFile(
        'image', _image.readAsBytes().asStream(), _image.lengthSync(),
        filename: _image.path.split("/").last));

    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    print(message);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            // ignore: unnecessary_null_comparison
            child: _image.path == ''
                ? Text("Add Image To Upload")
                : Column(
                    children: [
                      Image.file(_image),
                      TextButton.icon(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          onPressed: uploadImage,
                          icon: Icon(
                            Icons.upload_file,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Uplaod",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.camera_alt),
        onPressed: getImage,
      ),
    );
  }
}
