import 'package:calendar/dialog.dart';
import 'package:flutter/material.dart';

class PartyItem extends StatelessWidget {
  DialogData item = DialogData(date: "", description: "", name: "");

  PartyItem({Key? key, required DialogData item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(item.name)),
    );
  }
}
