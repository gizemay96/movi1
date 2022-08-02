import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:movi/models/advice_model.dart';
import 'package:movi/models/suggestionRoom_model.dart';
import 'package:movi/screens/advice_chat_screen.dart';
import 'package:movi/screens/create_profile_screen.dart';
import 'package:movi/screens/create_suggestion.dart';
import 'package:movi/screens/create_suggestion_room.dart';
import 'package:movi/screens/home_screen.dart';
import 'package:movi/screens/login_screen.dart';
import 'package:movi/screens/login_with_phone.dart';
import 'package:movi/screens/main_app.dart';

class RouteGenerator {
  static Route<dynamic>? _createRoute(Widget route, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
          settings: settings, builder: (context) => route);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(settings: settings, builder: (context) => route);
    } else {
      return CupertinoPageRoute(
          settings: settings, builder: (context) => route);
    }
  }

  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _createRoute(const LoginScreen(), settings);

      case '/home':
        return _createRoute(HomeScreen(), settings);

      case '/login-screen':
        return _createRoute(const LoginScreen(), settings);

      case '/main-app-screen':
        return _createRoute(MainAppScreen(), settings);

      case '/login-phone':
        return _createRoute(const LoginWithPhoneScreen(), settings);

      case '/create-profile':
        var userHeaderInfo = settings.arguments;
        return _createRoute(
            CreateProfileScreen(userHeaderInfo: userHeaderInfo), settings);

      case '/advice-chat':
        var selectedAdvice = settings.arguments as SuggestionRoom;
        return _createRoute(
            AdviceChatScreen(
              selectedAdvice: selectedAdvice,
            ),
            settings);

      case '/create-suggestion':
        var selectedChatScreenForSuggestion = settings.arguments as SuggestionRoom;
        return _createRoute(
            CreateSuggestionScreen(
              selectedChatScreenForSuggestion: selectedChatScreenForSuggestion,
            ),
            settings);

      case '/create-suggets-room':
        return _createRoute(CreateSuggestionRoom(), settings);

      default:
        return MaterialPageRoute(
            builder: (context) => const Center(
                  child: Text('Page is not found !'),
                ));
    }
  }
}
