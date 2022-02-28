// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

List<City> cityFromJson(String str) => List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
    City({
        this.id,
        this.name,
        this.long,
        this.lut,
        this.state,
    });

    int? id;
    String? name;
    double? long;
    double? lut;
    int? state;

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        long: json["long"].toDouble(),
        lut: json["lut"].toDouble(),
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "long": long,
        "lut": lut,
        "state": state,
    };
}
