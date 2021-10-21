import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

typedef DialogCallBack = void Function(DialogData data);

class DialogData {
  String name;
  String description;
  String date;

  DialogData(
      {required this.date, required this.description, required this.name});
}

class CustomDialog extends StatelessWidget {
  String name = "";
  String description = "";
  String date = DateTime.now().toString();
  DialogCallBack dialogCallBack;

  CustomDialog({Key? key, required this.dialogCallBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Maak een feestje aan'),
      contentPadding: const EdgeInsets.all(15.0),
      children: <Widget>[
        TextFormField(
          onChanged: (val) => {
            name = val,
          },
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: 'Feest naam'),
        ),
        TextFormField(
          keyboardType: TextInputType.multiline,
          minLines: 3, //Normal textInputField will be displayed
          maxLines: 5, // when user presses enter it will adapt to it
          onChanged: (val) => {
            description = val,
          },
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), labelText: 'Beschrijving'),
        ),
        const SizedBox(height: 30),
        DateTimePicker(
          type: DateTimePickerType.dateTimeSeparate,
          dateMask: 'd MMM, yyyy',
          initialValue: DateTime.now().toString(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          icon: Icon(Icons.event),
          dateLabelText: 'Datum',
          timeLabelText: "Tijd",
          selectableDayPredicate: (date) {
            // Disable weekend days to select from the calendar
            if (date.weekday == 6 || date.weekday == 7) {
              return false;
            }
            return true;
          },
          onChanged: (val) => {
            date = val,
          },
        ),
        const SizedBox(height: 30),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            primary: Colors.green,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () => {
            dialogCallBack(
              DialogData(date: date, description: description, name: name),
            ),
            Navigator.pop(context)
          },
          child: const Text('Maak evenement'),
        ),
      ],
    );
  }
}
