import 'package:flutter/material.dart';
import 'package:movi/components/advice_card.dart';
import 'package:movi/models/suggestionRoom_model.dart';
import 'package:movi/services/api_service.dart';
import 'package:movi/utils/contants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<SuggestionRoom>> sugData;
  @override
  void initState() {
    super.initState();
    sugData = ApiService().getSuggestionRooms();
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
            decoration: const BoxDecoration(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: FutureBuilder<List<SuggestionRoom>>(
            future: sugData,
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
}
