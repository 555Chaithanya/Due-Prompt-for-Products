import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xpire/UserAuth/resetpassword.dart';
import 'package:xpire/UserAuth/signup_screen.dart';
import 'package:xpire/srpui/mainscreen.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'resuable_widgets.dart';
import 'colors.dart';

class ChoosingPage extends StatefulWidget {
  const ChoosingPage({Key? key}) : super(key: key);

  @override
  State<ChoosingPage> createState() => _ChoosingPageState();
}

class _ChoosingPageState extends State<ChoosingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("lib/images/expiry.png"),
                const SizedBox(
                  height: 30,
                ),
                firebaseUIButton(context, "Register as User", () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SignUpScreen(true))));
                }),
                const SizedBox(
                  height: 30,
                ),
                firebaseUIButton(context, "Register as QR Provider", () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SignUpScreen(false))));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
