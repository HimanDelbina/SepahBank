import 'dart:convert';

List<Shobe> shobeFromJson(String str) =>
    List<Shobe>.from(json.decode(str).map((x) => Shobe.fromJson(x)));

String shobeToJson(List<Shobe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shobe {
  Shobe({
    this.id,
    this.name,
    this.code,
    this.shobeImage,
    this.bazariabiJadidImage,
    this.moshtariGhabliImage,
    this.shahrestan,
  });

  int? id;
  String? name;
  int? code;
  String? shobeImage;
  String? bazariabiJadidImage;
  String? moshtariGhabliImage;
  Shahrestan? shahrestan;

  factory Shobe.fromJson(Map<String, dynamic> json) => Shobe(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        shobeImage: json["shobeImage"],
        bazariabiJadidImage: json["bazariabiJadidImage"],
        moshtariGhabliImage: json["moshtariGhabliImage"],
        shahrestan: Shahrestan.fromJson(json["shahrestan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "shobeImage": shobeImage,
        "bazariabiJadidImage": bazariabiJadidImage,
        "moshtariGhabliImage": moshtariGhabliImage,
        "shahrestan": shahrestan!.toJson(),
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
        id: json["id"],
        name: json["name"],
        hoze: List<int>.from(json["hoze"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hoze": List<dynamic>.from(hoze!.map((x) => x)),
      };
}
