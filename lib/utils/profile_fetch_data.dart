import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kembangin_mobile/models/profile_model.dart';

Future<List<Profile>> fetchNormalProfile(int id) async {
  var url = Uri.parse('https://kembangin.up.railway.app/user_profile/get_normal_user/$id');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );
  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<Profile> listProfile = [];

  for (var d in data) {
    if (d != null) {
      listProfile.add(Profile.fromJson(d));
    }
  }
  return listProfile;
}