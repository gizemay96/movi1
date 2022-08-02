// ignore_for_file: avoid_print

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
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
import 'package:movi/models/movie_model.dart';

class CreateSuggestionScreen extends ConsumerStatefulWidget {
  final SuggestionRoom selectedChatScreenForSuggestion;
  const CreateSuggestionScreen(
      {required this.selectedChatScreenForSuggestion, Key? key})
      : super(key: key);

  @override
  ConsumerState<CreateSuggestionScreen> createState() =>
      _CreateSuggestionScreenState();
}

class _CreateSuggestionScreenState
    extends ConsumerState<CreateSuggestionScreen> {
  late bool searchActive = false;
  late bool hasSelectedMovie = false;
  late String searchValue = '';
  late Movie selectedMovie;
  final TextEditingController _textController = new TextEditingController();
  late int movieRate = 5;
  late String adviceText = '';

  Future<List<Movie>> _getMovies() async {
    return await ApiService().getMovieSearchResponse(searchValue);
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch<UserCust>(userNotifierProvider);
    _getMovies();
    return CustomScaffold(
      defaultPadding: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                AutoSizeText(
                  'Haydi ' +
                      widget.selectedChatScreenForSuggestion.userInfo.nickname +
                      ' için öneri yap',
                  style: kTextStyleMd,
                )
              ],
            ),
          ),
          Expanded(
            flex: 90,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xff1A1A1A),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 200,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: AutoSizeText(
                          'Film Adı',
                          style: kTextStyle,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _textController,
                      readOnly: hasSelectedMovie && !searchActive,
                      maxLength: 15,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.transparent)),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))), // y
                        hintStyle: kLabelTextStyle,
                        hintText:
                            hasSelectedMovie ? selectedMovie.title : 'Film Ara',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              searchActive = false;
                            });
                          },
                          icon: searchActive
                              ? const Icon(Icons.close)
                              : const Icon(Icons.search),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchValue = value;
                          debugPrint(searchValue);
                        });
                      },
                      onTap: () => {
                        setState(() {
                          searchActive = true;
                        })
                      },
                    ),
                    Flexible(
                      flex: 1,
                      child: FutureBuilder<List<Movie>>(
                        future: _getMovies(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<Movie> movieList = snapshot.data!;
                            return ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10)),
                                child: searchActive
                                    ? ListView.builder(
                                        itemCount: movieList.length,
                                        itemBuilder: (context, ind) {
                                          // ignore: unnecessary_null_comparison
                                          var movieImgPath = movieList[ind]
                                                      .posterPath ==
                                                  'null'
                                              ? 'https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie.jpg'
                                              : 'https://image.tmdb.org/t/p/w94_and_h141_bestv2${movieList[ind].posterPath}';
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 15),
                                            child: InkWell(
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.network(
                                                      movieImgPath,
                                                      width: 110,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AutoSizeText(
                                                          movieList[ind]
                                                              .originalTitle,
                                                          style: kTextStyle,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        AutoSizeText(
                                                          formatDate(
                                                              movieList[ind]
                                                                  .releaseDate,
                                                              [
                                                                dd,
                                                                ' ',
                                                                M,
                                                                ' ',
                                                                yyyy
                                                              ]).toString(),
                                                          style: kTextStyle,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        AutoSizeText(
                                                          movieList[ind]
                                                              .voteAverage
                                                              .toString(),
                                                          style: kTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedMovie = movieList[ind];
                                                  searchActive = false;
                                                  _textController.clear();
                                                  hasSelectedMovie = true;
                                                });
                                              },
                                            ),
                                          );
                                        })
                                    : SuggestionForm(
                                        movieRate: movieRate,
                                        adviceText: adviceText,
                                      ));
                          } else if (snapshot.hasError) {
                            return Center(
                              child: AutoSizeText(
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
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: PrimaryIconButtonLg(
              iconSrc: 'assets/right_arrow.png',
              buttonText: 'Gönder',
              iconDirection: 'right',
              onPressFunc: () {
                createRoom(user, selectedMovie, adviceText, movieRate , widget.selectedChatScreenForSuggestion);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SuggestionForm extends StatefulWidget {
  late int movieRate;
  late String adviceText;
  SuggestionForm({required this.movieRate, required this.adviceText, Key? key})
      : super(key: key);

  @override
  State<SuggestionForm> createState() => _SuggestionFormState();
}

class _SuggestionFormState extends State<SuggestionForm> {
  late Future<List<MovieTypes>> _getMovieTypeList;
  late List<MovieTypes> selectedTypes = [];

  void _onChanged(dynamic val) => debugPrint(val.toString());

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Align(
                alignment: Alignment.topLeft,
                child: AutoSizeText(
                  'Bu filme senin puanın nedir?',
                  style: kTextStyle,
                )),
            const SizedBox(
              height: 10,
            ),
            GlassNumberSelect(
              callback: (value) => {
                setState(() {
                  widget.movieRate = value;
                  debugPrint(widget.adviceText);
                })
              },
              currentValue: widget.movieRate,
              minVal: 0,
              maxVal: 10,
              stepCount: 1,
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText(
                    'Kategori',
                    style: kTextStyle,
                  )),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 1,
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
        ),
        Column(
          children: [
            const Align(
                alignment: Alignment.topLeft,
                child: AutoSizeText(
                  'Film Hakkında Yaz',
                  style: kTextStyle,
                )),
            const SizedBox(
              height: 10,
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
                    borderRadius: BorderRadius.all(Radius.circular(15.0))), // y
                hintStyle: kLabelTextStyle,
              ),
              onChanged: (value) {
                setState(() {
                  widget.adviceText = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

createRoom(user, selectedMovie, adviceText, movieRate , SuggestionRoom selectedRoom) {
  var request = {
      "avatarUrl": user.avatarUrl,
      "description": adviceText,
      "isChatOwner": false,
      "likeCount": movieRate,
      "movieName": selectedMovie.title.toString(),
      "movieTime": 120,
      "movieYear": 1991,
      "nickname": user.nickname,
      "publishedDate": Timestamp.fromDate(DateTime.now()),
      "seggestionKinds": [],
      "userId": user.userId,
      "roomId": selectedRoom.roomId.toString()
  };

  ApiService().createSuggetionRoomChat(request);
}
