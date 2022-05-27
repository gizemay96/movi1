import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movi/route_generator.dart';
import 'package:movi/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

class NewWidget extends StatelessWidget {
  final auth;
  const NewWidget({
    required this.auth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.pushNamed(context, '/login-screen');
      } else {
        var response = await db.doc('users/${user.uid}').get();
        var userHasDb = response.exists;

        if (userHasDb) {
          Navigator.pushNamed(context, '/main-app-screen');
        } else {
          Navigator.pushNamed(context, '/create-profile', arguments: user);
        }
      }
    });
    return Container();
  }
}
