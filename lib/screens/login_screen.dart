import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movi/components/buttons.dart';
import 'package:movi/components/partial.dart';
import 'package:movi/utils/contants.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      defaultPadding: true,
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Image.asset(
            'assets/login_logo.png',
            alignment: Alignment.center,
            width: 280,
          ),
          const Spacer(),
          const Text(
            'Welcome',
            style: kXlHeaderTextStyle,
          ),
          const Text(
            'Movie Hunter',
            style: kHeaderTextStyle,
          ),
          const Spacer(),
          PrimaryIconButtonLg(
            iconSrc: 'assets/phone_icon.png',
            buttonText: 'Continue with Phone',
            iconDirection: 'left',
            onPressFunc: () {
              Navigator.pushNamed(context, '/login-phone');
            },
          ),
          const Spacer(),
          GlassButton(
            buttonText: 'Continue with Google',
            iconSrc: 'assets/google_icon.png',
            onPressFunc: () {
              googleIleGiris();
            },
          ),
          const Spacer(),
          GlassButton(
            buttonText: 'Continue with Facebook',
            iconSrc: 'assets/facebook_icon.png',
            onPressFunc: () {
              debugPrint('Facebook');
            },
          ),
          const Spacer(
            flex: 2,
          ),
          // with custom text
        ],
      ),
    );
  }

  void googleIleGiris() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
