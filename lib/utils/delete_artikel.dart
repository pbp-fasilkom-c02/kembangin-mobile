import 'package:http/http.dart' as http;

Future<http.Response> deleteArtikel(int id) async {
  var url = "https://kembangin.up.railway.app/artikel/delete-artikel/$id/";

  final http.Response response = await http.delete(
    Uri.parse(url),
  );
  return response;
}
