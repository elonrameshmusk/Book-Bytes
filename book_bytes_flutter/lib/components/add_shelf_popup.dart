import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/services/authservice.dart';
import 'package:book_bytes_flutter/constants/colors.dart';

class AddShelfPopup extends StatefulWidget {
  final String token;
  const AddShelfPopup({Key? key, required this.token}) : super(key: key);

  @override
  State<AddShelfPopup> createState() => _AddShelfPopupState();
}

class _AddShelfPopupState extends State<AddShelfPopup> {
  bool circleVisibility = false;
  @override
  Widget build(BuildContext context) {
    String value = '';
    return AlertDialog(
      backgroundColor: mostColor,
      title: const Center(
          child: Text(
            'New shelf name',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: 'SFPD',
                fontSize: 16),
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
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
          Visibility(
            child: Container(
              margin: EdgeInsets.fromLTRB(0,10,0,0),
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 4,
              ),
            ),
          )
        ],
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
                        'Close',
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
                            .addShelf(
                            widget.token,
                            value)
                            .then((response) {
                          if (response == true) {
                            // Navigator.pushNamed(context, '/home', arguments: HomeScreenArgument(token));
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
