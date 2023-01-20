import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:xpire/UserAuth/login_screen.dart';
import 'package:xpire/srpui/welcome.dart';

class prifilepage extends StatefulWidget {
  final userDet;
  prifilepage({@required this.userDet});

  @override
  State<prifilepage> createState() => _prifilepageState(x1: userDet);
}

class _prifilepageState extends State<prifilepage> {
  DocumentSnapshot? x1;
  _prifilepageState({@required this.x1});
  bool status1 = false;
  //bool status2 = false;

  File? profilePic;
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Manage Profile"),
          elevation: 5,
          backgroundColor: ColorsSys.snd3,
        ),
        body: Container(
          //color: Color.fromARGB(255, 248, 248, 248),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: CupertinoButton(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: ColorsSys.snd3,
                      backgroundImage: /*(profilePic != null) &
                              (FirebaseAuth.instance.currentUser != null)
                          ? FileImage(profilePic!)
                          : null*/
                          AssetImage('lib/images/profile.png'),
                    ),
                    onPressed: () async {
                      /* XFile? selectedImage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (selectedImage != null) {
                        File convertedFile = File(selectedImage.path);
                        setState(() {
                          profilePic = convertedFile;
                        });
                        log("Image Selected!");
                      } else {
                        log("Image Not Selected!");
                      }
                      */
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                  shape: s,
                  child: ListTile(
                    shape: s,
                    title: Text("UserName: "),
                    trailing: Text(
                      "${x1!['name']}",
                      style: TextStyle(color: ColorsSys.gray),
                    ),
                  )),
              Card(
                  shape: s,
                  child: ListTile(
                    shape: s,
                    title: Text("Email Id: "),
                    trailing: Text(
                      "${x1!['email']}",
                      style: TextStyle(color: ColorsSys.gray),
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Card(
                      child: ListTile(
                    title: Text("App Settings: ",
                        style: TextStyle(
                            color: ColorsSys.gray,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.left),
                  )),
                  Card(
                      shape: s,
                      child: SwitchListTile(
                        shape: s,
                        title: Text("DarkMode"),
                        onChanged: (val) {
                          print("DarkMode is $val");
                          setState(() {
                            status1 = val;
                          });
                        },
                        value: status1,
                      )),
                  Card(
                      shape: s,
                      child: ListTile(
                        shape: s,
                        title: Text("Do you want to log Out? "),
                        trailing: ElevatedButton.icon(
                          icon: Icon(Icons.exit_to_app_outlined),
                          style: x,
                          onPressed: () {
                            logOut();
                          },
                          label: Text("SignOut"),
                        ),
                      )),
                ],
              )
            ],
          ),
        ));
  }
}

var x = ButtonStyle(
  shape:
      MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  )),
  backgroundColor: MaterialStateProperty.all<Color>(ColorsSys.snd3),
);
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
