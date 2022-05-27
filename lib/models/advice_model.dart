// To parse this JSON data, do
//
//     final advice = adviceFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Advice adviceFromMap(String str) => Advice.fromMap(json.decode(str));

String adviceToMap(Advice data) => json.encode(data.toMap());

class Advice {
  Advice({
    required this.id,
    required this.nickname,
    required this.adviceKind,
    required this.description,
    required this.avatarUrl,
    required this.publishedDate,
    required this.chats,
  });

  final int id;
  final String nickname;
  final String adviceKind;
  final String description;
  final String avatarUrl;
  final String publishedDate;
  final List<Chat> chats;

  factory Advice.fromMap(Map<String, dynamic> json) => Advice(
        id: json["id"],
        nickname: json["nickname"],
        adviceKind: json["adviceKind"],
        description: json["description"],
        avatarUrl: json["avatarUrl"],
        publishedDate: json["publishedDate"],
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nickname": nickname,
        "adviceKind": adviceKind,
        "description": description,
        "avatarUrl": avatarUrl,
        "publishedDate": publishedDate,
        "chats": List<dynamic>.from(chats.map((x) => x.toMap())),
      };
}

class Chat {
  Chat({
    required this.idUser,
    required this.nickname,
    required this.adviceKind,
    required this.description,
    required this.avatarUrl,
    required this.publishedDate,
    required this.likeCount,
    required this.movieName,
    required this.movieTime,
    required this.movieYear,
    required this.isChatOwner,
  });

  final int idUser;
  final String nickname;
  final String adviceKind;
  final String description;
  final String avatarUrl;
  final String publishedDate;
  final int likeCount;
  final String movieName;
  final String movieTime;
  final String movieYear;
  final bool isChatOwner;

  factory Chat.fromMap(Map<String, dynamic> json) => Chat(
        idUser: json["idUser"],
        nickname: json["nickname"],
        adviceKind: json["adviceKind"],
        description: json["description"],
        avatarUrl: json["avatarUrl"],
        publishedDate: json["publishedDate"],
        likeCount: json["likeCount"],
        movieName: json["movieName"],
        movieTime: json["movieTime"],
        movieYear: json["movieYear"],
        isChatOwner: json["isChatOwner"],
      );

  Map<String, dynamic> toMap() => {
        "idUser": idUser,
        "nickname": nickname,
        "adviceKind": adviceKind,
        "description": description,
        "avatarUrl": avatarUrl,
        "publishedDate": publishedDate,
        "likeCount": likeCount,
        "movieName": movieName,
        "movieTime": movieTime,
        "movieYear": movieYear,
        "isChatOwner": isChatOwner,
      };
}
