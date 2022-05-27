import 'package:flutter/material.dart';
import 'package:movi/components/buttons.dart';
import 'package:movi/components/partial.dart';
import 'package:movi/contants.dart';
import 'package:movi/screens/create_profile_screen.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      defaultPadding: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(
            flex: 2,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Enter your phone',
              style: kLargeHeaderTextStyle,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'We promise that we will not share your \npersonal information with others.',
              style: kTextStyle,
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: const [
              Expanded(
                flex: 1,
                child: TextField(
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      //errorStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintStyle: kLabelTextStyle,
                      hintText: '+90'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      //errorStyle: TextStyle(color: Colors.orange),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      hintStyle: kLabelTextStyle,
                      hintText: 'Phone number'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          PrimaryIconButtonLg(
            iconSrc: 'assets/right_arrow.png',
            buttonText: 'Continue',
            iconDirection: 'right',
            onPressFunc: () {
              Navigator.pushNamed(context, '/create-profile');
            },
          ),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}
