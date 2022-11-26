// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_basic1/Screens/loginScrren.dart';
import 'package:flutter_application_basic1/Screens/welocmeScreen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../reuableComponent.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Welcome Onboard! ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Let’s help you meet up your tasks',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  defultTextForm(
                    typeofKeyword: TextInputType.name,
                    title: ' Enter Your Full Name',
                    IconinText: Icon(Icons.info),
                    textwillshow: 'Please Enter Your Full Name:',
                    nameContoller: namecontroller,
                    //textofFiled: fullName
                  ),
                  defultSizeBox(),
                  defultTextForm(
                    typeofKeyword: TextInputType.emailAddress,
                    title: ' Enter Your Email',
                    IconinText: Icon(Icons.email),
                    textwillshow: 'Please Enter Your Email:',
                    nameContoller: emailcontroller,
                    //textofFiled: email
                  ),
                  defultSizeBox(),
                  defultTextForm(
                    typeofKeyword: TextInputType.visiblePassword,
                    title: ' Enter Your  Password',
                    IconinText: Icon(Icons.lock),
                    textwillshow: 'Please Enter Your Password:',
                    nameContoller: passwordcontroller,
                    //textofFiled: paaword
                  ),
                  defultSizeBox(),
                  defultTextForm(
                    typeofKeyword: TextInputType.visiblePassword,
                    title: 'Enter Phone',
                    IconinText: Icon(Icons.phone),
                    textwillshow: 'Please Enter Your Phone:',
                    nameContoller: phonecontroller,
                    // textofFiled: confirmPaaword
                  ),
                  defultSizeBox(),
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
                            if (formkey.currentState!.validate()) {
                              var result = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                              if (result != null) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(result.user!.uid)
                                    .set({
                                  'fullName': namecontroller.text,
                                  'phone': phonecontroller.text,
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomeScreen()),
                                );
                              } else {
                                Alert(
                                    context: context,
                                    title: "This email found",
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
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ]).show();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (((context) =>
                                          WelcomeScreen()))));
                            }
                          },
                          child: Text(
                            'Get started',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: avoid_unnecessary_containers
                      Text(
                        'Already have an account ? ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),

                      Builder(builder: (context) {
                        return TextButton(
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (((context) => LoginScreen()))))
                          },
                          child: Text(
                            'Sign in ',
                            style: TextStyle(
                                color: HexColor('#42A2C1'), fontSize: 10.0),
                          ),
                        );
                      }),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
