import 'package:movi/models/user_model.dart';
import 'package:riverpod/riverpod.dart';

final userNotifierProvider =
    StateNotifierProvider<UserManager, UserCust>((ref) {
  return UserManager();
});

// ignore: empty_constructor_bodies
class UserManager extends StateNotifier<UserCust> {
  UserManager()
      : super(UserCust(
            userId: '',
            nickname: '',
            avatarUrl: '',
            age: '',
            email: '',
            mtSuggestion: '',
            mtSuggestionRoom: '',
            score: ''));

  void setUser(UserCust userInfo) {
    state = UserCust(
        userId: userInfo.userId,
        nickname: userInfo.nickname,
        avatarUrl: userInfo.avatarUrl,
        age: userInfo.age,
        email: userInfo.email,
        mtSuggestion: userInfo.mtSuggestion,
        mtSuggestionRoom: userInfo.mtSuggestionRoom,
        score: userInfo.score);
  }

  getUser(){
    return state;
  }
}
