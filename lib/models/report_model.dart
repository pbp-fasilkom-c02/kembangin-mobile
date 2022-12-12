// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

import 'dart:convert';

List<Report> reportFromJson(String str) =>
    List<Report>.from(json.decode(str).map((x) => Report.fromJson(x)));

String reportToJson(List<Report> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Report {
  Report({
    required this.pk,
    required this.date,
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.eat,
    required this.drink,
    required this.progress,
  });

  int pk;
  DateTime date;
  String name;
  String age;
  String height;
  String weight;
  String eat;
  String drink;
  String progress;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        pk: json["pk"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        age: json["age"],
        height: json["height"],
        weight: json["weight"],
        eat: json["eat"],
        drink: json["drink"],
        progress: json["progress"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "name": name,
        "age": age,
        "height": height,
        "weight": weight,
        "eat": eat,
        "drink": drink,
        "progress": progress,
      };
}
