import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    print(_auth.currentUser.photoURL);
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_auth.currentUser.displayName),
          Text(_auth.currentUser.email),
          CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(_auth.currentUser.photoURL),
          ),
          TextButton(
            child: Text('Log out'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      )),
    );
  }
}
