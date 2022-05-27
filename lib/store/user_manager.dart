import 'package:movi/models/user_model.dart';
import 'package:riverpod/riverpod.dart';

final userNotifierProvider = StateNotifierProvider<UserManager, User>((ref) {
  return UserManager();
});

// ignore: empty_constructor_bodies
class UserManager extends StateNotifier<User> {
  UserManager()
      : super(User(
            userId: '0',
            nickname: 'dasdasd',
            avatarUrl: '',
            age: '',
            email: '',
            mtSuggestion: '',
            mtSuggestionRoom: '',
            score: ''));

  void setUser(User userInfo) {
    state = User(
        userId: userInfo.userId,
        nickname: userInfo.nickname,
        avatarUrl: userInfo.avatarUrl,
        age: userInfo.age,
        email: userInfo.email,
        mtSuggestion: userInfo.mtSuggestion,
        mtSuggestionRoom: userInfo.mtSuggestionRoom,
        score: userInfo.score);
  }
}
