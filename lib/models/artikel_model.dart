// To parse this JSON data, do
//
//     final myArtikel = myArtikelFromJson(jsonString);

import 'dart:convert';

List<MyArtikel> myArtikelFromJson(String str) =>
    List<MyArtikel>.from(json.decode(str).map((x) => MyArtikel.fromJson(x)));

String myArtikelToJson(List<MyArtikel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyArtikel {
  MyArtikel({
    required this.pk,
    required this.fields,
  });

  int pk;
  Fields fields;

  factory MyArtikel.fromJson(Map<String, dynamic> json) => MyArtikel(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.author,
    required this.title,
    required this.description,
    required this.upvote,
    required this.downvote,
    required this.photo,
  });

  int? author;
  String title;
  String description;
  int upvote;
  int downvote;
  String photo;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        author: json["author"],
        title: json["title"],
        description: json["description"],
        upvote: json["upvote"],
        downvote: json["downvote"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "upvote": upvote,
        "downvote": downvote,
        "photo": photo,
      };
}
