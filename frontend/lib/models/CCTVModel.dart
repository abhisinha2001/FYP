// To parse this JSON data, do
//
//     final CCTVModel = CCTVModelFromJson(jsonString);

import 'dart:convert';

List<CCTVModel> CCTVModelFromJson(String str) =>
    List<CCTVModel>.from(json.decode(str).map((x) => CCTVModel.fromJson(x)));

String CCTVModelToJson(List<CCTVModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CCTVModel {
  CCTVModel({
    required this.cctvId,
    required this.cctvRoad,
    required this.lat,
    required this.long,
    this.policyUrl = "https://www.google.com.ar/",
    this.phone = "+999999",
    this.email = "example@somewhere.com",
  });

  int cctvId;
  String cctvRoad;
  double lat;
  double long;
  String? policyUrl;
  String? phone;
  String? email;

  factory CCTVModel.fromJson(Map<String, dynamic> json) => CCTVModel(
        cctvId: json["cctv_id"],
        cctvRoad: json["cctv_road"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        policyUrl: json["policy_url"],
        phone: json["Phone"],
        email: json["Email"],
      );

  Map<String, dynamic> toJson() => {
        "cctv_id": cctvId,
        "cctv_road": cctvRoad,
        "lat": lat,
        "long": long,
        "policy_url": policyUrl,
        "Phone": phone,
        "Email": email,
      };
}
