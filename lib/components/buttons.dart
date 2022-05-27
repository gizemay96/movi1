import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:movi/contants.dart';

class GlassButton extends StatelessWidget {
  final String buttonText;
  final String iconSrc;
  final VoidCallback onPressFunc;

  const GlassButton({
    required this.buttonText,
    required this.iconSrc,
    required this.onPressFunc,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: 400,
      height: 50,
      borderRadius: 15,
      blur: 3,
      alignment: Alignment.center,
      border: 0,
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onTap: onPressFunc,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
              child: iconSrc.length > 1 ? Image.asset(iconSrc) : null,
            ),
            Text(buttonText, style: kPrimaryButtonTextStyle),
          ],
        ),
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
          ]),
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

class PrimaryIconButtonLg extends StatelessWidget {
  final String buttonText;
  final String iconSrc;
  final String iconDirection;
  final VoidCallback onPressFunc;
  const PrimaryIconButtonLg(
      {required this.buttonText,
      required this.iconSrc,
      required this.iconDirection,
      required this.onPressFunc,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightnessK = MediaQuery.of(context).platformBrightness;
    final buttonBackground =
        brightnessK == Brightness.light ? kLightPrimaryColor : kPrimaryColor;
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(height: 50),
      child: ElevatedButton(
        onPressed: onPressFunc,
        style: ElevatedButton.styleFrom(
            primary: buttonBackground,
            onPrimary: Colors.white70,
            textStyle: kPrimaryButtonTextStyle,
            minimumSize: const Size.fromHeight(1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
              child: iconSrc.length > 1 && iconDirection == 'left'
                  ? Image.asset(iconSrc)
                  : null,
            ),
            Text(buttonText, style: kPrimaryButtonTextStyle),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: iconSrc.length > 1 && iconDirection == 'right'
                  ? Image.asset(iconSrc)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryIconButtonMd extends StatelessWidget {
  final String buttonText;
  final String iconSrc;
  final String iconDirection;
  final VoidCallback onPressFunc;
  const PrimaryIconButtonMd(
      {required this.buttonText,
      required this.iconSrc,
      required this.iconDirection,
      required this.onPressFunc,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightnessK = MediaQuery.of(context).platformBrightness;
    final buttonBackground =
        brightnessK == Brightness.light ? kLightPrimaryColor : kPrimaryColor;

    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: onPressFunc,
        style: ElevatedButton.styleFrom(
            primary: buttonBackground,
            onPrimary: Colors.white70,
            textStyle: kPrimaryButtonTextStyle,
            minimumSize: const Size(100, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 00, 0),
              child: iconSrc.length > 1 && iconDirection == 'left'
                  ? Image.asset(iconSrc)
                  : null,
            ),
            Text(buttonText, style: kPrimaryButtonTextStyle),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: iconSrc.length > 1 && iconDirection == 'right'
                  ? Image.asset(iconSrc)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
