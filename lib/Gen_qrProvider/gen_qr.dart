import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:xpire/Gen_qrProvider/qr_view.dart';

class generate_qr extends StatefulWidget {
  const generate_qr({Key? key}) : super(key: key);

  @override
  State<generate_qr> createState() => _generate_qrState();
}

class _generate_qrState extends State<generate_qr> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 220.0;

  GlobalKey globalKey = new GlobalKey();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final bodyHeight = 460;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Generator"),
        backgroundColor: ColorsSys.snd3,
        /*leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_sharp)),*/
        /*actions: [
          IconButton(
              icon: Icon(Icons.download),
              onPressed: () {} //_captureAndSharePng,
              )
        ],*/
      ),
      body: Container(
          child: Column(children: [
        SizedBox(
          height: 50.0,
        ),
        Container(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "lib/images/qr_gen.png",
                  height: 200,
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.dataset_outlined),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      labelText: "Medicine Name",
                      hintText: " enter tablet name here"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _date,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.calendar_today),
                    labelText: "ExpiryDate",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2055),
                    );
                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        _date.text = formattedDate;
                      });
                    } else {
                      print("Date is not Selected");
                    }
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                      style: x,
                      /*ElevatedButton.styleFrom(
                        primary: ColorsSys.snd3,
                      ),*/
                      onPressed: () async {
                        /*setState(() {
                              _dataString = _name.text + _date.text;
                              _inputErrorText = '';
                            });*/
                        FirebaseFirestore.instance
                            .collection('providers')
                            .doc('${FirebaseAuth.instance.currentUser!.uid}')
                            .set({
                          'name': _name.text,
                          'expiryDate': _date.text,
                          'userId': FirebaseAuth.instance.currentUser!.uid,
                        });
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => QRview()));
                      },
                      child: Text("Submit"))),
            ])),
      ])),
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
