import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kembangin_mobile/models/artikel_model.dart';

Future<List<MyArtikel>> fetchMyArtikel() async {
  var url = Uri.parse('https://kembangin.herokuapp.com/artikel/json/');

  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<MyArtikel> listMyArtikel = [];
  for (var d in data) {
    if (d != null) {
      listMyArtikel.add(MyArtikel.fromJson(d));
    }
  }

  return listMyArtikel;
}
