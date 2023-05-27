// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:firebase_app/functions/functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref("Post");

  Future getImage() async {
    final pickImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (pickImage != null) {
        _image = File(pickImage.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getImage();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black,
                )),
                child: _image != null
                    ? Image.file(_image!.absolute)
                    : Center(
                        child: Icon(Icons.image),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () async {
                firebase_storage.Reference reference = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/foldername/' +
                        DateTime.now().millisecondsSinceEpoch.toString());
                firebase_storage.UploadTask uploadTask =
                    reference.putFile(_image!.absolute);

                await Future.value(uploadTask);

                var url = await reference.getDownloadURL();
                databaseRef
                    .child('1')
                    .set({'id': '1212', 'title': url.toString()});
                Utils().toastMessage('Uploaded');
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text('Upload'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
