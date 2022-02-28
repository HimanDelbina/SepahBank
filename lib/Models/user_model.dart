// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        this.id,
        this.name,
        this.family,
        this.superUser,
        this.nameKarbari,
        this.password,
        this.listDate,
        this.shobe,
    });

    int? id;
    String? name;
    String? family;
    bool? superUser;
    String? nameKarbari;
    String? password;
    DateTime? listDate;
    int? shobe;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        family: json["family"],
        superUser: json["superUser"],
        nameKarbari: json["nameKarbari"],
        password: json["password"],
        listDate: DateTime.parse(json["list_date"]),
        shobe: json["shobe"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "family": family,
        "superUser": superUser,
        "nameKarbari": nameKarbari,
        "password": password,
        "list_date": listDate!.toIso8601String(),
        "shobe": shobe,
    };
}
