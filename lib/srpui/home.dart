import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int currIndex = 0;
  @override
  void initState() {
    final _pageController = PageController(initialPage: 0);
    super.initState();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currIndex = page;
              });
            },
            controller: _pageController,
            children: [
              makePage(
                image: 'lib/images/firstImg.png',
                title: Strings.stepOneTitle,
                content: Strings.stepOneContent,
              ),
              makePage(
                reverse: true,
                image: 'lib/images/Qr_scanner.png',
                title: Strings.stepTwoTitle,
                content: Strings.stepTwoContent,
              ),
              makePage(
                image: 'lib/images/notification.jpg',
                title: Strings.stepThreeTitle,
                content: Strings.stepThreeContent,
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 550),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIndicator(),
              ))
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(right: 50, left: 50, top: 20),
      height: 450,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !reverse
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Image.asset(image),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : SizedBox(),
          Text(
            title,
            style: TextStyle(
              color: ColorsSys.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            content,
            style: TextStyle(
                color: ColorsSys.gray,
                fontSize: 10,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          reverse
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _indictor(bool isActive) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 8,
        width: isActive ? 25 : 8,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: ColorsSys.snd3,
          borderRadius: BorderRadius.circular(5),
        ));
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currIndex == i) {
        indicators.add(_indictor(true));
      } else {
        indicators.add(_indictor(false));
      }
    }
    return indicators;
  }
}

class ColorsSys {
  static Color primary = Color.fromRGBO(52, 43, 37, 1);
  static Color gray = Color.fromRGBO(137, 137, 137, 1);
  static Color snd1 = Color.fromRGBO(198, 116, 27, 1);
  static Color snd2 = Color.fromRGBO(226, 185, 141, 1);
  static Color snd3 = Color.fromARGB(255, 156, 70, 143);
}

class Strings {
  static var stepOneTitle = "Expiry Reminder";
  static var stepOneContent =
      "Helpful to avoid Consumption of Expired Medicines";
  static var stepTwoTitle = "QR Scanner";
  static var stepTwoContent =
      "Be Useful to reduce Manual Entry of the details of Medicine by Scanning QR";
  static var stepThreeTitle = "Getting notified";
  static var stepThreeContent =
      "Can be Notified about the Expiry Date of the certain Medicine based on the date provided in QR";
}
