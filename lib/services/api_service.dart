import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movi/models/movie_model.dart';
import 'package:movi/models/movie_types_model.dart';
import 'package:movi/models/suggestionRoom_model.dart';

class ApiService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<MovieTypes>> getData() async {
    try {
      String okunanStr =
          await rootBundle.loadString('assets/data/json/movie_types.json');
      var jsonObject = jsonDecode(okunanStr);
      List<MovieTypes> movieTypes = (jsonObject as List)
          .map((advice) => MovieTypes.fromMap(advice))
          .toList();
      return movieTypes;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  getMovieSearchResponse(searchValue) async {
    try {
      var url = searchValue.length > 3
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

  Future<List<SuggestionRoom>> getSuggestionRooms() async {
    final response = await db.collection('suggestion-rooms').get();
    final List<SuggestionRoom> allData =
        response.docs.map((doc) => SuggestionRoom.fromMap(doc.data())).toList();
    return allData;
  }

  createSuggestionRoom(parameters) async {
    await db.collection('suggestion-rooms').add(parameters).then((docRef) {
      db
          .collection('suggestion-rooms')
          .doc(docRef.id)
          .update({"roomId": docRef.id});
    });
  }

  createSuggetionRoomChat(param) async {
    debugPrint(param.toString());
    await db.collection('suggestion-rooms').doc(param["roomId"].toString()).update({
    "chats": FieldValue.arrayUnion([param]),
  });
  }
}
