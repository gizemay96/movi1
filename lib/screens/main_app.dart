import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:movi/utils/contants.dart';
import 'package:movi/screens/home_screen.dart';
import 'package:movi/screens/profile_screen.dart';

class MainAppScreen extends StatefulWidget {
  MainAppScreen({Key? key}) : super(key: key);

  static const kLightThemecolors = [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 248, 71, 71),
    Color.fromARGB(255, 0, 0, 0),
  ];
  static const kDarkThemecolors = [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 122, 122, 122),
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 0),
  ];

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  @override
  Widget build(BuildContext context) {
    return const MainWidget();
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Brightness brightnessK = MediaQuery.of(context).platformBrightness;

    final colorsTheme = brightnessK == Brightness.light
        ? MainAppScreen.kLightThemecolors
        : MainAppScreen.kDarkThemecolors;

    Size size = MediaQuery.of(context).size;

    final screens = [
      HomeScreen(),
      const Center(),
      const Center(),
      const Center(),
      const ProfileScreen()
    ];

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/bg_pattern.png'),
              fit: BoxFit.cover,
              opacity: 0.5),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: colorsTheme)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: SafeArea(child: screens[currentIndex]),
        ),
        bottomNavigationBar:
            [0, 1, 2, 3, 4].contains(currentIndex) ? NavigationBar(size) : null,
      ),
    );
  }

  CurvedNavigationBar NavigationBar(Size size) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Colors.black,
      buttonBackgroundColor: const Color.fromARGB(68, 255, 255, 255),
      height: 50,
      items: const <Widget>[
        Icon(
          Icons.home_rounded,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.comment_rounded,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          TablerIcons.plus,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          TablerIcons.medal,
          size: 30,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ),
      ],
      index: currentIndex,
      onTap: (int index) {
        setState(() {
          Timer(
              const Duration(milliseconds: 600),
              () => setState(() {
                    currentIndex = index;
                  }));
          // Timer(const Duration(milliseconds: 200), () => currentIndex = index);
        });
        //Handle button tap
      },
    );
  }
}
