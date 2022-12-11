// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> forumFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.userId,
    required this.username,
    required this.email,
    required this.postAmount,
    required this.isDoctor,
    required this.bio,
    required this.upvoteAmount,
    required this.isLoggedUser,
  });

  int userId;
  String username;
  String email;
  int postAmount;
  bool isDoctor;
  String bio;
  int upvoteAmount;
  bool isLoggedUser;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        userId: json["user_id"],
        username: json["username"],
        email: json["email"],
        postAmount: json["post_amount"],
        isDoctor: json["is_doctor"],
        bio: json["bio"],
        upvoteAmount: json["upvote_amount"],
        isLoggedUser: json["is_logged_user"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "email": email,
        "post_amount": postAmount,
        "is_doctor": isDoctor,
        "bio": bio,
        "upvote_amount": upvoteAmount,
        "is_logged_user": isLoggedUser,
      };
}
