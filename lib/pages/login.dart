import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      Navigator.pushReplacementNamed(context, "/");
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 130, 25, 0),
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
                "Login,here",
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
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email!";
                    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9]+.[a-zA-Z]+").hasMatch(value)) {
                      return "Please enter valid email-id";
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.amber[300],
                      ),
                      border: InputBorder.none,
                      hintText: "Email"),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password!";
                    } else if ((value.length < 6) || (value.length < 1)) {
                      return "Please enter valid password ( Min. of 6 characters)";
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.amber[300],
                      ),
                      border: InputBorder.none,
                      hintText: "Password"),
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {}, child: Text("Forgot Password?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.amber[300])), style: ButtonStyle()),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Column(
                  children: [
                    RaisedButton(
                      onPressed: () => {
                        take_cred(emailController.text, passwordController.text)
                      },
                      elevation: 0,
                      padding: EdgeInsets.all(18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.amber[300],
                      child: Center(child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/signup");
                        },
                        child: Text("Create account?", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[300])),
                        style: ButtonStyle()),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  //let us create function which take password and email and do signin
  Future<void> take_cred(String email, String pass) async {
    if (_formKey.currentState!.validate()) {
      await auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login successful", timeInSecForIosWeb: 2),
                Navigator.pushNamed(context, "/")
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message, timeInSecForIosWeb: 2);
      });
    }
  }
}
