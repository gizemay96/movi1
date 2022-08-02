import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:movi/utils/contants.dart';

class GlassMContainer extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;
  final String bgcolor;

  const GlassMContainer({Key? key, 
  required this.width, 
  required this.height, 
  required this.child, 
  required this.bgcolor
  }) : super(key: key);

  @override
  State<GlassMContainer> createState() => _GlassMContainerState();
}

class _GlassMContainerState extends State<GlassMContainer> {
  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
    width:  widget.width, 
    height: widget.height, 
    child: widget.child,
    alignment: Alignment.center,
    constraints: const BoxConstraints(maxHeight: 30),
    borderRadius: 30,
    border: 0, 
    blur: 4, 
     linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          widget.bgcolor == 'red' ? 
          kRedColor.withOpacity(0.8)
          : const Color(0xFFffffff).withOpacity(0.1),

           widget.bgcolor == 'red' ? 
            kRedColor.withOpacity(0.3) :
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
      ), );
  }
}