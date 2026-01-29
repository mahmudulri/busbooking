import 'dart:convert';

CityListModel cityListModelFromJson(String str) =>
    CityListModel.fromJson(json.decode(str));

String cityListModelToJson(CityListModel data) => json.encode(data.toJson());

class CityListModel {
  final String? status;
  final int? statusCode;
  final bool? success;
  final Body? body;

  CityListModel({this.status, this.statusCode, this.success, this.body});

  factory CityListModel.fromJson(Map<String, dynamic> json) => CityListModel(
    status: json["status"],
    statusCode: json["status_code"],
    success: json["success"],
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "status_code": statusCode,
    "success": success,
    "body": body!.toJson(),
  };
}

class Body {
  final List<Item>? items;
  final Data? data;

  Body({this.items, this.data});

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "data": data!.toJson(),
  };
}

class Data {
  final int? currentPage;
  final int? lastPage;
  final int? total;

  Data({this.currentPage, this.lastPage, this.total});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "total": total,
  };
}

class Item {
  final int? id;
  final String? name;
  final String? code;

  Item({this.id, this.name, this.code});

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(id: json["id"], name: json["name"], code: json["code"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "code": code};
}
