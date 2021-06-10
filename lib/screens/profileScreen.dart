import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtualfitnesstrainer/widgets/headerCurvedContainer.dart';
import 'package:virtualfitnesstrainer/models/helperFunctions.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  Map<String, dynamic> data;

  File _image;
  final picker = ImagePicker();
  bool isloading = false;

  Future getImage(String name) async {
    PickedFile pickedFile;
    try {
      await showDialog(
          context: context,
          builder: (BuildContext cont) => AlertDialog(
                title: Text("Image"),
                content: Text("Please select one"),
                actions: [
                  FlatButton(
                    child: Text("Take Photo"),
                    onPressed: () async {
                      pickedFile = await picker.getImage(
                          source: ImageSource.camera,
                          imageQuality: 100,
                          maxWidth: 150);
                      Navigator.of(cont).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("gallery"),
                    onPressed: () async {
                      pickedFile = await picker.getImage(
                          source: ImageSource.gallery,
                          imageQuality: 100,
                          maxWidth: 150);
                      Navigator.of(cont).pop();
                    },
                  ),
                ],
              ));

      setState(() {
        isloading = true;
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(_auth.currentUser.uid + '.jpg');

      TaskSnapshot snapshot = await ref.putFile(_image);
      final url = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser.uid)
          .set({'image_url': url, 'name': name});
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  void signOut(BuildContext ctx) {
    // show the dialog
    showDialog(
        context: ctx,
        builder: (BuildContext cont) => AlertDialog(
              title: Text("Delete"),
              content: Text("Are you sure you want to delete?"),
              actions: [
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(cont).pop();
                  },
                ),
                FlatButton(
                  child: Text("Log Out"),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(cont).pop();
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser.uid)
          .get(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Theme.of(context).accentColor,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () async {
                            signOut(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  body: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 450,
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Helper().textfieldForProfileScreen(
                                      hintText: snapshot.data['name'] != null
                                          ? 'Name : ${snapshot.data['name']}'
                                          : 'No Name'
                                      //data['name']
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Helper().textfieldForProfileScreen(
                                      hintText:
                                          'E-mail : ${_auth.currentUser.email}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Helper().textfieldForProfileScreen(
                                      hintText: 'Version : 1.0.0'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomPaint(
                        size: Size(30, 30),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                        painter: HeaderCurvedContainer(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: GestureDetector(
                              onTap: () {
                                print("object");
                              },
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 35,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: snapshot.data['image_url'] != null
                                ? NetworkImage(snapshot.data['image_url'])
                                : null,
                            radius: (MediaQuery.of(context).size.width / 2) / 2,
                            // padding: EdgeInsets.all(10.0),
                            // width: MediaQuery.of(context).size.width / 2,
                            // height: MediaQuery.of(context).size.width / 2,
                            // decoration: BoxDecoration(
                            //   border: Border.all(
                            //     color: Colors.white,
                            //     width: 5,
                            //   ),
                            //   shape: BoxShape.circle,
                            //   color: Colors.white,
                            // ),
                            child: FittedBox(
                              child: snapshot.data['image_url'] == null
                                  ? Icon(
                                      Icons.person,
                                      color: Colors.grey[600],
                                      size: 200,
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 270, left: 184),
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              getImage(snapshot.data['name']);
                            }, //change profile pic icon code
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
