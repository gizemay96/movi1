import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:movi/components/buttons.dart';
import 'package:movi/components/partial.dart';
import 'package:movi/contants.dart';
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
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
            height: MediaQuery.of(context).size.height - 190,
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
          Padding(
            padding: const EdgeInsets.all(17.0),
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
            width: 300,
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 1, 5, 10),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    chatItem.nickname,
                    style: kTextStyleMd,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    chatItem.avatarUrl,
                    width: 20,
                  )
                ]),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                          child: Image.asset('assets/movie_icon.png')),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              chatItem.movieName,
                              style: kTextStyleMd,
                              maxLines: 1,
                            ),
                          ),
                          Text(
                            chatItem.description,
                            style: kTextStyle,
                            maxLines: 3,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
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
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 280),
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(15)),
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
                Text(
                  chatItem.description,
                  style: kTextStyle.copyWith(fontSize: 13),
                  maxLines: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
