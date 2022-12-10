import 'package:http/http.dart' as http;

Future<String> deleteForum(int id, String username) async {
  final url = Uri.parse(
      "https://kembangin.up.railway.app/forum/delete-forum/$id/$username");
  final request = http.Request("DELETE", url);

  final response = await request.send();

  if (response.statusCode != 200) {
    return Future.error("error: status code ${response.statusCode}");
  }

  return await response.stream.bytesToString();
}
