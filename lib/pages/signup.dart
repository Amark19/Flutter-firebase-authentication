import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 100, 25, 0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Text(
                "Welcome to CalConT!",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              Text(
                "Register,here",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 13,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.amber[300],
                        ),
                        border: InputBorder.none,
                        hintText: "Email"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      emailController.text = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "required field!";
                      } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9]+.[a-zA-Z]+").hasMatch(value)) {
                        return "Please enter valid email-id";
                      }
                    }),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.amber[300],
                        ),
                        border: InputBorder.none,
                        hintText: "Password"),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "required field!";
                      } else if (value.length < 6) {
                        return "Please enter valid password ( Min. of 6 characters)";
                      }
                    }),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextFormField(
                    controller: confirmpassController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.amber[300],
                        ),
                        border: InputBorder.none,
                        hintText: "Confirm password"),
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "required field!";
                      } else if (passwordController.text != value) {
                        return "Do not match with password";
                      }
                    }),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () => {
                        createUser(emailController.text, passwordController.text)
                      },
                      elevation: 0,
                      padding: EdgeInsets.all(18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.amber[300],
                      child: Center(child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[300]),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/login");
                          },
                          child: Text("Login here", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.amber[300])),
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void createUser(String email, String pass) async {
    if (_formKey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((uid) => {
                Fluttertoast.showToast(msg: "SignIn successful!Please login", timeInSecForIosWeb: 2),
                Navigator.pushNamed(context, '/')
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message, timeInSecForIosWeb: 2);
      });
    }
  }
}
