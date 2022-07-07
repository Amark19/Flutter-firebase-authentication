import 'package:flutter/material.dart';
import 'package:myapp/pages/login.dart';
import 'package:myapp/pages/signup.dart';
import 'package:myapp/pages/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA3bjSvv8eGst2wH48YJABlN9CzyWWFLPc",
      appId: "1:777633406526:android:00b7fd62296cb37a58fb6f",
      messagingSenderId: "XXX",
      projectId: "auth-using-flutter",
    ),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.amberAccent, scaffoldBackgroundColor: Colors.grey[900]),
    initialRoute: '/login',
    routes: {
      '/': (context) => Home(),
      '/login': (context) => Login(),
      '/signup': (context) => Signup()
    },
  ));
}
