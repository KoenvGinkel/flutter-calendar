import 'package:calendar/dialog.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contactpicker.dart';

typedef UpdateList = void Function(DialogData data);


class PartyList extends StatefulWidget {
  DialogData data;

  @override
  PartyItemState createState() => PartyItemState();

  PartyList(
      {Key? key, required this.data})
      : super(key: key);
}

class PartyItemState extends State<PartyList> {

  void changeParty(DialogData data) {
    setState(() {
      widget.data = data;
    });
  }

  DialogData item = DialogData(date: "", description: "", name: "", contacts: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.name,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          Text(
            widget.data.description,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          Text(
            widget.data.date,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              itemCount: widget.data.contacts.length,
              itemBuilder: (context, i) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.contacts[i].Name
                      )
                    ],
                  ),
                );
              })
              ),
          SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactPicker (
                    callback: contactsCallback,
                  ),
                ),
              ),
            },
            child: const Text("Pick contacts"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 40,
          child: ElevatedButton(onPressed: () => sendMail(widget.data), child: const Text("stuur mail")),
        )
        ],
      ),
    );
  }

  contactsCallback(contacts) {
     setState(() {
       widget.data.contacts = contacts;
     });
  }

  sendMail(DialogData data) async {
    List<String> addresses = [];
    for (var element in data.contacts) {
      if(element.email != null) {
        addresses.add(element.email);
      }
      
    }

    final link = Mailto(
      to: addresses,
      subject: data.name,
      body:
          'Hey, Ik hou een feestie, kom je ook? \n Het feesie is op: ${data.date} \n Hier heb ik nog wat te vertellen: ' +
              data.description,
    );

    await launch('$link');

  }
}
