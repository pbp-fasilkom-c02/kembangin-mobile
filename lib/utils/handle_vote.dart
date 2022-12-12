import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> handleVote(int id, String vote) async {
  var url = "https://kembangin.up.railway.app/forum/$id/vote-flutter/$vote";

  final http.Response response = await http.put(
    Uri.parse(url),
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  return data;
}
