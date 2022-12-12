import 'dart:convert';

List<Profile> profileFromJson(String str) =>
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

List<DoctorProfile> doctorProfileFromJson(String str) =>
    List<DoctorProfile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String doctorProfileToJson(DoctorProfile data) => json.encode(data.toJson());

class DoctorProfile {
  DoctorProfile({
    required this.commentAmount,
    required this.ratingAverage,
  });

  int commentAmount;
  double ratingAverage;

  factory DoctorProfile.fromJson(Map<String, dynamic> json) => DoctorProfile(
        commentAmount: json["comment_amount"],
        ratingAverage: json["rating_average"],
      );

  Map<String, dynamic> toJson() => {
        "comment_amount": commentAmount,
        "rating_average": ratingAverage,
      };
}

List<Rating> ratingFromJson(String str) =>
    List<Rating>.from(json.decode(str).map((x) => Rating.fromJson(x)));

String ratingToJson(List<Rating> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rating {
  Rating({
    required this.authorUsername,
    required this.authorIsDoctor,
    required this.authorPk,
    required this.date,
    required this.rating,
    required this.comment,
    required this.id,
  });

  String authorUsername;
  bool authorIsDoctor;
  int authorPk;
  DateTime date;
  int rating;
  String comment;
  int id;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        authorUsername: json["author_username"],
        authorIsDoctor: json["author_is_doctor"],
        authorPk: json["author_pk"],
        date: DateTime.parse(json["date"]),
        rating: json["rating"],
        comment: json["comment"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "author_username": authorUsername,
        "author_is_doctor": authorIsDoctor,
        "author_pk": authorPk,
        "date": date.toIso8601String(),
        "rating": rating,
        "comment": comment,
        "id": id,
      };
}
