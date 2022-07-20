import 'package:flutter/material.dart';
import 'package:movi/components/partial.dart';

class CreateSuggestionRoom extends StatefulWidget {
  CreateSuggestionRoom({Key? key}) : super(key: key);

  State<CreateSuggestionRoom> createState() => _CreateSuggestionRoomState();
}

class _CreateSuggestionRoomState extends State<CreateSuggestionRoom> {
  int _movieTime = 90;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Center(
                child: GlassNumberSelect(
                    currentValue: _movieTime,
                    callback: (val) => setState(() => _movieTime = val),
                    minVal: 40,
                    stepCount: 10,
                    maxVal: 180),
              )
            ],
          )
        ],
      ),
    );
  }
}
