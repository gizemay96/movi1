// To parse this JSON data, do
//
//     final adviceChatItem = adviceChatItemFromMap(jsonString);
import 'dart:convert';

AdviceChatItem adviceChatItemFromMap(String str) =>
    AdviceChatItem.fromMap(json.decode(str));

String adviceChatItemToMap(AdviceChatItem data) => json.encode(data.toMap());

class AdviceChatItem {
  AdviceChatItem({
    required this.idUser,
    required this.nickname,
    required this.adviceKind,
    required this.description,
    required this.avatarUrl,
    required this.publishedDate,
    required this.likeCount,
    required this.movieName,
  });

  final int idUser;
  final String nickname;
  final String adviceKind;
  final String description;
  final String avatarUrl;
  final String publishedDate;
  final int likeCount;
  final String movieName;

  factory AdviceChatItem.fromMap(Map<String, dynamic> json) => AdviceChatItem(
        idUser: json["idUser"],
        nickname: json["nickname"],
        adviceKind: json["adviceKind"],
        description: json["description"],
        avatarUrl: json["avatarUrl"],
        publishedDate: json["publishedDate"],
        likeCount: json["likeCount"],
        movieName: json["movieName"],
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
      };
}
