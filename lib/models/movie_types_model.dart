// To parse this JSON data, do
//
//     final movieTypes = movieTypesFromMap(jsonString);

import 'dart:convert';

List<MovieTypes> movieTypesFromMap(String str) => List<MovieTypes>.from(json.decode(str).map((x) => MovieTypes.fromMap(x)));

String movieTypesToMap(List<MovieTypes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MovieTypes {
    MovieTypes({
        required this.id,
        required this.name,
        required this.icon,
    });

    final int id;
    final String name;
    final String icon;

    factory MovieTypes.fromMap(Map<String, dynamic> json) => MovieTypes(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "icon": icon,
    };
}




MovieTypesItem movieTypesItemFromMap(String str) => MovieTypesItem.fromMap(json.decode(str));

String movieTypesItemToMap(MovieTypesItem data) => json.encode(data.toMap());

class MovieTypesItem {
    MovieTypesItem({
        required this.id,
        required this.name,
        required this.icon,
    });

    final int id;
    final String name;
    final String icon;

    factory MovieTypesItem.fromMap(Map<String, dynamic> json) => MovieTypesItem(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "icon": icon,
    };
}
