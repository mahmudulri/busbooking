// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  final String? status;
  final int? statusCode;
  final bool? success;
  final Body? body;

  WalletModel({this.status, this.statusCode, this.success, this.body});

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
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
  final int? balance;

  Body({this.balance});

  factory Body.fromJson(Map<String, dynamic> json) =>
      Body(balance: json["balance"]);

  Map<String, dynamic> toJson() => {"balance": balance};
}
