
import 'dart:convert';

List<NoeHesabModel> noeHesabModelFromJson(String str) => List<NoeHesabModel>.from(json.decode(str).map((x) => NoeHesabModel.fromJson(x)));

String noeHesabModelToJson(List<NoeHesabModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NoeHesabModel {
    NoeHesabModel({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory NoeHesabModel.fromJson(Map<String, dynamic> json) => NoeHesabModel(
        id: json["id"] == null ? null : json["id"]!,
        name: json["name"] == null ? null : utf8.decode(json["name"]!.codeUnits),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id!,
        "name": name == null ? null : name!,
    };
}
