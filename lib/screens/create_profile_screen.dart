import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:movi/components/buttons.dart';
import 'package:movi/components/partial.dart';
import 'package:movi/utils/contants.dart';
import 'package:movi/data/avatar_list.dart';
import 'package:movi/models/user_model.dart';
import 'package:movi/store/user_manager.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  final userHeaderInfo;
  const CreateProfileScreen({required this.userHeaderInfo, Key? key})
      : super(key: key);

  @override
  ConsumerState<CreateProfileScreen> createState() =>
      _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  int _userAge = 19;
  String _selectedAvatar = 'assets/avatars/avatar1.png';
  String _nickName = '';
  final _userForm = GlobalKey<FormState>();

  late List avatarImageList;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    avatarImageList = Strings.AVATAR_LIST;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      defaultPadding: true,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Page Header Text
            const Flexible(
              flex: 1,
              child: Text(
                'Create your profile',
                style: kHeaderTextStyle,
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(
                widget.userHeaderInfo.email,
                style: kTextStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Profile Img
            Flexible(
              flex: 2,
              child: Image.asset(
                _selectedAvatar,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _userForm,
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                    maxLength: 15,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))), // y
                        hintStyle: kLabelTextStyle,
                        hintText: 'Enter your nickname'),
                    onSaved: (value) {
                      setState(() {
                        _nickName = value!;
                      });
                    })),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Age :',
                    style: kTextStyleMd,
                  ),
                  GlassNumberSelect(
                      currentValue: _userAge,
                      callback: (val) => setState(() => _userAge = val)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select an avatar :',
                style: kTextStyle,
              ),
            ),
            GlassmorphicContainer(
              width: 400,
              height: 300,
              borderRadius: 15,
              blur: 4,
              alignment: Alignment.center,
              border: 0,
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
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: AvatarList(
                  avatarImageList: avatarImageList,
                  getSelectedAvatar: (val) =>
                      setState(() => _selectedAvatar = val),
                ),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: PrimaryIconButtonMd(
                  buttonText: 'Continue',
                  iconSrc: 'assets/right_arrow.png',
                  iconDirection: 'right',
                  onPressFunc: createUser,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createUser() async {
    _userForm.currentState?.save();
    var newUser = {
      'userId': widget.userHeaderInfo.uid,
      'nickname': _nickName,
      'avatarUrl': _selectedAvatar.toString(),
      'age': _userAge.toString(),
      'email': widget.userHeaderInfo.email.toString(),
      'mtSuggestion': '0',
      'mtSuggestionRoom': '0',
      'score': '0'
    };
    await db.doc('users/${widget.userHeaderInfo.uid}').set(newUser);
    ref.read(userNotifierProvider.notifier).setUser(UserCust(
        userId: newUser['userId'],
        nickname: newUser['nickname'],
        avatarUrl: newUser['avatarUrl'],
        age: newUser['age'],
        email: newUser['email'],
        mtSuggestion: newUser['mtSuggestion'],
        mtSuggestionRoom: newUser['mtSuggestionRoom'],
        score: newUser['score']));
    Navigator.pushNamed(context, '/main-app-screen');
  }
}

class AvatarList extends StatefulWidget {
  final Function getSelectedAvatar;
  const AvatarList({
    Key? key,
    required this.avatarImageList,
    required this.getSelectedAvatar,
  }) : super(key: key);

  final List avatarImageList;

  @override
  State<AvatarList> createState() => _AvatarListState();
}

class _AvatarListState extends State<AvatarList> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(widget.avatarImageList.length, (index) {
        return Center(
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(70),
            ),
            onTap: () =>
                widget.getSelectedAvatar(widget.avatarImageList[index]),
            child: Image.asset(
              widget.avatarImageList[index],
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }
}
