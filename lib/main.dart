import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movi/models/user_model.dart';
import 'package:movi/store/user_manager.dart';
import 'package:movi/utils/route_generator.dart';
import 'package:movi/utils/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'utils/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    FlutterError.onError = (details) {
    print(details.exception);  // the uncaught exception
    print(details.stack) ; // the stack trace at the time
  };
  runApp(const ProviderScope(child: MyApp()));
}

FirebaseFirestore db = FirebaseFirestore.instance;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FirebaseAuth auth;


  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: NewWidget(
        auth: auth,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.routeGenerator,
    );
  }
}

class NewWidget extends ConsumerWidget {
  final auth;
  const NewWidget({
    required this.auth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.pushNamed(context, '/login-screen');
      } else {
        // var response = await db.doc('users/${user.uid}').get();
        final response = await db.collection('users').doc(user.uid).get();
        var userHasDb = response.exists;
        final userInfo = response.data();

        // debugPrint('-------------' + userInfo.toString());
        if (userHasDb) {
          ref.read(userNotifierProvider.notifier).setUser(UserCust(
              userId: userInfo!['userId'],
              nickname: userInfo['nickname'],
              avatarUrl: userInfo['avatarUrl'],
              age: userInfo['age'],
              email: userInfo['email'],
              mtSuggestion: userInfo['mtSuggestion'],
              mtSuggestionRoom: userInfo['mtSuggestionRoom'],
              score: userInfo['score']));

          Navigator.pushNamed(context, '/main-app-screen');
        } else {
          Navigator.pushNamed(context, '/create-profile', arguments: user);
        }
      }
    });
    return Container();
  }
}
