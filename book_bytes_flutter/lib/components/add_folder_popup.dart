import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/services/authservice.dart';
import 'package:book_bytes_flutter/constants/colors.dart';

class AddFolderPopup extends StatelessWidget {
  final String shelf;
  final String id;
  final String token;
  const AddFolderPopup({Key? key, required this.shelf, required this.id, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String value = '';
    return AlertDialog(
      backgroundColor: mostColor,
      title: const Center(
          child: Text(
        'New folder name',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontFamily: 'SFPD',
            fontSize: 16),
      )),
      content: TextField(
        onChanged: (text) {
          value = text;
        },
        decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            )),
        textAlign: TextAlign.center,
        // controller: textfieldController,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            fontFamily: 'SFPD',
            color: Colors.white),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontFamily: 'SSPro',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                child: OutlinedButton(
                  onPressed: () async {
                    AuthService()
                        .addFolder(
                            token,
                            shelf,
                            id,
                            value)
                        .then((response) {
                      if (response == true) {
                        Navigator.pushNamed(context, '/');
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: greenColor,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Text(
                    'Create',
                    style: TextStyle(
                        fontFamily: 'SSPro',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: greenColor),
                  ),
                ),
              )),
            ],
          ),
        )
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
