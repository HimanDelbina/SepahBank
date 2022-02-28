import 'dart:convert';

List<SenfModel> senfModelFromJson(String str) =>
    List<SenfModel>.from(json.decode(str).map((x) => SenfModel.fromJson(x)));

String senfModelToJson(List<SenfModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SenfModel {
  SenfModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory SenfModel.fromJson(Map<String, dynamic> json) => SenfModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
