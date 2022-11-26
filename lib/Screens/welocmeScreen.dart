// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

import '../reuableComponent.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool ischeck = false;
  var titlecontroller = TextEditingController();
  var descriptioncontroller = TextEditingController();
  var timecontroller = TextEditingController();

  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  var formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 321.0,
                width: 400.0,
                decoration: BoxDecoration(
                    color: HexColor('#42A2C1'),
                    borderRadius: BorderRadius.circular(15.0)),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20.0, top: 150.0, left: 130.0, right: 130.0),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('images/hussein.jpg'),
                  ),
                ),
              ),
              SizedBox(
                height: 7.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 280.0),
                child: Center(
                  child: Text('Welcome Ya Hueesin',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text('Tasks list',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: HexColor('#D9D9D9')),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Daily Tasks',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(width: 10.0),
                          //add new task and show bootomsheet
                          IconButton(
                              onPressed: (() {
                                showModalBottomSheet(
                                    elevation: 0.0,
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor: Colors.white,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 50.0),
                                              defultTextForm(
                                                typeofKeyword:
                                                    TextInputType.text,
                                                title: 'Enter Your Task Title',
                                                IconinText: Icon(Icons.title),
                                                textwillshow:
                                                    'Please Enter your Task Title ',
                                                nameContoller: titlecontroller,
                                              ),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: HexColor('#D9D9D9'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                height: 60.0,
                                                width: 326.0,
                                                child: TextFormField(
                                                  onTap: () {
                                                    showTimePicker(
                                                            context: context,
                                                            initialTime:
                                                                TimeOfDay.now())
                                                        .then((value) => {
                                                              timecontroller
                                                                      .text =
                                                                  value!
                                                                      .format(
                                                                          context)
                                                                      .toString()
                                                            });
                                                  },
                                                  keyboardType:
                                                      TextInputType.datetime,
                                                  showCursor: true,
                                                  enableSuggestions: true,
                                                  controller: timecontroller,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    labelText: ('Text time'),
                                                    suffixIcon: Icon(Icons
                                                        .watch_later_outlined),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please inter the time of the task';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15.0,
                                              ),
                                              defultTextForm(
                                                typeofKeyword:
                                                    TextInputType.text,
                                                title: 'Enter Description Task',
                                                IconinText:
                                                    Icon(Icons.description),
                                                textwillshow:
                                                    'Please Enter your  Description Task ',
                                                nameContoller:
                                                    descriptioncontroller,
                                              ),
                                              MaterialButton(
                                                  child: Text(
                                                    'Add task',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () async {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      var current_user =
                                                          FirebaseAuth.instance
                                                              .currentUser;
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('posts')
                                                          .doc()
                                                          .set({
                                                        'title': titlecontroller
                                                            .text,
                                                        'description':
                                                            descriptioncontroller
                                                                .text,
                                                        'time':
                                                            timecontroller.text,
                                                        'user': {
                                                          'email': current_user
                                                              ?.email,
                                                          'phone': current_user
                                                              ?.phoneNumber,
                                                        },
                                                      });
                                                    }
                                                  }),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              icon: Icon(Icons.add_box_outlined)),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                          flex: 3,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return ListView(
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    return ListTile(
                                      leading: Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                      title: Text(document['title']),
                                      trailing: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(document['time']),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('posts')
                                                  .doc(document.id)
                                                  .delete();
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(document['description']),
                                    );
                                  }).toList(),
                                );
                              })),
                    ]),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                padding: EdgeInsets.only(left: 20.0),
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: HexColor('#D9D9D9')),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text('Monthly Tasks',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                        onPressed: (() {
                          showModalBottomSheet(
                              elevation: 0.0,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.white,
                              builder: (BuildContext context) {
                                return Center(
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 50.0),
                                        defultTextForm(
                                          typeofKeyword: TextInputType.text,
                                          title: 'Enter Your Task Title',
                                          IconinText: Icon(Icons.title),
                                          textwillshow:
                                              'Please Enter your Task Title ',
                                          nameContoller: titlecontroller,
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: HexColor('#D9D9D9'),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          height: 60.0,
                                          width: 326.0,
                                          child: TextFormField(
                                            onTap: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now())
                                                  .then((value) => {
                                                        timecontroller.text =
                                                            value!
                                                                .format(context)
                                                                .toString()
                                                      });
                                            },
                                            keyboardType:
                                                TextInputType.datetime,
                                            showCursor: true,
                                            enableSuggestions: true,
                                            controller: timecontroller,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              labelText: ('Text time'),
                                              suffixIcon: Icon(
                                                  Icons.watch_later_outlined),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please inter the time of the task';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        defultTextForm(
                                          typeofKeyword: TextInputType.text,
                                          title: 'Enter Description Task',
                                          IconinText: Icon(Icons.description),
                                          textwillshow:
                                              'Please Enter your  Description Task ',
                                          nameContoller: descriptioncontroller,
                                        ),
                                        MaterialButton(
                                            child: Text(
                                              'Add task',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                var current_user = FirebaseAuth
                                                    .instance.currentUser;
                                                await FirebaseFirestore.instance
                                                    .collection('posts')
                                                    .doc()
                                                    .set({
                                                  'title': titlecontroller.text,
                                                  'description':
                                                      descriptioncontroller
                                                          .text,
                                                  'time': timecontroller.text,
                                                  'user': {
                                                    'email':
                                                        current_user?.email,
                                                    'phone': current_user
                                                        ?.phoneNumber,
                                                  },
                                                });
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),
                        icon: Icon(Icons.add_box_outlined)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
