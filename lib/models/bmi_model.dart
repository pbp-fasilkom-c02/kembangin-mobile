import 'dart:convert';
// import dart:ffi
import 'dart:ffi';

List<Bmi> BmiFromJson(String str) =>
    List<Bmi>.from(json.decode(str).map((x) => Bmi.fromJson(x)));

String BmiToJson(List<Bmi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bmi {
  Bmi({
    required this.pk,
    required this.fields,
  });

  int pk;
  Fields fields;

  factory Bmi.fromJson(Map<String, dynamic> json) => Bmi(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields(
      {
      // required this.user,
      // required this.date,
      required this.weight,
      required this.height,
      required this.bmi,
      required this.date,
      required this.author});

  int weight;
  int height;
  int bmi;
  DateTime date;
  String author;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        // user: json["user"],
        date: DateTime.parse(json["date"]),
        weight: json["weight"],
        height: json["height"],
        bmi: json["bmi"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        // "user": user,
        // "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "weight": weight,
        "height": height,
        "bmi": bmi,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "author": author,
      };
}
