import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:movi/contants.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomScaffold extends StatefulWidget {
  final Widget child;
  final bool defaultPadding;
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

  const CustomScaffold({
    required this.child,
    required this.defaultPadding,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Brightness brightnessK = MediaQuery.of(context).platformBrightness;

    final colorsTheme = brightnessK == Brightness.light
        ? CustomScaffold.kLightThemecolors
        : CustomScaffold.kDarkThemecolors;

    Size size = MediaQuery.of(context).size;

    var currentPage = ModalRoute.of(context)?.settings.name;

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
          padding: EdgeInsets.all(widget.defaultPadding ? kDefaultPadding : 0),
          child: SafeArea(child: widget.child),
        ),
      ),
    );
  }
}

class GlassNumberSelect extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final currentValue;
  final Function callback;
  const GlassNumberSelect(
      {required this.currentValue, required this.callback, Key? key})
      : super(key: key);

  @override
  State<GlassNumberSelect> createState() => _GlassNumberSelectState();
}

class _GlassNumberSelectState extends State<GlassNumberSelect> {
  @override
  Widget build(BuildContext context) {
    Brightness brightnessK = MediaQuery.of(context).platformBrightness;
    final selectedItemBgColor =
        brightnessK == Brightness.light ? kLightPrimaryColor : kPrimaryColor;

    return GlassmorphicContainer(
      height: 50,
      width: 300,
      borderRadius: 20,
      blur: 4,
      alignment: Alignment.center,
      border: 0,
      child: NumberPicker(
        axis: Axis.horizontal,
        step: 1,
        itemCount: 7,
        itemWidth: 44,
        value: widget.currentValue,
        minValue: 15,
        maxValue: 80,
        textStyle: kTextStyle,
        selectedTextStyle: TextStyle(
          color: selectedItemBgColor,
          fontSize: 30,
          fontWeight: FontWeight.w900,
        ),
        onChanged: (value) => widget.callback(value),
      ),
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.1),
          const Color(0xFFFFFFFF).withOpacity(0.05),
        ],
        stops: const [
          0.1,
          1,
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.5),
          const Color((0xFFFFFFFF)).withOpacity(0.5),
        ],
      ),
    );
  }
}
