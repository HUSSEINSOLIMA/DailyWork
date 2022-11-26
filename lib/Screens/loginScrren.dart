// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_basic1/Screens/welocmeScreen.dart';
import 'package:flutter_application_basic1/reuableComponent.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 300.0,
                width: 300.0,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/hussein.jpg',
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              defultTextForm(
                typeofKeyword: TextInputType.emailAddress,
                title: 'Enter Your Email',
                IconinText: Icon(Icons.email),
                textwillshow: 'Please Enter your Email ',
                nameContoller: emailcontroller,
              ),
              SizedBox(
                height: 15.0,
              ),
              defultTextForm(
                typeofKeyword: TextInputType.visiblePassword,
                title: 'Enter Your Password',
                IconinText: Icon(Icons.lock),
                textwillshow: 'Please Enter your Password ',
                nameContoller: passwordcontroller,
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: MaterialButton(
                  onPressed: (() {}),
                  child: Text(
                    'Forget PassWord?',
                    style:
                        TextStyle(color: HexColor('#42A2C1'), fontSize: 10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  right: 25.0,
                ),
                width: 300.0,
                decoration: BoxDecoration(color: HexColor("#42A2C1")),
                child: Builder(
                  builder: (context) => Center(
                    child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            UserCredential _userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);

                            if (_userCredential != null) {
                              var _user = _userCredential.user;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()),
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              Alert(
                                  context: context,
                                  title: "user-not-found",
                                  content: Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: emailcontroller,
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.account_circle),
                                          labelText: 'email',
                                        ),
                                      ),
                                      TextField(
                                        controller: passwordcontroller,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.lock),
                                          labelText: 'Password',
                                        ),
                                      ),
                                    ],
                                  ),
                                  buttons: [
                                    DialogButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                            } else if (e.code == 'wrong-password') {
                              Alert(
                                  context: context,
                                  title: "wrong-password",
                                  content: Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: emailcontroller,
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.account_circle),
                                          labelText: 'email',
                                        ),
                                      ),
                                      TextField(
                                        controller: passwordcontroller,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.lock),
                                          labelText: 'Password',
                                        ),
                                      ),
                                    ],
                                  ),
                                  buttons: [
                                    DialogButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                            }
                          }
                        }
                      },
                      child: Text(
                        'Get started',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
