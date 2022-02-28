// To parse this JSON data, do
//
//     final shahrestanModel = shahrestanModelFromJson(jsonString);

import 'dart:convert';

List<ShahrestanModel> shahrestanModelFromJson(String str) => List<ShahrestanModel>.from(json.decode(str).map((x) => ShahrestanModel.fromJson(x)));

String shahrestanModelToJson(List<ShahrestanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShahrestanModel {
    ShahrestanModel({
        this.id,
        this.name,
        this.hoze,
    });

    int? id;
    String? name;
    List<Hoze>? hoze;

    factory ShahrestanModel.fromJson(Map<String, dynamic> json) => ShahrestanModel(
        id: json["id"],
        name: json["name"],
        hoze: List<Hoze>.from(json["hoze"].map((x) => Hoze.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hoze": List<dynamic>.from(hoze!.map((x) => x.toJson())),
    };
}

class Hoze {
    Hoze({
        this.id,
        this.name,
        this.mantaghe,
    });

    int? id;
    String? name;
    List<int>? mantaghe;

    factory Hoze.fromJson(Map<String, dynamic> json) => Hoze(
        id: json["id"],
        name: json["name"],
        mantaghe: List<int>.from(json["mantaghe"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mantaghe": List<dynamic>.from(mantaghe!.map((x) => x)),
    };
}
