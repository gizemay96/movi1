import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:movi/components/buttons.dart';
import 'package:movi/components/partial.dart';
import 'package:movi/models/suggestionRoom_model.dart';
import 'package:movi/utils/contants.dart';

class AdviceChatScreen extends StatefulWidget {
  final SuggestionRoom selectedAdvice;
  const AdviceChatScreen({required this.selectedAdvice, Key? key})
      : super(key: key);

  @override
  State<AdviceChatScreen> createState() => _AdviceChatScreenState();
}

class _AdviceChatScreenState extends State<AdviceChatScreen> {
  late List<RoomChats> chatList = widget.selectedAdvice.chats;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      defaultPadding: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Text(
                  widget.selectedAdvice.userInfo.nickname + ' Öneri Bekliyor',
                  style: kTextStyleMd.copyWith(fontSize: 25),
                )
              ],
            ),
          ),
          Expanded(
            flex: 90,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: const Color(0xff1A1A1A),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListView.builder(
                    itemCount: chatList.length,
                    itemBuilder: (context, ind) {
                      return GetChatItem(
                        chatItem: chatList[ind],
                      );
                    }),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: PrimaryIconButtonLg(
              iconSrc: 'assets/advice_icon.png',
              buttonText: 'Film Öner',
              iconDirection: 'right',
              onPressFunc: () {
                Navigator.pushNamed(context, '/create-suggestion',
                    arguments: widget.selectedAdvice);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class GetChatItem extends StatelessWidget {
  const GetChatItem({
    Key? key,
    required this.chatItem,
  }) : super(key: key);

  final RoomChats chatItem;

  @override
  Widget build(BuildContext context) {
    return chatItem.isChatOwner
        ? OwnerMessage(chatItem: chatItem)
        : SuggestedMessage(chatItem: chatItem);
  }
}

class SuggestedMessage extends StatefulWidget {
  const SuggestedMessage({
    Key? key,
    required this.chatItem,
  }) : super(key: key);

  final RoomChats chatItem;

  @override
  State<SuggestedMessage> createState() => _SuggestedMessageState();
}

class _SuggestedMessageState extends State<SuggestedMessage> {
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
        DateTime.now().difference(widget.chatItem.publishedDate.toDate());
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
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 1, 5, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          'assets/movie_icon1.png',
                          fit: BoxFit.cover,
                          height: 95,
                          width: 65,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AutoSizeText(
                                  '"' + widget.chatItem.movieName + '"',
                                  style: kTextStyleMd,
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                  widget.chatItem.avatarUrl,
                                  width: 50,
                                ),
                                Text(
                                  widget.chatItem.nickname + ' ' + 'Önerdi',
                                  style: kTextStyle.copyWith(fontSize: 13),
                                ),
                              ]),
                        ]),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height - 480,
                        constraints:
                            const BoxConstraints(maxHeight: 50, minHeight: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              widget.chatItem.description,
                              style: kTextStyle,
                              maxLines: 3,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      TablerIcons.heart,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Text(
                        widget.chatItem.likeCount.toString(),
                        style: kTextStyleMd,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    durationP.toString(),
                    style: kTextStyle,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class OwnerMessage extends StatefulWidget {
  const OwnerMessage({
    Key? key,
    required this.chatItem,
  }) : super(key: key);

  final RoomChats chatItem;

  @override
  State<OwnerMessage> createState() => _OwnerMessageState();
}

class _OwnerMessageState extends State<OwnerMessage> {
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
        DateTime.now().difference(widget.chatItem.publishedDate.toDate());
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
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Image.asset(
                  widget.chatItem.avatarUrl,
                  width: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.chatItem.nickname,
                  style: kTextStyleMd,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: const BoxConstraints(
                  minWidth: 100, maxWidth: 280, minHeight: 70),
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Center(
                child: Text(
                  widget.chatItem.description,
                  style: kTextStyle,
                  maxLines: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
