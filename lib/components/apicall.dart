import 'dart:convert';
import 'dart:math';

import 'package:fcs_predictor/constants/variables.dart';
import 'package:fcs_predictor/constants/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future getRequest(country, crop, start, end) async {
  //replace your restFull API here.
  var url =
      "http://localhost:3000/py?country=$country&crop=$crop&start=$start&end=$end";
  final response = await http.get(Uri.parse(url));

  try {
    if (response.statusCode == 200) {
      String data = response.body.toString();
      Map<String, dynamic> decodedData = jsonDecode(data);
      print('data json ' + decodedData.toString());
    } else {
      print('failed');
    }
  } catch (e) {
    print(e);
  }
  // print(responseData.toString());
}

Map<String, dynamic> dummydata = {
  "country": "India",
  "crop": "Wheat",
  "start": "2023",
  "end": "2025",
  "temperature": [25.23, 25.29, 25.15],
  "production": [3.606049779306275, 3.6433133894731924, 3.7221618187915055]
};

setValue() {
  Variables.temp = dummydata['temperature'];
  Variables.production = dummydata['production'];
}
