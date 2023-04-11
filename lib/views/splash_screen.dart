import 'package:fcs_predictor/constants/customcolor.dart';
import 'package:fcs_predictor/constants/units.dart';
import 'package:fcs_predictor/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // To end the startup after 3 seconds and call HomePage
    startup();
  }

  startup() async {
    await Future.delayed(new Duration(seconds: 4));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future<bool>.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          constraints: BoxConstraints.expand(),

          // to put elements over the bg
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: Colors.white,
                    //   radius: Units.width(context) * 0.15,
                    // ),
                    Image(
                      image: AssetImage('images/visual_data.png'),
                      width: Units.width(context) * 0.5,
                      height: Units.width(context) * 0.5,
                    ),
                    SizedBox(height: Units.height(context) * 0.015),
                    Text(
                      'FCS Predictor',
                      style: TextStyle(
                          // color: Colors.white,
                          fontSize: Units.title(context),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: Units.height(context) * 0.01),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Loading',
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: Units.regularText(context),
                          ),
                        ),
                        SizedBox(width: Units.width(context) * 0.02),
                        SpinKitThreeBounce(
                          color: Colors.black,
                          size: Units.regularText(context),
                        )
                      ],
                    ),
                    SizedBox(height: Units.height(context) * 0.09),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class RootPage extends StatefulWidget {
//   RootPage({Key? key}) : super(key: key);

//   @override
//   _RootPageState createState() => _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   late PageController controller;
//   int currentPage = 1;

//   @override
//   void initState() {
//     super.initState();
//     controller = PageController(initialPage: 1);
//   }

//   DateTime? currentBackPressTime;
//   Future<bool> onWillPop() {
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
//       currentBackPressTime = now;
//       Fluttertoast.showToast(msg: 'Press again to exit the app.');
//       return Future.value(false);
//     }
//     return Future.value(true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: onWillPop,
//       child: Scaffold(
//           bottomNavigationBar: FancyBottomNavigation(
//             inactiveIconColor: CustomColor.blue,
//             circleColor: CustomColor.blue,
//             tabs: [
//               TabData(
//                 iconData: Icons.history,
//                 title: "History",
//               ),
//               TabData(
//                 iconData: Icons.qr_code_2,
//                 title: "Scan",
//               ),
//               TabData(
//                 iconData: Icons.add_box_outlined,
//                 title: "Create",
//               ),
//               TabData(
//                 iconData: Icons.settings,
//                 title: "Settings",
//               ),
//             ],
//             initialSelection: 1,
//             //key: bottomNavigationKey,
//             onTabChangedListener: (position) {
//               setState(() {
//                 currentPage = position;
//                 controller.jumpToPage(position);
//               });
//             },
//           ),
//           body: PageView(
//             controller: controller,
//             children: [
//               History(),
//               Home(),
//               CreatePage(),
//               Setting(),
//             ],
//           )),
//     );
//   }
// }
