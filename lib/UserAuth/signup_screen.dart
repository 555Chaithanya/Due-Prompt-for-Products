import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:xpire/Gen_qrProvider/gen_qr.dart';
import 'package:xpire/srpui/mainscreen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'resuable_widgets.dart';
import 'colors.dart';

class SignUpScreen extends StatefulWidget {
  final bool us;
  SignUpScreen(this.us);
  //const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState(us: us);
}

class _SignUpScreenState extends State<SignUpScreen> {
  final bool us;
  _SignUpScreenState({required this.us});

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      //floatingActionButton: ,
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
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    if (us == true) {
                      print("Created New User Account");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => mainScreen()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => generate_qr()));
                    }
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc('${FirebaseAuth.instance.currentUser!.uid}')
                        .set({
                      'name': _userNameTextController.text,
                      'email': _emailTextController.text,
                      'userId': FirebaseAuth.instance.currentUser!.uid,
                      'user_type': us,
                    });
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          ))),
    );
  }
}

class ColorsSys {
  static Color primary = Color.fromRGBO(52, 43, 37, 1);
  static Color ind = Color.fromARGB(255, 8, 73, 153);
  static Color snd1 = Color.fromRGBO(198, 116, 27, 1);
  static Color snd2 = Color.fromRGBO(226, 185, 141, 1);
  static Color snd3 = Color.fromARGB(255, 156, 70, 143);
}
