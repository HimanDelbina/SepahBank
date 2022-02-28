import 'dart:convert';

List<ZirSenf> zirSenfFromJson(String str) =>
    List<ZirSenf>.from(json.decode(str).map((x) => ZirSenf.fromJson(x)));

String zirSenfToJson(List<ZirSenf> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZirSenf {
  ZirSenf({
    this.id,
    this.name,
    this.senf,
  });

  int? id;
  String? name;
  Senf? senf;

  factory ZirSenf.fromJson(Map<String, dynamic> json) => ZirSenf(
        id: json["id"],
        name: json["name"],
        senf: Senf.fromJson(json["senf"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "senf": senf!.toJson(),
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
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
