// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movi/components/buttons.dart';
import 'package:movi/components/partial.dart';
import 'package:movi/contants.dart';
import 'package:movi/models/advice_model.dart';
import 'package:movi/models/movie_model.dart';

class CreateSuggestionScreen extends StatefulWidget {
  final Advice selectedChatScreenForSuggestion;
  CreateSuggestionScreen(
      {required this.selectedChatScreenForSuggestion, Key? key})
      : super(key: key);

  @override
  State<CreateSuggestionScreen> createState() => _CreateSuggestionScreenState();
}

class _CreateSuggestionScreenState extends State<CreateSuggestionScreen> {
  late String searchValue = '';

  Future<List<Movie>> _getMovies() async {
    try {
      var url = searchValue.length > 2
          ? 'https://api.themoviedb.org/3/search/movie?api_key=06397476a482aded09cb86da0a2cbbbb&query=${searchValue}&language=tr-TR'
          : 'https://api.themoviedb.org/3/movie/popular?api_key=06397476a482aded09cb86da0a2cbbbb&language=tr-TR&page=1';
      var response = await Dio().get('${url}');
      List<Movie> _movieList = [];
      if (response.statusCode == 200) {
        var responseData = response.data;

        _movieList = (responseData['results'] as List)
            .map((e) => Movie.fromMap(e))
            .toList();
      }

      return _movieList;
    } on DioError {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getMovies();
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
                  'Haydi ' +
                      widget.selectedChatScreenForSuggestion.nickname +
                      ' için öneri yap',
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
              child: Column(
                children: [
                  TextFormField(
                      maxLength: 15,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.transparent)),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))), // y
                        hintStyle: kLabelTextStyle,
                        hintText: 'Film Ara',
                        suffixIcon: IconButton(
                          onPressed: () {
                            debugPrint(searchValue);
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchValue = value;
                        });
                      }),
                  Flexible(
                    child: FutureBuilder<List<Movie>>(
                      future: _getMovies(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Movie> movieList = snapshot.data!;
                          return ListView.builder(
                              itemCount: movieList.length,
                              itemBuilder: (context, ind) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: InkWell(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                                'https://image.tmdb.org/t/p/w94_and_h141_bestv2${movieList[ind].posterPath}'),
                                          ),
                                          Text(
                                            movieList[ind].title,
                                            style: kTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
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
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: PrimaryIconButtonLg(
              iconSrc: 'assets/right_arrow.png',
              buttonText: 'Gönder',
              iconDirection: 'right',
              onPressFunc: () {},
            ),
          ),
        ],
      ),
    );
  }
}
