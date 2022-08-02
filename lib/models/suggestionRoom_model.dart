// To parse this JSON data, do
//
//     final suggestionRoom = suggestionRoomFromMap(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:movi/models/movie_types_model.dart';

List<SuggestionRoom> suggestionRoomFromMap(String str) =>
    List<SuggestionRoom>.from(
        json.decode(str).map((x) => SuggestionRoom.fromMap(x)));

String suggestionRoomToMap(List<SuggestionRoom> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SuggestionRoom {
  SuggestionRoom({
    required this.roomId,
    required this.description,
    required this.publishedDate,
    required this.movieTime,
    required this.userInfo,
    required this.roomSuggestion,
    required this.chats,
  });

  late final String roomId;
  final String description;
  final Timestamp publishedDate;
  final int movieTime;
  final UserInfo userInfo;
  final MovieTypes roomSuggestion;
  final List<RoomChats> chats;

  factory SuggestionRoom.fromMap(Map<String, dynamic> json) => SuggestionRoom(
        roomId: json["roomId"],
        description: json["description"],
        publishedDate: json["publishedDate"],
        movieTime: json["movieTime"],
        userInfo: UserInfo.fromMap(json["userInfo"]),
        roomSuggestion: MovieTypes.fromMap(json["roomSuggestion"]),
        chats: List<RoomChats>.from(
            json["chats"].map((x) => RoomChats.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "roomId": roomId,
        "description": description,
        "publishedDate": publishedDate,
        "movieTime": movieTime,
        "userInfo": userInfo.toMap(),
        "roomSuggestion": roomSuggestion.toMap(),
        "chats": List<dynamic>.from(chats.map((x) => x.toMap())),
      };
}

class RoomChats {
  RoomChats({
    required this.userId,
    required this.nickname,
    required this.avatarUrl,
    required this.description,
    required this.isChatOwner,
    required this.likeCount,
    required this.movieName,
    required this.movieYear,
    required this.movieTime,
    required this.publishedDate,
    required this.seggestionKinds,
    required this.roomId,
  });

  final String userId;
  final String nickname;
  final String avatarUrl;
  final String description;
  final bool isChatOwner;
  final int likeCount;
  final String movieName;
  final int movieYear;
  final int movieTime;
  final Timestamp publishedDate;
  final String roomId;
  final List<MovieTypes> seggestionKinds;

  factory RoomChats.fromMap(Map<String, dynamic> json) => RoomChats(
        userId: json["userId"],
        nickname: json["nickname"],
        avatarUrl: json["avatarUrl"],
        description: json["description"],
        isChatOwner: json["isChatOwner"],
        likeCount: json["likeCount"],
        movieName: json["movieName"],
        movieYear: json["movieYear"],
        movieTime: json["movieTime"],
        roomId: json["roomId"],
        publishedDate: json["publishedDate"],
        seggestionKinds: List<MovieTypes>.from(
            json["seggestionKinds"].map((x) => MovieTypes.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "nickname": nickname,
        "avatarUrl": avatarUrl,
        "description": description,
        "isChatOwner": isChatOwner,
        "likeCount": likeCount,
        "movieName": movieName,
        "movieYear": movieYear,
        "movieTime": movieTime,
        "publishedDate": publishedDate,
        "seggestionKinds":
            List<dynamic>.from(seggestionKinds.map((x) => x.toMap())),
      };
}

class RoomSuggestion {
  RoomSuggestion({
    required this.id,
    required this.name,
    required this.icon,
  });

  final int id;
  final String name;
  final String icon;

  factory RoomSuggestion.fromMap(Map<String, dynamic> json) => RoomSuggestion(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}

class UserInfo {
  UserInfo({
    required this.userId,
    required this.nickname,
    required this.avatarUrl,
  });

  final String userId;
  final String nickname;
  final String avatarUrl;

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        userId: json["userId"],
        nickname: json["nickname"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "nickname": nickname,
        "avatarUrl": avatarUrl,
      };
}
