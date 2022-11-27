import 'package:book_bytes_flutter/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';
import 'package:book_bytes_flutter/constants/colors.dart';

class AddBytePopup extends StatelessWidget {
  final String shelf;
  final String id;
  final String folder;
  const AddBytePopup({Key? key, required this.shelf, required this.id, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String heading = '';
    String lines = '';
    String learning = '';
    return AlertDialog(
      backgroundColor: actionColor,
      title: Center(
          child: Column(
        children: const [],
      )),
      content: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Lines from the book',
              style: dataNormalWhite,
            ),
          ),
          TextField(
            onChanged: (text){
              heading = text;
            },
              keyboardType: TextInputType.multiline,
              maxLines: 9,
              minLines: 9,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Lines from the book'),
              textAlign: TextAlign.left,
              // controller: textfieldController,
              style: dataNormalMost),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Learning in one-liner',
              style: dataNormalWhite,
            ),
          ),
          TextField(
            onChanged: (text){
              lines = text;
            },
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              minLines: 1,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'One-liner of my learning'),
              textAlign: TextAlign.left,
              // controller: textfieldController,
              style: dataNormalMost),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Elaboration of learning',
              style: dataNormalWhite,
            ),
          ),
          TextField(
            onChanged: (text){
              learning = text;
            },
              keyboardType: TextInputType.multiline,
              maxLines: 9,
              minLines: 9,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Elaborate explanation of my learning'),
              textAlign: TextAlign.left,
              // controller: textfieldController,
              style: dataNormalMost),
        ]),
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
                        AuthService().addByte('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MmMxNjJiNThmZjA3NGFhNWY2OTM0MzMiLCJuYW1lIjoiaHlkcm9nZW4iLCJwYXNzd29yZCI6IiQyYiQxMCRFMXRYenAybzR4eVNLVGFvQncuYUEuUElvQnN2S3lveUE3QjRPeDVnOVNtY0UvT3FsSEpBSyIsInNoZWx2ZXMiOltdLCJfX3YiOjB9.v_SkSkjjAf9oCZjFCTSPRYmPIhHoocRIQxGMD4uHRmA', shelf, id, folder, heading, lines, learning).then((response){
                          if(response==true){
                            Navigator.pushNamed(context, '/');
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: greenColor,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Text(
                        'Add',
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
