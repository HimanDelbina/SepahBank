// To parse this JSON data, do
//
//     final markerModel = markerModelFromJson(jsonString);

import 'dart:convert';

MarkerModel markerModelFromJson(String str) =>
    MarkerModel.fromJson(json.decode(str));

String markerModelToJson(MarkerModel data) => json.encode(data.toJson());

class MarkerModel {
  MarkerModel({
    this.id,
    this.user,
    this.selectMode,
    this.name,
    this.mobile,
    this.senf,
    this.zirsenf,
    this.description,
    this.image,
    this.long,
    this.lut,
    this.shobeCode,
    this.shomarehesab,
    this.isPos,
    this.posNumber,
    this.listDate,
  });

  int? id;
  String? user;
  String? selectMode;
  String? name;
  int? mobile;
  String? senf;
  String? zirsenf;
  String? description;
  String? image;
  double? long;
  double? lut;
  int? shobeCode;
  String? shomarehesab;
  bool? isPos;
  int? posNumber;
  DateTime? listDate;

  factory MarkerModel.fromJson(Map<String, dynamic> json) => MarkerModel(
        id: json["id"],
        user: utf8.decode(json["user"].codeUnits),
        selectMode: utf8.decode(json["selectMode"].codeUnits),
        name: utf8.decode(json["name"].codeUnits),
        mobile: json["mobile"],
        senf: utf8.decode(json["senf"].codeUnits),
        zirsenf: utf8.decode(json["zirsenf"].codeUnits),
        description: utf8.decode(json["description"].codeUnits),
        image: json["image"],
        long: json["long"].toDouble(),
        lut: json["lut"].toDouble(),
        shobeCode: json["shobeCode"],
        shomarehesab: utf8.decode(json["shomarehesab"].codeUnits),
        isPos: json["is_pos"],
        posNumber: json["pos_number"],
        listDate: DateTime.parse(json["list_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "selectMode": selectMode,
        "name": name,
        "mobile": mobile,
        "senf": senf,
        "zirsenf": zirsenf,
        "description": description,
        "image": image,
        "long": long,
        "lut": lut,
        "shobeCode": shobeCode,
        "shomarehesab": shomarehesab,
        "is_pos": isPos,
        "pos_number": posNumber,
        "list_date": listDate!.toIso8601String(),
      };
}
