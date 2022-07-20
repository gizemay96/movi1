import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:movi/utils/contants.dart';
import 'package:movi/models/advice_model.dart';

class AdviceCard extends StatelessWidget {
  final Advice advice;
  const AdviceCard({required this.advice, Key? key}) : super(key: key);

  getAdvice() {}

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: 300,
      height: 150,
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
        padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      advice.nickname.toString(),
                      style: kTextStyle,
                    ),
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 3),
                          child: Image.asset(advice.avatarUrl),
                        ),
                        Image.asset('assets/question_icon.png'),
                      ],
                    )
                  ],
                )),
            Container(
              width: 1,
              height: 54,
              decoration: const BoxDecoration(color: Colors.white),
            ),
            const SizedBox(
              width: 4,
            ),
            Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Tür:  ',
                          style: kTextStyle,
                          maxLines: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            advice.adviceKind.toString(),
                            style: kTextStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      advice.description.toString(),
                      style: kTextStyle.copyWith(fontSize: 13),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        advice.publishedDate + ' ago',
                        style: kTextStyle.copyWith(fontSize: 12),
                      ),
                    ),
                    const Spacer()
                  ],
                )),
            const Flexible(
              child: SizedBox(
                width: 40,
                child: Icon(
                  Icons.arrow_circle_right,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
