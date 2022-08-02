import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movi/components/buttons.dart';
import 'package:movi/components/kGlassMorhipchCont.dart';
import 'package:movi/components/partial.dart';
import 'package:movi/models/movie_types_model.dart';
import 'package:movi/models/suggestionRoom_model.dart';
import 'package:movi/models/user_model.dart';
import 'package:movi/services/api_service.dart';
import 'package:movi/store/user_manager.dart';
import 'package:movi/utils/contants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class CreateSuggestionRoom extends ConsumerStatefulWidget {
  final userHeaderInfo = UserManager().getUser();
  CreateSuggestionRoom({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateSuggestionRoom> createState() =>
      _CreateSuggestionRoomState();
}

class _CreateSuggestionRoomState extends ConsumerState<CreateSuggestionRoom> {
  int _movieTime = 90;
  late String adviceText = '';
  late Future<List<MovieTypes>> _getMovieTypeList;
  late List<MovieTypes> selectedTypes = [];
  late bool isError = false;
  @override
  void initState() {
    super.initState();
    _getMovieTypeList = ApiService().getData();
  }

  isSelectedMovieType(movieId) {
    final index = selectedTypes.indexWhere((element) => element.id == movieId);
    return index > -1;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch<UserCust>(userNotifierProvider);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          isError
              ? const CustomSnackBar.error(
                  message: "Lütfen tüm alanları doldur",
                  backgroundColor: kRedColor,
                )
              : Container(),
          Column(
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Maksimum Film Süresi',
                    style: kTextStyle,
                  )),
              Center(
                child: GlassNumberSelect(
                    currentValue: _movieTime,
                    callback: (val) => setState(() => _movieTime = val),
                    minVal: 40,
                    stepCount: 10,
                    maxVal: 180),
              )
            ],
          ),
          Column(
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Kategori',
                    style: kTextStyle,
                  )),
              SizedBox(
                height: 200,
                child: FutureBuilder<List<MovieTypes>>(
                  future: _getMovieTypeList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var movieTypess = snapshot.data!;
                      return GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 2.5,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 20,
                          children: List.generate(
                            movieTypess.length,
                            (index) {
                              return InkWell(
                                onTap: () => {
                                  setState(() {
                                    var movieId = movieTypess[index].id;
                                    if (isSelectedMovieType(movieId)) {
                                      selectedTypes.removeWhere(
                                          (item) => item.id == movieId);
                                    } else if (selectedTypes.length > 0) {
                                      selectedTypes[0] = movieTypess[index];
                                    } else {
                                      selectedTypes.add(movieTypess[index]);
                                    }
                                  })
                                },
                                child: GlassMContainer(
                                    bgcolor: isSelectedMovieType(
                                            movieTypess[index].id)
                                        ? 'red'
                                        : 'white',
                                    width: 30,
                                    height: 20,
                                    child: Text(
                                      "# " + movieTypess[index].name.toString(),
                                      style: kTextStyle,
                                    )),
                              );
                            },
                          ));
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
          ),
          Column(
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Nasıl bi’ film istediğini yaz',
                    style: kTextStyle,
                  )),
              const SizedBox(
                height: 15,
              ),
              TextField(
                maxLength: 40,
                maxLines: 2,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  helperStyle: kTextStyle,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(15.0))), // y
                  hintStyle: kLabelTextStyle,
                ),
                onChanged: (value) {
                  setState(() {
                    adviceText = value;
                  });
                },
              ),
            ],
          ),
          PrimaryIconButtonLg(
            iconSrc: 'assets/right_arrow.png',
            buttonText: 'Film Odası Oluştur',
            iconDirection: 'right',
            onPressFunc: () {
              createRoom(user);
            },
          ),
        ],
      ),
    );
  }

  createRoom(user) {
    if (selectedTypes.isEmpty || adviceText.length < 1) {
      debugPrint("error");
      setState(() {
        isError = true;
      });
    } else {
      var request = SuggestionRoom(
          chats: [],
          description: adviceText,
          publishedDate: Timestamp.fromDate(DateTime.now()),
          roomId: '',
          movieTime: _movieTime,
          roomSuggestion: MovieTypes(
              icon: selectedTypes[0].icon,
              id: selectedTypes[0].id,
              name: selectedTypes[0].name),
          userInfo: UserInfo(
              userId: user.userId,
              avatarUrl: user.avatarUrl,
              nickname: user.nickname));

      ApiService().createSuggestionRoom(request.toMap());
    }
  }
}
