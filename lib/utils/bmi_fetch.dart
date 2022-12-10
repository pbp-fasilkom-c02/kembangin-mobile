import 'package:kembangin_mobile/models/bmi_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Bmi>> fetchBmi() async {
  var url = Uri.parse('https://kembangin.up.railway.app/bmicalculator/json');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Bmi
  List<Bmi> listMyBmi = [];
  for (var d in data) {
    if (d != null) {
      listMyBmi.add(Bmi.fromJson(d));
    }
  }

  return listMyBmi;
}