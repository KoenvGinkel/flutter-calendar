import 'package:flutter/material.dart';

import 'contactdata.dart';

class ContactListItem extends StatefulWidget {

  ContactData data;

  ContactListItem({Key? key, required this.data}) : super(key: key);

  @override
  _ContactListItemState createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem> {

  bool _selected = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selected = widget.data.use;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.data.Name),
              Text(widget.data.email),
              Text(widget.data.phone),
              Checkbox(
                  value: _selected,
                  onChanged: (v) {
                    setState(() {
                      widget.data.use = (v ?? false);
                      _selected = v ?? false;
                    });
                  })
            ],
          )
        ],
      ),
    );
  }
}
