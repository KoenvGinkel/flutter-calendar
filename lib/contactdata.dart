import 'package:flutter/material.dart';

class ContactData {
  String Name;
  String Id;
  String email;
  String phone;
  bool use = false;

  ContactData({
    required this.Id,
    required this.Name,
    required this.email,
    required this.phone,
    required this.use
  });

   ContactData fromJson(Map<String, dynamic> json) => ContactData(
      Name: json["Name"],
      Id: json["Id"],
      email: json["email"],
      phone: json["phone"],
      use: json["use"]);

  Map<String, dynamic> toJson() => {
        "Name": Name,
        "Id": Id,
        "email": email,
        "phone": phone,
        "selected": use,
      };
}
