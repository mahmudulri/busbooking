import 'dart:convert';

CommonRechargeModel commonRechargeModelFromJson(String str) =>
    CommonRechargeModel.fromJson(json.decode(str));

String commonRechargeModelToJson(CommonRechargeModel data) =>
    json.encode(data.toJson());

class CommonRechargeModel {
  final String? status;
  final int? statusCode;
  final bool? success;
  final Body? body;

  CommonRechargeModel({this.status, this.statusCode, this.success, this.body});

  factory CommonRechargeModel.fromJson(Map<String, dynamic> json) =>
      CommonRechargeModel(
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
  final String? mobile;
  final int? amount;
  final int? fee;
  final String? tx;
  final String? status;
  final String? requestStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  Item({
    this.id,
    this.mobile,
    this.amount,
    this.fee,
    this.tx,
    this.status,
    this.requestStatus,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"] == null ? null : json["id"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    amount: json["amount"] == null ? null : json["amount"],
    fee: json["fee"] == null ? null : json["fee"],
    tx: json["tx"] == null ? null : json["tx"],
    status: json["status"] == null ? null : json["status"],
    requestStatus: json["request_status"] == null
        ? null
        : json["request_status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobile": mobile,
    "amount": amount,
    "fee": fee,
    "tx": tx,
    "status": status,
    "request_status": requestStatus,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "user": user!.toJson(),
  };
}

class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? role;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    role: json["role"] == null ? null : json["role"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile": mobile,
    "role": role,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
