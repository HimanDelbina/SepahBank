// To parse this JSON data, do
//
//     final myMarketModel = myMarketModelFromJson(jsonString);

import 'dart:convert';

List<MyMarketModel> myMarketModelFromJson(String str) =>
    List<MyMarketModel>.from(
        json.decode(str).map((x) => MyMarketModel.fromJson(x)));

String myMarketModelToJson(List<MyMarketModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyMarketModel {
  MyMarketModel({
    this.id,
    this.selectMode,
    this.name,
    this.shobeShkhes,
    this.shobeBoss,
    this.mobile,
    this.description,
    this.image,
    this.long,
    this.lut,
    this.shobeCode,
    this.shomarehesab,
    this.isPos,
    this.posNumber,
    this.listDate,
    this.user,
    this.senf,
    this.zirsenf,
    this.shahrestan,
    this.noeHesab,
  });

  int? id;
  String? selectMode;
  String? name;
  int? shobeShkhes;
  String? shobeBoss;
  String? mobile;
  String? description;
  String? image;
  double? long;
  double? lut;
  int? shobeCode;
  String? shomarehesab;
  bool? isPos;
  int? posNumber;
  DateTime? listDate;
  User? user;
  Senf? senf;
  Zirsenf? zirsenf;
  Shahrestan? shahrestan;
  NoeHesab? noeHesab;

  factory MyMarketModel.fromJson(Map<String, dynamic> json) => MyMarketModel(
        id: json["id"] == null ? null : json["id"]!,
        selectMode: json["selectMode"] == null
            ? null
            : utf8.decode(json["selectMode"]!.codeUnits),
        name:
            json["name"] == null ? null : utf8.decode(json["name"]!.codeUnits),
        shobeShkhes:
            json["shobe_shkhes"] == null ? null : json["shobe_shkhes"]!,
        shobeBoss: json["shobe_boss"] == null
            ? null
            : utf8.decode(json["shobe_boss"]!.codeUnits),
        mobile: json["mobile"] == null
            ? null
            : utf8.decode(json["mobile"]!.codeUnits),
        description: json["description"] == null
            ? null
            : utf8.decode(json["description"]!.codeUnits),
        image: json["image"] == null ? null : json["image"]!,
        long: json["long"] == null ? null : json["long"]!.toDouble(),
        lut: json["lut"] == null ? null : json["lut"]!.toDouble(),
        shobeCode: json["shobeCode"] == null ? null : json["shobeCode"]!,
        shomarehesab: json["shomarehesab"] == null
            ? null
            : utf8.decode(json["shomarehesab"]!.codeUnits),
        isPos: json["is_pos"] == null ? null : json["is_pos"]!,
        posNumber: json["pos_number"] == null ? null : json["pos_number"]!,
        listDate: json["list_date"] == null
            ? null
            : DateTime.parse(json["list_date"]!),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        senf: json["senf"] == null ? null : Senf.fromJson(json["senf"]),
        zirsenf:
            json["zirsenf"] == null ? null : Zirsenf.fromJson(json["zirsenf"]),
        shahrestan: json["shahrestan"] == null
            ? null
            : Shahrestan.fromJson(json["shahrestan"]),
        noeHesab: json["noe_hesab"] == null
            ? null
            : NoeHesab.fromJson(json["noe_hesab"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "selectMode": selectMode == null ? null : selectMode!,
        "name": name == null ? null : name!,
        "mobile": mobile == null ? null : mobile!,
        "description": description == null ? null : description!,
        "image": image == null ? null : image!,
        "long": long == null ? null : long!,
        "lut": lut == null ? null : lut!,
        "shobeCode": shobeCode == null ? null : shobeCode!,
        "shomarehesab": shomarehesab == null ? null : shomarehesab!,
        "is_pos": isPos == null ? null : isPos!,
        "pos_number": posNumber == null ? null : posNumber!,
        "list_date": listDate == null ? null : listDate!.toIso8601String(),
        "user": user == null ? null : user!.toJson(),
        "senf": senf == null ? null : senf!.toJson(),
        "zirsenf": zirsenf == null ? null : zirsenf!.toJson(),
        "shahrestan": shahrestan == null ? null : shahrestan!.toJson(),
        "noe_hesab": noeHesab == null ? null : noeHesab!.toJson(),
      };
}

class Senf {
  Senf({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Senf.fromJson(Map<String, dynamic> json) => Senf(
        id: json["id"] == null ? null : json["id"]!,
        name:
            json["name"] == null ? null : utf8.decode(json["name"]!.codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
      };
}

class Shahrestan {
  Shahrestan({
    this.id,
    this.name,
    this.hoze,
  });

  int? id;
  String? name;
  List<int>? hoze;

  factory Shahrestan.fromJson(Map<String, dynamic> json) => Shahrestan(
        id: json["id"] == null ? null : json["id"]!,
        name:
            json["name"] == null ? null : utf8.decode(json["name"]!.codeUnits),
        hoze: json["hoze"] == null
            ? null
            : List<int>.from(json["hoze"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
        "hoze": hoze == null ? null : List<dynamic>.from(hoze!.map((x) => x)),
      };
}

class User {
  User({
    this.id,
    this.phoneNumber,
    this.nameKarbari,
    this.user,
    this.role,
    this.shobe,
  });

  int? id;
  String? phoneNumber;
  String? nameKarbari;
  int? user;
  int? role;
  int? shobe;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"]!,
        phoneNumber:
            json["phone_number"] == null ? null : json["phone_number"]!,
        nameKarbari: json["nameKarbari"] == null
            ? null
            : utf8.decode(json["nameKarbari"]!.codeUnits),
        user: json["user"] == null ? null : json["user"]!,
        role: json["role"] == null ? null : json["role"]!,
        shobe: json["shobe"] == null ? null : json["shobe"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "phone_number": phoneNumber == null ? null : phoneNumber!,
        "nameKarbari": nameKarbari == null ? null : nameKarbari!,
        "user": user == null ? null : user!,
        "role": role == null ? null : role!,
        "shobe": shobe == null ? null : shobe!,
      };
}

class Zirsenf {
  Zirsenf({
    this.id,
    this.name,
    this.senf,
  });

  int? id;
  String? name;
  int? senf;

  factory Zirsenf.fromJson(Map<String, dynamic> json) => Zirsenf(
        id: json["id"] == null ? null : json["id"]!,
        name:
            json["name"] == null ? null : utf8.decode(json["name"]!.codeUnits),
        senf: json["senf"] == null ? null : json["senf"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
        "senf": senf == null ? null : senf!,
      };
}

class NoeHesab {
  NoeHesab({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory NoeHesab.fromJson(Map<String, dynamic> json) => NoeHesab(
        id: json["id"] == null ? null : json["id"]!,
        name:
            json["name"] == null ? null : utf8.decode(json["name"]!.codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
      };
}
