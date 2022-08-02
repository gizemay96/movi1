import 'dart:convert';

class UserCust {
  final String userId;
  final String nickname;
  final String avatarUrl;
  final String age;
  final String email;
  final String mtSuggestion;
  final String mtSuggestionRoom;
  final String score;
  UserCust({
    required this.userId,
    required this.nickname,
    required this.avatarUrl,
    required this.age,
    required this.email,
    required this.mtSuggestion,
    required this.mtSuggestionRoom,
    required this.score,
  });

  factory UserCust.fromMap(Map<String, dynamic> json) => UserCust(
        userId: json["userId"],
        nickname: json["nickname"],
        avatarUrl: json["avatarUrl"],
        age: json["age"],
        email: json["email"],
        mtSuggestion: json["mtSuggestion"],
        mtSuggestionRoom: json["mtSuggestionRoom"],
        score: json["score"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "nickname": nickname,
        "avatarUrl": avatarUrl,
        "age": age,
        "email": email,
        "mtSuggestion": mtSuggestion,
        "mtSuggestionRoom": mtSuggestionRoom,
        "score": score,
      };
}

class UserShortInfo {
  final String uid;
  final String email;
  UserShortInfo({
    required this.uid,
    required this.email,
  });
}
