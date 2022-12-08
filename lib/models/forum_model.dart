// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

import 'dart:convert';

List<Forum> forumFromJson(String str) =>
    List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

String forumToJson(List<Forum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
  Forum({
    required this.question,
    required this.author,
    required this.description,
    required this.createdAt,
    required this.isDoctor,
    required this.pk,
    required this.upvote,
    required this.downvote,
    required this.authorPk,
  });

  String question;
  String author;
  String description;
  String createdAt;
  bool isDoctor;
  int pk;
  int upvote;
  int downvote;
  int authorPk;

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        question: json["question"],
        author: json["author"],
        description: json["description"],
        createdAt: json["created_at"],
        isDoctor: json["is_doctor"],
        pk: json["pk"],
        upvote: json["upvote"],
        downvote: json["downvote"],
        authorPk: json["author_pk"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "author": author,
        "description": description,
        "created_at": createdAt,
        "is_doctor": isDoctor,
        "pk": pk,
        "upvote": upvote,
        "downvote": downvote,
        "author_pk": authorPk,
      };
}
