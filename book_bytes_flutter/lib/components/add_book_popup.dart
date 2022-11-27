import 'package:book_bytes_flutter/components/book_box.dart';
import 'package:book_bytes_flutter/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/constants/colors.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';

class AddBookPopup extends StatefulWidget {
  final String tab;
  final String token;
  const AddBookPopup({Key? key, required this.tab, required this.token}) : super(key: key);

  @override
  State<AddBookPopup> createState() => _AddBookPopupState();
}

class _AddBookPopupState extends State<AddBookPopup> {
  List<Widget> results = [];

  @override
  Widget build(BuildContext context) {
    String value = '';
    return AlertDialog(
      backgroundColor: actionColor,
      title: const Center(
          child: Text('Search by book or author name', style: dataNormalWhite)),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
                onChanged: (text) {
                  value = text;
                  AuthService().getBooksFromGoogle(value).then((response) {
                    List<Widget> temp = [];
                    if(response!=null){
                      for(int i=0; i<response.length; i++){
                        temp.add(
                          BookBox(token: widget.token, image: response[i]['image'], title: response[i]['title'], author: response[i]['author'], id: response[i]['id'], tab: widget.tab,)
                        );
                      }
                    }
                    setState(() {
                      results = temp;
                    });
                  });
                },
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    )),
                textAlign: TextAlign.center,
                style: dataNormalWhite),
            Column(
              children: results
            )
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
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
                    style: dataBoldWhite,
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
