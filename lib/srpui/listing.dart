import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Listing extends StatefulWidget {
  const Listing({Key? key}) : super(key: key);

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  @override
  Widget build(BuildContext context) {
    Query usermed = FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser!.uid}')
        .collection('scanned')
        .orderBy('ExpiryDate', descending: true);
    print(FirebaseAuth.instance.currentUser!.uid);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: usermed.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: SafeArea(
                  child: Center(
                    child: SpinKitRing(
                      color: Color.fromARGB(255, 8, 73, 153),
                      size: 55,
                    ),
                  ),
                ),
              );
            }
            return Container(
                color: Colors.white60,
                child: ListView(
                  addAutomaticKeepAlives: false,
                  cacheExtent: 300,
                  reverse: false,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    return Card(
                      shape: s,
                      child: ListTile(
                        shape: s,
                        title: Text(
                          "${document.get('Name')}",
                          style:
                              TextStyle(color: Color.fromARGB(255, 8, 73, 153)),
                        ),
                        subtitle: Text(
                          "Expiry Date: ${document.get("ExpiryDate")}",
                          style:
                              TextStyle(color: Color.fromARGB(255, 8, 73, 153)),
                        ),
                        trailing: IconButton(
                            color: Color.fromARGB(255, 8, 73, 153),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(
                                      '${FirebaseAuth.instance.currentUser!.uid}')
                                  .collection('scanned')
                                  .doc('$document')
                                  .delete();
                            },
                            icon: Icon(Icons.delete_sharp)),
                        isThreeLine: true,
                      ),
                    );
                  }).toList(),
                ));
          }),
    );
  }
}

var s = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20.0),
);

class ColorsSys {
  static Color primary = Color.fromRGBO(52, 43, 37, 1);
  static Color gray = Color.fromRGBO(137, 137, 137, 1);
  static Color snd1 = Color.fromRGBO(198, 116, 27, 1);
  static Color snd2 = Color.fromRGBO(226, 185, 141, 1);
  static Color snd3 = Color.fromARGB(255, 156, 70, 143);
}
