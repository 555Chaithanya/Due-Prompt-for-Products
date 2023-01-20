import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:xpire/srpui/mainscreen.dart';
import 'qr_scan.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:xpire/srpui/listing.dart';

class qr_data extends StatefulWidget {
  final data, data2;
  qr_data({@required this.data, @required this.data2});

  @override
  State<qr_data> createState() => _qr_dataState(meddata: data, x1: data2);
}

class _qr_dataState extends State<qr_data> {
  var meddata; //storeid=meddata
  DocumentSnapshot? x1;
  _qr_dataState({@required this.meddata, @required this.x1});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSys.snd3,
        title: Text("QR Information"),
      ),
      body: SafeArea(
          child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Medicine Name: ${x1!['name']}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Expiry Date: ${x1!['expiryDate']}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: x,
                onPressed: () async {
                  DocumentSnapshot user = await FirebaseFirestore.instance
                      .collection('users')
                      .doc('${FirebaseAuth.instance.currentUser!.uid}')
                      .get();
                  DocumentSnapshot qrprovider = await FirebaseFirestore.instance
                      .collection('providers')
                      .doc('$meddata')
                      .get();
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc('${FirebaseAuth.instance.currentUser!.uid}')
                      .collection('scanned')
                      .doc()
                      .set({
                    'Name': qrprovider['name'],
                    'ExpiryDate': qrprovider['expiryDate']
                  });
                  print(qrprovider['name']);
                  print(user['email']);
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc('$meddata')
                      .collection('ScannedUsers')
                      .doc()
                      .set({
                    'email': user['email'],
                    'UserType': user['user_type']
                  });
                  log("data added");
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => mainScreen())));
                },
                child: Text("Add Data"))
          ],
        ),
      )),
    );
  }
}

var x = ButtonStyle(
  shape:
      MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  )),
  backgroundColor: MaterialStateProperty.all<Color>(ColorsSys.snd3),
);

class ColorsSys {
  static Color primary = Color.fromRGBO(52, 43, 37, 1);
  static Color gray = Color.fromRGBO(137, 137, 137, 1);
  static Color snd1 = Color.fromRGBO(198, 116, 27, 1);
  static Color snd2 = Color.fromRGBO(226, 185, 141, 1);
  static Color snd3 = Color.fromARGB(255, 156, 70, 143);
}
