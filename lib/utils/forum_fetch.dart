import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kembangin_mobile/models/forum_model.dart';

Future<List<Forum>> fetchForum() async {
  var url = Uri.parse('https://kembangin.up.railway.app/forum/json');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

// check dimana
  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object ToDo
  List<Forum> listForum = [];
  // print(data);
  for (var d in data) {
    if (d != null) {
      listForum.add(Forum.fromJson(d));
    }
  }
  // print(listForum);
  return listForum;
}
