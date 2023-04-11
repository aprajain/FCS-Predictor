import 'package:fcs_predictor/components/apicall.dart';
import 'package:fcs_predictor/constants/customcolor.dart';
import 'package:fcs_predictor/constants/units.dart';
import 'package:fcs_predictor/constants/variables.dart';
import 'package:fcs_predictor/views/results.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      // Fluttertoast.showToast(msg: 'Press again to exit the app.');
      return Future.value(false);
    }
    return Future.value(true);
  }

  String country = 'India';
  List<String> countries = [
    'India',
    'USA',
    'China',
    'Russia',
    'Bangladesh',
  ];

  String crop = 'Rice';
  List<String> crops = [
    'Rice',
    'Wheat',
    'Corn',
    'Barley',
    'Maize',
  ];

  Widget countryDropDown() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(Units.width(context) * 0.03),
      padding: EdgeInsets.symmetric(
          vertical: Units.width(context) * 0.01,
          horizontal: Units.width(context) * 0.05),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightBlue.shade50,
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
        value: country,
        onChanged: (newValue) {
          setState(() {
            country = newValue.toString();
            Variables.country = country;
          });
        },
        items: countries.map((catagoryname) {
          return DropdownMenuItem(
            child: new Text(
              catagoryname,
            ),
            value: catagoryname,
          );
        }).toList(),
      )),
    );
  }

  Widget cropsDropDown() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(Units.width(context) * 0.03),
      padding: EdgeInsets.symmetric(
          vertical: Units.width(context) * 0.01,
          horizontal: Units.width(context) * 0.05),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightBlue.shade50,
      ),
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
        value: crop,
        onChanged: (newValue) {
          setState(() {
            crop = newValue.toString();
            Variables.crop = crop;
          });
        },
        items: crops.map((catagoryname) {
          return DropdownMenuItem(
            child: new Text(
              catagoryname,
            ),
            value: catagoryname,
          );
        }).toList(),
      )),
    );
  }

  Widget button() {
    return Container(
      margin: EdgeInsets.fromLTRB(Units.width(context) * 0.6,
          Units.width(context) * 0.02, Units.width(context) * 0.02, 0),
      padding: EdgeInsets.symmetric(
          vertical: Units.width(context) * 0.03,
          horizontal: Units.width(context) * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: CustomColor.green,
      ),
      child: Text(
        "GENERATE",
        style: TextStyle(
          // color: Colors.white,
          fontSize: Units.content(context),
        ),
      ),
    );
  }

  int start = 2030, end = 2040;

  RangeValues _currentRangeValues = RangeValues(2030, 2040);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'FCS Predictor',
              style: TextStyle(
                  fontSize: Units.heading(context),
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Units.height(context) * 0.04),
                // Image(
                //   image: AssetImage('images/visual_data.png'),
                //   width: Units.width(context) * 0.5,
                //   height: Units.width(context) * 0.5,
                // ),
                // SizedBox(height: Units.width(context) * 0.05),
                countryDropDown(),
                cropsDropDown(),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(Units.width(context) * 0.03),
                  padding: EdgeInsets.symmetric(
                      vertical: Units.width(context) * 0.05,
                      horizontal: Units.width(context) * 0.05),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue.shade50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Start Year",
                        style:
                            TextStyle(fontSize: Units.content(context) * 1.11),
                      ),
                      Text(
                        start.toString(),
                        style:
                            TextStyle(fontSize: Units.content(context) * 1.11),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(Units.width(context) * 0.03),
                  padding: EdgeInsets.symmetric(
                      vertical: Units.width(context) * 0.05,
                      horizontal: Units.width(context) * 0.05),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue.shade50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "End Year",
                        style:
                            TextStyle(fontSize: Units.content(context) * 1.11),
                      ),
                      Text(
                        end.toString(),
                        style:
                            TextStyle(fontSize: Units.content(context) * 1.11),
                      ),
                    ],
                  ),
                ),
                RangeSlider(
                  values: _currentRangeValues,
                  min: 2021,
                  max: 2100,
                  divisions: 80,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                      start = _currentRangeValues.start.round();
                      end = _currentRangeValues.end.round();

                      Variables.start = start;
                      Variables.end = end;
                    });
                  },
                ),
                SizedBox(height: Units.height(context) * 0.05),
                InkWell(
                    onTap: () {
                      setValue();
                      // getRequest(
                      //     country, crop, start.toString(), end.toString());\
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Results()));
                    },
                    child: button()),
                SizedBox(height: Units.height(context) * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
