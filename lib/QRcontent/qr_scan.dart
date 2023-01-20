import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:xpire/QRcontent/qr_data.dart';

class qrScanner extends StatefulWidget {
  const qrScanner({Key? key}) : super(key: key);

  @override
  State<qrScanner> createState() => _qrScannerState();
}

var r;
var scanArea;

class _qrScannerState extends State<qrScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

  var x;
  @override
  void reassemble() {
    super.reassemble;
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (result != null)
                      Center(
                        child: Text(
                          "Data has been read successfully",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: ColorsSys.snd3,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Center(
                        child: Text(
                          "Scan QR code",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 8, 73, 153),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller?.flipCamera();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          primary: Color.fromARGB(255, 8, 73, 153),
                        ),
                        child: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: ((context, snapshot) {
                              if (snapshot.data != null) {
                                return Text(
                                  'Camera ${describeEnum(snapshot.data!)}',
                                );
                              } else {
                                return Text("loading");
                              }
                            })),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: ElevatedButton(
                          onPressed: () async {
                            /*coonection to firestore is made here*/
                            DocumentSnapshot store = await FirebaseFirestore
                                .instance
                                .collection('providers')
                                .doc('$r')
                                .get();
                            if (r != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => qr_data(
                                            data: r,
                                            data2: store,
                                          )));
                            } else {
                              log("Data is empty!");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            primary: Color.fromARGB(255, 8, 73, 153),
                          ),
                          child: Text("See Data")),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    scanArea = (MediaQuery.of(context).size.width < 600 ||
            MediaQuery.of(context).size.height < 600)
        ? 230.0
        : 500.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: ColorsSys.snd3,
        borderRadius: 37,
        borderLength: 20,
        borderWidth: 20,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        r = result!.code;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class ColorsSys {
  static Color primary = Color.fromRGBO(52, 43, 37, 1);
  static Color gray = Color.fromRGBO(137, 137, 137, 1);
  static Color snd1 = Color.fromRGBO(198, 116, 27, 1);
  static Color snd2 = Color.fromRGBO(226, 185, 141, 1);
  static Color snd3 = Color.fromARGB(255, 156, 70, 143);
}
