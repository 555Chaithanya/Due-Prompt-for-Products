import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xpire/Gen_qrProvider/gen_qr.dart';
import 'package:xpire/QRcontent/qr_scan.dart';
import 'package:xpire/srpui/home.dart';
import 'package:xpire/srpui/notification.dart';
import 'package:xpire/srpui/profilesettings.dart';

import 'listing.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  int selectedPage = 1;
  final _pageOption = [qrScanner(), Home(), Listing()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              /*Navigator.push(
                  context, MaterialPageRoute(builder: (context) => notify()));*/
            },
            icon: Icon(
              Icons.search_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => notify()));
            },
            icon: Icon(
              Icons.notifications_active,
              color: Color.fromARGB(255, 8, 73, 153),
            ),
          ),
        ],
        title: Text(
          "   Xpire..App",
        ),
        elevation: 5,
        leading: IconButton(
          onPressed: () async {
            DocumentSnapshot prf = await FirebaseFirestore.instance
                .collection('users')
                .doc('${FirebaseAuth.instance.currentUser!.uid}')
                .get();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => prifilepage(
                          userDet: prf,
                        )));
          },
          icon: Icon(Icons.manage_accounts, color: Colors.white),
        ),
        backgroundColor: ColorsSys.snd3,
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: ColorsSys.snd3,
        color: Color.fromARGB(255, 8, 73, 153),
        activeColor: Color.fromARGB(255, 8, 73, 153),
        items: [
          TabItem(
              icon: Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
              ),
              title: "Scan Qr"),
          TabItem(icon: Icon(Icons.home, color: Colors.white), title: "Home"),
          TabItem(
              icon: Icon(Icons.list_rounded, color: Colors.white),
              title: "List"),
        ],
        initialActiveIndex: selectedPage,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
      body: _pageOption[selectedPage],
    );
  }
}

class ColorsSys {
  static Color primary = Color.fromRGBO(52, 43, 37, 1);
  static Color gray = Color.fromRGBO(137, 137, 137, 1);
  static Color snd1 = Color.fromRGBO(198, 116, 27, 1);
  static Color snd2 = Color.fromRGBO(226, 185, 141, 1);
  static Color snd3 = Color.fromARGB(255, 156, 70, 143);
}
