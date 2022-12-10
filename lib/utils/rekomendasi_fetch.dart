import '/models/rekomendasi_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Rekomendasi>> fetchRekomendasi() async {
  var url = Uri.parse('https://kembangin.up.railway.app/rekomendasi/json/');
  var response = await http.get(url, headers: {
    "Access-Control-Allow-Origin": "*",
    "Content-Type": "application/json",
  });

  // var response = await http.get(url, headers: {
  //   'Content-Type': 'application/json',
  //   'Accept': 'application/json',
  // });


  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object ToDo
  List<Rekomendasi> listRekomendasi = [];
  for (var d in data) {
    if (d != null) {
      listRekomendasi.add(Rekomendasi.fromJson(d));
    }
  }

  return listRekomendasi;
}
