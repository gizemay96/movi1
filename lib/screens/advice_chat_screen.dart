import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:movi/components/buttons.dart';
import 'package:movi/components/partial.dart';
import 'package:movi/utils/contants.dart';
import 'package:movi/models/advice_model.dart';

class AdviceChatScreen extends StatefulWidget {
  final Advice selectedAdvice;

  const AdviceChatScreen({required this.selectedAdvice, Key? key})
      : super(key: key);

  @override
  State<AdviceChatScreen> createState() => _AdviceChatScreenState();
}

class _AdviceChatScreenState extends State<AdviceChatScreen> {
  late List chatList = widget.selectedAdvice.chats;
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
                  widget.selectedAdvice.nickname + ' Öneri Bekliyor',
                  style: kTextStyleMd.copyWith(fontSize: 25),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: const Color(0xff1A1A1A),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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

  final Chat chatItem;

  @override
  Widget build(BuildContext context) {
    return chatItem.isChatOwner
        ? OwnerMessage(chatItem: chatItem)
        : SuggestedMessage(chatItem: chatItem);
  }
}

class SuggestedMessage extends StatelessWidget {
  const SuggestedMessage({
    Key? key,
    required this.chatItem,
  }) : super(key: key);

  final Chat chatItem;

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
                        child: Container(
                            child: Image.asset(
                          'assets/movie_icon1.png',
                          fit: BoxFit.cover,
                          height: 95,
                          width: 65,
                        )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '"' + chatItem.movieName + '"',
                                  style: kTextStyleMd,
                                  maxLines: 1,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  chatItem.avatarUrl,
                                  width: 50,
                                ),
                                Text(
                                  chatItem.nickname + ' ' + 'Önerdi',
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
                        constraints: const BoxConstraints( maxHeight: 50, minHeight: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                        child:  Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              chatItem.description,
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
          Container(
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
                        chatItem.likeCount.toString(),
                        style: kTextStyleMd,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    chatItem.publishedDate + '  önce',
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

class OwnerMessage extends StatelessWidget {
  const OwnerMessage({
    Key? key,
    required this.chatItem,
  }) : super(key: key);

  final Chat chatItem;

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
                  chatItem.avatarUrl,
                  width: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  chatItem.nickname,
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
                  chatItem.description,
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
