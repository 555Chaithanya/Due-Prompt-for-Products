import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notify extends StatelessWidget {
  const notify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsSys.snd3,
          elevation: 5,
          title: Text("Notifications"),
        ),
        body: Center(
          child: Icon(
            Icons.notifications_active,
            size: 100,
            color: ColorsSys.gray,
          ),
        ));
  }
}

class ColorsSys {
  static Color primary = Color.fromRGBO(52, 43, 37, 1);
  static Color gray = Color.fromRGBO(137, 137, 137, 1);
  static Color snd1 = Color.fromRGBO(198, 116, 27, 1);
  static Color snd2 = Color.fromRGBO(226, 185, 141, 1);
  static Color snd3 = Color.fromARGB(255, 156, 70, 143);
}
