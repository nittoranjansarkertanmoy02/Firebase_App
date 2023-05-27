// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/firebase_auth/add_posts.dart';
import 'package:firebase_app/firestore/firestore_add.dart';
import 'package:firebase_app/functions/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStoreCollection =
      FirebaseFirestore.instance.collection('Users').snapshots();
  final ref = FirebaseDatabase.instance.ref('Post');
  CollectionReference referenec =
      FirebaseFirestore.instance.collection('Users');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: 'Search',
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: fireStoreCollection,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return const Text('Error');
                }
                return Expanded(
                    child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        referenec
                            .doc(snapshot.data!.docs[index]['id'].toString())
                            .update({
                          'title': 'Title',
                        }).then((value) {
                          Utils().toastMessage("Updated");
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                        });
                        referenec
                            .doc(snapshot.data!.docs[index]['id'].toString())
                            .delete();
                      },
                      title:
                          Text(snapshot.data!.docs[index]['title'].toString()),
                      subtitle:
                          Text(snapshot.data!.docs[index]['id'].toString()),
                    );
                  },
                ));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddFireStore(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        backgroundColor: Colors.brown,
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.person,
                size: 100,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FireStoreScreen(),
                    ));
              },
              title: const Text("FireStore"),
              leading: const Icon(Icons.store),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: TextFormField(
              controller: editController,
              decoration: InputDecoration(
                hintText: 'Edit',
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(onPressed: () {}, child: Text('Update')),
            ],
          );
        });
  }
}
