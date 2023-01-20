import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:xpire/UserAuth/login_screen.dart';
import 'package:xpire/srpui/welcome.dart';

import '../UserAuth/colors.dart';
import '../srpui/profilesettings.dart';
import 'exit_popup.dart';

class QRview extends StatefulWidget {
  const QRview({Key? key}) : super(key: key);

  @override
  State<QRview> createState() => _QRviewState();
}

class _QRviewState extends State<QRview> {
  //Uint8List _imgFile;

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  ValueNotifier<bool> isDailopen = ValueNotifier(false);
  String qrData = FirebaseAuth.instance.currentUser!.uid;
  final _scrshtController = ScreenshotController();

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /*FirebaseAuth.instance.currentUser!.uid;*/
  GlobalKey globalKey = new GlobalKey();
  final bodyHeight = 460;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (isDailopen.value) {
            isDailopen.value = false;
            return false;
          } else {
            return showExitPopup(context);
          }
        },
        child: Scaffold(
            floatingActionButton: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              openCloseDial: isDailopen,
              closeManually: true,
              backgroundColor: ColorsSys.snd3,
              spacing: 20,
              overlayOpacity: 0.2,
              //opencloseManually: true,
              spaceBetweenChildren: 10,
              children: [
                SpeedDialChild(
                    child: Icon(Icons.share),
                    label: "Share",
                    labelStyle: TextStyle(color: Colors.white),
                    labelBackgroundColor: Color.fromARGB(255, 8, 73, 153),
                    onTap: () {}),
              ],
            ),
            appBar: AppBar(
              title: Text("QRView"),
              backgroundColor: ColorsSys.snd3,
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
              actions: [
                IconButton(
                    onPressed: () {
                      logOut();
                    },
                    icon: Icon(Icons.exit_to_app_outlined)),
              ],
            ),
            body: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                      height: 150,
                    ),
                    Screenshot(
                      controller: _scrshtController,
                      child: Card(
                        child: Expanded(
                            child: RepaintBoundary(
                          key: globalKey,
                          child: QrImage(
                            data: (qrData),
                            size: 0.50 * bodyHeight,
                          ),
                        )),
                      ),
                    )
                  ]),
                ],
              ),
            )));
  }

  static GlobalKey _globalKey = GlobalKey();
  /*Future<Null> shareScreenshot() async {
    try {
      RenderObject? boundary = _globalKey.currentContext.findRenderObject();
      if (boundary.debugNeedsPaint) {
        Timer(Duration(seconds: 1), () => shareScreenshot());
        return null;
      }
      ui.Image image = await boundary!.toImage();
      final directory = (await getExternalStorageDirectory()).path;
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      final RenderBox box = context.findRenderObject();
      Share.shareFiles(File('$directory/screenshot.png'),
          subject: 'Share ScreenShot',
          text: 'Hello, check your share files!',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
    }
  }*/
}

class ColorsSys {
  static Color primary = Color.fromRGBO(52, 43, 37, 1);
  static Color gray = Color.fromRGBO(137, 137, 137, 1);
  static Color snd1 = Color.fromRGBO(198, 116, 27, 1);
  static Color snd2 = Color.fromRGBO(226, 185, 141, 1);
  static Color snd3 = Color.fromARGB(255, 156, 70, 143);
}
