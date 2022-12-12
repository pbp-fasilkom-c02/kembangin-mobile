import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kembangin_mobile/models/report_model.dart';

Future<List<Report>> fetchReport(String username) async {
  var url = Uri.parse(
      'https://kembangin.up.railway.app/report-progress/json/$username');
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

  List<Report> listReport = [];
  for (var d in data) {
    if (d != null) {
      listReport.add(Report.fromJson(d));
    }
  }
  return listReport;
}
