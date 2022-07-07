import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CalConT"), centerTitle: true, backgroundColor: Colors.grey[850], elevation: 0, automaticallyImplyLeading: false),
      body: Center(
          child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Welcome',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                )),
            Text(' ${auth.currentUser!.email!.substring(0, auth.currentUser!.email!.length - 10)} !',
                style: TextStyle(
                  color: Colors.amber[300],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                )),
          ]),
          SizedBox(height: 10),
          FlatButton.icon(
              onPressed: () {
                auth.signOut();
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: Icon(Icons.logout),
              label: Text("LogOut"))
        ]),
      )),
    );
  }
}
