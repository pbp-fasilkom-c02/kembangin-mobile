import 'package:http/http.dart' as http;

// Future<String> deleteArtikel(int id) async {
//   print("sii");
//   final url =
//       Uri.parse("https://kembangin.up.railway.app/artikel/delete-artikel/$id");
//   print("jsaks");
//   final htt

// }

Future<http.Response> deleteArtikel(int id) async {
  var url = "https://kembangin.up.railway.app/artikel/delete-artikel/$id";
  final http.Response response = await http.delete(
    Uri.parse(url),
  );
  print(" status");
  print(response.statusCode);
  // print(response.body);
  return response;
}
