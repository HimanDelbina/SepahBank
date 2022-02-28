import 'dart:convert';

List<Marker> markerFromJson(String str) =>
    List<Marker>.from(json.decode(str).map((x) => Marker.fromJson(x)));

String markerToJson(List<Marker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Marker {
  Marker({
    this.id,
    this.image,
    this.user,
    this.selectMode,
    this.name,
    this.mobile,
    this.senf,
    this.zirsenf,
    this.description,
    this.long,
    this.lut,
    this.shobeCode,
    this.listDate,
  });

  int? id;
  String? image;
  String? user;
  String? selectMode;
  String? name;
  int? mobile;
  String? senf;
  String? zirsenf;
  String? description;
  double? long;
  double? lut;
  int? shobeCode;
  DateTime? listDate;

  factory Marker.fromJson(Map<String, dynamic> json) => Marker(
        id: json["id"],
        image: json["image"],
        user: utf8.decode(json["user"].codeUnits),
        selectMode: utf8.decode(json["selectMode"].codeUnits),
        name: utf8.decode(json["name"].codeUnits),
        mobile: json["mobile"],
        senf: utf8.decode(json["senf"].codeUnits),
        zirsenf: utf8.decode(json["zirsenf"].codeUnits),
        description: utf8.decode(json["description"].codeUnits),
        long: json["long"].toDouble(),
        lut: json["lut"].toDouble(),
        shobeCode: json["shobeCode"],
        listDate: DateTime.parse(json["list_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "user": user,
        "selectMode": selectMode,
        "name": name,
        "mobile": mobile,
        "senf": senf,
        "zirsenf": zirsenf,
        "description": description,
        "long": long,
        "lut": lut,
        "shobeCode": shobeCode,
        "list_date": listDate!.toIso8601String(),
      };
}
