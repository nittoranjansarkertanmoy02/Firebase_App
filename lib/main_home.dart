// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_app/firebase_auth/add_posts.dart';
import 'package:firebase_app/firestore/firestore_list.dart';
import 'package:firebase_app/functions/functions.dart';
import 'package:firebase_app/firebase_auth/login_screen.dart';
import 'package:firebase_app/ui/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: searchFilter,
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
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('title').value.toString();
                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDialog(title,
                                      snapshot.child('id').value.toString());
                                },
                                leading: Icon(Icons.add),
                                title: Text('Edit'),
                              ),
                            ),
                            PopupMenuItem(
                              value: 2,
                              child: ListTile(
                                onTap: () {
                                  ref
                                      .child(
                                          snapshot.child('id').value.toString())
                                      .remove();
                                },
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                            )
                          ],
                        ));
                  } else if (title
                      .toLowerCase()
                      .contains(searchFilter.text.toLowerCase())) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPostScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        backgroundColor: Colors.brown,
        child: Column(
          children: [
            DrawerHeader(
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
                      builder: (context) => FireStoreScreen(),
                    ));
              },
              title: Text("FireStore"),
              leading: Icon(Icons.store),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadImage(),
                    ));
              },
              title: Text("Image Store"),
              leading: Icon(Icons.image),
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
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update({
                      'title': editController.text.toLowerCase(),
                    }).then((value) {
                      Utils().toastMessage("Updated");
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text('Update')),
            ],
          );
        });
  }
}
