import 'dart:convert';
import 'package:fcs_predictor/constants/variables.dart';
import 'package:http/http.dart' as http;

Future getRequest(country, crop, start, end) async {
  var base = "https://fcs-server-py.onrender.com";
  var base1 = "http://127.0.0.1:3000";
  var url = "$base/py?country=$country&crop=$crop&start=$start&end=$end";
  final response = await http.get(Uri.parse(url));

  try {
    if (response.statusCode == 200) {
      String data = response.body.toString();
      Map<String, dynamic> decodedData = jsonDecode(data);
      Variables.temp = decodedData['temperature'];
      Variables.production = decodedData['production'];
    } else {
      print('failed');
    }
  } catch (e) {
    print(e);
  }
}

// Map<String, dynamic> dummydata = {
//   "country": "India",
//   "crop": "Wheat",
//   "start": "2023",
//   "end": "2025",
//   "temperature": [25.23, 25.29, 25.15],
//   "production": [3.606049779306275, 3.6433133894731924, 3.7221618187915055]
// };

// setValue() {
//   Variables.temp = dummydata['temperature'];
//   Variables.production = dummydata['production'];
// }
