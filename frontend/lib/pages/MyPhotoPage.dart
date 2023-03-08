import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPhotoPage extends StatefulWidget {
  const MyPhotoPage({super.key});

  @override
  State<MyPhotoPage> createState() => _MyPhotoPageState();
}

class _MyPhotoPageState extends State<MyPhotoPage> {
  File _image = File('');

  final imagePicker = ImagePicker();

  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ignore: unnecessary_null_comparison
        child: _image.path == ''
            ? Text("Add Image To Proceed")
            : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.camera_alt),
        onPressed: getImage,
      ),
    );
  }
}
