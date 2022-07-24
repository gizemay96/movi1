import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movi/utils/contants.dart';
import 'package:movi/store/user_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    auth = FirebaseAuth.instance;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: UserInfos(
        auth: auth,
      ),
    );
  }
}

// ignore: must_be_immutable
class UserInfos extends ConsumerWidget {
  FirebaseAuth auth;
  UserInfos({
    required this.auth,
    Key? key,
  }) : super(key: key);

  void signOutUser() async {
    var _user = GoogleSignIn().currentUser;
    if (_user != null) {
      await GoogleSignIn().signOut();
    }
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userNotifierProvider);
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Text(
        'Profil',
        style: kTextStyleMd,
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 150,
        child: Stack(
          children: [
            Align(
              child: Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                    color: const Color(0xff626262),
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
            Align(
              child: Image.asset(
                user.avatarUrl,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
      const SizedBox(height: 20),
      Text(
        user.nickname,
        style: kTextStyleMd,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: AutoSizeText(
              user.email,
              style: kTextStyleMd,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                  padding: const EdgeInsets.only(left: 4),
                  onPressed: () {
                    signOutUser();
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 20,
                  )))
        ],
      ),
      const Spacer(),
      ProfileInfoCard(
        title: 'Yorum Sayısı :',
        value: user.mtSuggestion,
      ),
      ProfileInfoCard(
        title: 'Entry :',
        value: user.mtSuggestionRoom,
      ),
      ProfileInfoCard(
        title: 'Puan :',
        value: user.score,
      ),
      const Spacer(),
    ]);
  }
}

class ProfileInfoCard extends StatelessWidget {
  final title;
  final value;
  const ProfileInfoCard({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Stack(
          children: [
            GlassmorphicContainer(
              height: 50,
              width: MediaQuery.of(context).size.width,
              borderRadius: 20,
              blur: 4,
              alignment: Alignment.center,
              border: 0,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width - 270),
                child: Text(
                  value.toString(),
                  style: kTextStyleMd,
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
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 200,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Text(
                  title.toString(),
                  style: kTextStyleMd,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
