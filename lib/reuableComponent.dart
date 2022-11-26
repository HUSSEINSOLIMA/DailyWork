// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Screens/registerScreens.dart';

var nameContoller;
Widget defultButton() => Container(
      width: 300.0,
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Get started',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );
Widget defultTextForm(
        {required String title,
        required Icon IconinText,
        required String textwillshow,
        required var nameContoller,
        TextInputType? typeofKeyword,
        String textofFiled = '',
        Function? function}) =>
    Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 26.0),
      child: Container(
        height: 60.0,
        width: 326.0,
        decoration: BoxDecoration(
          color: HexColor('#D9D9D9'),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: TextFormField(
          onTap: () {
            function;
          },
          keyboardType: typeofKeyword,
          showCursor: true,
          enableSuggestions: true,
          controller: nameContoller,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            labelText: ('$title'),
            suffixIcon: IconinText,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$textwillshow';
            }
            return null;
          },
        ),
      ),
    );
Widget defultSizeBox() => SizedBox(
      height: 20.0,
    );
Widget divider() => Container(
      child: Divider(height: 1.0, color: Colors.grey),
    );
