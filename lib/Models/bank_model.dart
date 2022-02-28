import 'dart:convert';

List<Bank> bankFromJson(String str) =>
    List<Bank>.from(json.decode(str).map((x) => Bank.fromJson(x)));

String bankToJson(List<Bank> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bank {
  Bank({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        name: utf8.decode(json["name"].codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
