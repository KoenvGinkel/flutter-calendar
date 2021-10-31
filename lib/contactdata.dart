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
}
