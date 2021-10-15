import 'package:calendar/dialog.dart';
import 'package:calendar/partyitem.dart';
import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  List<DialogData> events = [];
  String name = '';
  String description = '';
  String date = DateTime.now().toString();

  Future<String?> _showDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        dialogCallBack: (d) => addEvent(d),
      ),
    );
  }

  void addEvent(DialogData data) {
    // copy the events list.
    List<DialogData> temp = events;
    temp.add(data);

    setState(() {
      events = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(events[index].name),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add event',
        child: const Icon(Icons.add),
      ),
    );
  }
}
