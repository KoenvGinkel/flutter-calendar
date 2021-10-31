import 'package:calendar/contactdata.dart';
import 'package:calendar/contactlistitem.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

typedef ContactCallback = void Function(List<ContactData>);

class ContactPicker extends StatefulWidget {

  ContactCallback callback;

  ContactPicker({ Key? key, required this.callback }) : super(key: key);


  @override
  _ContactPickerState createState() => _ContactPickerState();
}

class _ContactPickerState extends State<ContactPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacten selecteren"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<Contact>>(
            future: getContacts(),
            builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
              List<Widget> childs;
              if(snapshot.hasData) {
                childs =  [
                  createList(snapshot.data ?? [])
                ];
              } else {
                //Contacts could not be read
                childs = [];
              }
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Column(children: childs),
              );
            },
            )
        ),
      )
    );
  }

  createList(List<Contact> data) {
    List<ContactData> contactList = List.empty(growable: true);
    data.forEach((element) {
      contactList.add(ContactData(Id: element.identifier ?? "", Name: element.displayName ?? "", email: element.emails?.isNotEmpty ?? false ? element.emails?.first.value ?? "" : "", phone: (element.phones?.isNotEmpty ?? false) ? element.phones?.first.value ?? "" : "", use: getSelected(element)));
    });

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            itemCount: contactList.length,
            itemBuilder: (context, i) {
              return ContactListItem(data: contactList[i]);
            }
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: ElevatedButton(onPressed: () => { widget.callback(contactList.where((element) => element.use).toList()), Navigator.pop(context)}, child: const Text("Add contacts")),
        )
      ],
    );
    
  }

  Future<List<Contact>> getContacts() async {
    var perm = await Permission.contacts.status;
    if(perm.isDenied) {
      var perm = await Permission.contacts.request();
      if(perm.isDenied) {
        return [];
      }
    }

    List<Contact> contacts = await ContactsService.getContacts();

    return contacts.toList();
  }

  getSelected(Contact contact) {
    return false;
  }
}