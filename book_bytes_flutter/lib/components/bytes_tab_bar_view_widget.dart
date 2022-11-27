import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/components/add_byte_popup.dart';
import 'package:book_bytes_flutter/components/byte_box.dart';
import 'package:book_bytes_flutter/constants/colors.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';
import 'package:book_bytes_flutter/services/authservice.dart';

class BytesTabBarViewWidget extends StatelessWidget {
  final String shelf;
  final String id;
  final String folder;
  final String token;
  const BytesTabBarViewWidget(
      {Key? key, required this.shelf, required this.id, required this.folder, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AddBytePopup(shelf: shelf, id: id, folder: folder,));
        },
        backgroundColor: actionColor,
        child: const Center(
          child: Text('📝+', style: dataNormalWhite),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<dynamic>(
        future: AuthService().getBytes(
            token,
            shelf,
            id,
            folder),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('loading bytes...');
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('error');
            } else if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                List<Widget> children = [];
                for (int i = 0; i < snapshot.data!.length; i++) {
                  children.add(ByteBox(
                    title: snapshot.data![i]['heading'],
                    content: snapshot.data![i]['lines'],
                    index: i,
                    color: gridColors[i % 10],
                  ));
                }
                return SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Column(children: children)),
                );
              } else {
                return Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/elon.png',
                          height: 100,
                        ),
                        const Text(
                          'A book is a privelege of  learning about the author’s years of research on a subject in 200 pages. Read them and add their bytes here!',
                          style: dataNormalMost,
                        )
                      ],
                    ));
              }
            } else {
              return Text('idk');
            }
          } else {
            return Text('4.0');
          }
        },
      ),
    );
  }
}
