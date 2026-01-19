import 'dart:convert';

CustomerProfileModel customerProfileModelFromJson(String str) =>
    CustomerProfileModel.fromJson(json.decode(str));

String customerProfileModelToJson(CustomerProfileModel data) =>
    json.encode(data.toJson());

class CustomerProfileModel {
  final String? status;
  final int? statusCode;
  final bool? success;
  final Body? body;

  CustomerProfileModel({this.status, this.statusCode, this.success, this.body});

  factory CustomerProfileModel.fromJson(Map<String, dynamic> json) =>
      CustomerProfileModel(
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
  final String? token;
  final List<Profile>? profile;

  Body({this.token, this.profile});

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    token: json["token"],
    profile: List<Profile>.from(
      json["profile"].map((x) => Profile.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "profile": List<dynamic>.from(profile!.map((x) => x.toJson())),
  };
}

class Profile {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final dynamic nationalId;
  final String? gender;
  final String? role;
  final String? status;
  final dynamic birthday;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.nationalId,
    this.gender,
    this.role,
    this.status,
    this.birthday,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    nationalId: json["national_id"] == null ? null : json["national_id"],
    gender: json["gender"] == null ? null : json["gender"],
    role: json["role"] == null ? null : json["role"],
    status: json["status"] == null ? null : json["status"],
    birthday: json["birthday"] == null ? null : json["birthday"],
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
    "national_id": nationalId,
    "gender": gender,
    "role": role,
    "status": status,
    "birthday": birthday,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
