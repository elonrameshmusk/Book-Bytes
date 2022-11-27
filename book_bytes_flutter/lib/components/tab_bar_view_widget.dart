import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/components/my_book_box.dart';
import 'package:book_bytes_flutter/components/add_book_popup.dart';
import 'package:book_bytes_flutter/constants/colors.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';
import 'package:book_bytes_flutter/services/authservice.dart';

class TabBarViewWidget extends StatelessWidget {
  final String tab;
  final String token;
  const TabBarViewWidget({Key? key, required this.tab, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddBookPopup(tab: tab, token: token,),
          );
        },
        backgroundColor: actionColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.book,
                size: 20,
              ),
              Text('+', style: dataNormalWhite)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder<dynamic>(
        future: AuthService().getBooks(
            token,
            tab),
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('loading books...');
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('error');
            } else if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) {
                    return MyBookBox(
                        id: snapshot.data![index],
                        color: gridColors[index % 10],
                    shelf: tab,
                    token: token,);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 8,
                  ),
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
                          'A book is a privelege of  learning about the author’s years of research on a subject in 200 pages. Go read such wonderful books and add them here',
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
