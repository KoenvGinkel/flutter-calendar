import 'dart:convert';
import 'dart:io';
import 'package:calendar/dialog.dart';
import 'package:calendar/partyitem.dart';
import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalender',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Opkomende feestjes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Main home screen and start page of the app.
class _MyHomePageState extends State<MyHomePage> {
  List<DialogData> events = [];
  String name = '';
  String description = '';
  String date = DateTime.now().toString();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<String?> _showDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        dialogCallBack: (d) => addEvent(d),
      ),
    );
  }

  void loadData() async {
    final shared = await SharedPreferences.getInstance();
    var data = shared.getString("parties");
    if (data != null) {
      setState(() {
        events = jsonDecode(data);
      });
    }
  }

  void addEvent(DialogData data) async {
    // copy the events list.
    List<DialogData> temp = events;
    temp.add(data);

    // //Save the data persisitance
    final shared = await SharedPreferences.getInstance();
    shared.setString("parties", jsonEncode(temp));


    setState(() {
      events = temp;
    });

    DateTime startDate = DateTime.parse(data.date);
    DateTime endDate = startDate.add(const Duration(hours: 3));

    // save event to calendar
    Event event = Event(
        title: data.name,
        description: data.description,
        startDate: startDate,
        endDate: endDate);
    Add2Calendar.addEvent2Cal(event);
  }

  @override
  Widget build(BuildContext 
  context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(events[index].name),
            subtitle: Text(events[index].date),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PartyList(data: events[index])),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add event',
        child: const Icon(Icons.add),
      ),
    );
  }
}
