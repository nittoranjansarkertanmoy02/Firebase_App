// ignore_for_file: prefer_const_constructors

import 'package:firebase_app/functions/functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final databaseReference = FirebaseDatabase.instance.ref('Post');

  final postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ADD POSTS",
          style: TextStyle(
            letterSpacing: 1.8,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: "What is in your Mind?",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseReference.child(id).set({
                  'title': postController.text.toString(),
                  'id': id,
                }).then(
                  (value) {
                    Utils().toastMessage('Post Added');
                    setState(() {});
                  },
                ).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {});
                });
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                    child: Text(
                  "ADD",
                  style: TextStyle(
                    letterSpacing: 1.8,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
