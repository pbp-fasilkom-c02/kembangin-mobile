import 'package:kembangin_mobile/models/artikel_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<ArtikelPageModel>> fetchArtikelPageModel() async {
  var url = Uri.parse('https://kembangin.up.railway.app/artikel/json');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object ArtikelPageModel
  List<ArtikelPageModel> listMyArtikelPageModel = [];
  for (var d in data) {
    if (d != null) {
      listMyArtikelPageModel.add(ArtikelPageModel.fromJson(d));
    }
  }

  return listMyArtikelPageModel;
}
