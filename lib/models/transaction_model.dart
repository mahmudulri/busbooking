import 'dart:convert';

TransactionsModel transactionsModelFromJson(String str) =>
    TransactionsModel.fromJson(json.decode(str));

String transactionsModelToJson(TransactionsModel data) =>
    json.encode(data.toJson());

class TransactionsModel {
  final String? status;
  final int? statusCode;
  final bool? success;
  final Body? body;

  TransactionsModel({this.status, this.statusCode, this.success, this.body});

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
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
  final BodyData? data;

  Body({this.items, this.data});

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    items: json["items"] == null
        ? null
        : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    data: json["data"] == null ? null : BodyData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "data": data!.toJson(),
  };
}

class BodyData {
  final int? currentPage;
  final int? lastPage;
  final int? total;

  BodyData({this.currentPage, this.lastPage, this.total});

  factory BodyData.fromJson(Map<String, dynamic> json) => BodyData(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "total": total,
  };
}

class Item {
  final int? id;
  final int? userId;
  final String? referenceableType;
  final int? referenceableId;
  final String? currency;
  final String? total;
  final String? amount;
  final String? fee;
  final String? type;
  final String? action;
  final String? status;
  final ItemData? data;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Item({
    this.id,
    this.userId,
    this.referenceableType,
    this.referenceableId,
    this.currency,
    this.total,
    this.amount,
    this.fee,
    this.type,
    this.action,
    this.status,
    this.data,
    this.createdAt,
    this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    referenceableType: json["referenceable_type"] == null
        ? null
        : json["referenceable_type"],
    referenceableId: json["referenceable_id"] == null
        ? null
        : json["referenceable_id"],
    currency: json["currency"] == null ? null : json["currency"],
    total: json["total"] == null ? null : json["total"],
    amount: json["amount"] == null ? null : json["amount"],
    fee: json["fee"] == null ? null : json["fee"],
    type: json["type"] == null ? null : json["type"],
    action: json["action"] == null ? null : json["action"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : ItemData.fromJson(json["data"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "referenceable_type": referenceableType,
    "referenceable_id": referenceableId,
    "currency": currency,
    "total": total,
    "amount": amount,
    "fee": fee,
    "type": type,
    "action": action,
    "status": status,
    "data": data!.toJson(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class ItemData {
  final String? reason;
  final String? description;

  ItemData({this.reason, this.description});

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
    reason: json["reason"] == null ? null : json["reason"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "description": description,
  };
}
