class User {
  final String userId;
  final String nickname;
  final String avatarUrl;
  final String age;
  final String email;
  final String mtSuggestion;
  final String mtSuggestionRoom;
  final String score;
  User({
    required this.userId,
    required this.nickname,
    required this.avatarUrl,
    required this.age,
    required this.email,
    required this.mtSuggestion,
    required this.mtSuggestionRoom,
    required this.score,
  });
}

class UserShortInfo {
  final String uid;
  final String email;
  UserShortInfo({
    required this.uid,
    required this.email,
  });
}
