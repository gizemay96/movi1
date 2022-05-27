import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movi/components/advice_card.dart';
import 'package:movi/contants.dart';
import 'package:movi/models/advice_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Advice>> _getAdviceList;

  @override
  void initState() {
    super.initState();
    _getAdviceList = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Center(
          child: Text(
            'ANASAYFA',
            style: kTextStyleMd,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Öneri Bekleyenler',
            style: kTextStyle,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 1,
            width: 115,
            decoration: BoxDecoration(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: FutureBuilder<List<Advice>>(
            future: _getAdviceList,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var adviceList = snapshot.data!;
                return ListView.builder(
                    itemCount: adviceList.length,
                    itemBuilder: (context, ind) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: InkWell(
                          child: AdviceCard(
                            advice: adviceList[ind],
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/advice-chat',
                                arguments: adviceList[ind]);
                          },
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: kTextStyle,
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<List<Advice>> getData() async {
    try {
      String okunanStr = await DefaultAssetBundle.of(context)
          .loadString('assets/data/json/advice_list.json');
      var jsonObject = jsonDecode(okunanStr);
      List<Advice> adviceList =
          (jsonObject as List).map((advice) => Advice.fromMap(advice)).toList();

      return adviceList;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
