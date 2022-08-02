import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:movi/models/suggestionRoom_model.dart';
import 'package:movi/utils/contants.dart';

class AdviceCard extends StatefulWidget {
  final SuggestionRoom advice;
  const AdviceCard({required this.advice, Key? key}) : super(key: key);

  @override
  State<AdviceCard> createState() => _AdviceCardState();
}

class _AdviceCardState extends State<AdviceCard> {
  late String durationP = "0";

  @override
  void setState(fn) {

    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  // ignore: must_call_super
  void initState() {
    getPublishedTime();
    Timer.periodic(const Duration(minutes: 1), (Timer t) => getPublishedTime());
  }

  void getPublishedTime() {
    final duration =
        DateTime.now().difference(widget.advice.publishedDate.toDate());
    final minutes = duration.inMinutes.remainder(60);
    final hours = duration.inHours;
    late String value;
    if (hours > 0) {
      value = "${hours.toString()} sa önce";
    } else {
      value = "${minutes.toString()} dk önce";
    }
    setState(() {
      durationP = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: 300,
      height: 130,
      borderRadius: 10,
      border: 0,
      blur: 8,
      constraints: const BoxConstraints(maxHeight: 130),
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
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 3),
                          child: Image.asset(
                              widget.advice.userInfo.avatarUrl),
                        ),
                        Image.asset('assets/question_icon.png'),
                      ],
                    )
                  ],
                )),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          widget.advice.userInfo.nickname.toString(),
                          style: kTextStyle,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: AutoSizeText(
                                  widget.advice.roomSuggestion.name
                                      .toString(),
                                  style: kTextStyle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    AutoSizeText(
                                      "${widget.advice.movieTime} dk ",
                                      style: kTextStyle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Icon(
                                      Icons.alarm,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AutoSizeText(
                      widget.advice.description.toString(),
                      style: kTextStyle.copyWith(fontSize: 13),
                      maxLines: 3,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AutoSizeText(
                        durationP,
                        style: kTextStyle.copyWith(fontSize: 12),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
