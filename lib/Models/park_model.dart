import 'dart:convert';

List<ParkModel> parkModelFromJson(String str) =>
    List<ParkModel>.from(json.decode(str).map((x) => ParkModel.fromJson(x)));

String parkModelToJson(List<ParkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParkModel {
  ParkModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory ParkModel.fromJson(Map<String, dynamic> json) => ParkModel(
        id: json["id"],
        name: utf8.decode(json["name"].codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
