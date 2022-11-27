import 'package:book_bytes_flutter/screens/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';
import 'package:book_bytes_flutter/services/authservice.dart';

class MyBookBox extends StatelessWidget {
  final String id;
  final Color color;
  final String shelf;
  final String token;
  const MyBookBox(
      {Key? key,
      required this.id,
      required this.color,
      required this.shelf,
      required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: AuthService().getBookFromGoogle(id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('loading..');
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('error');
            } else if (snapshot.hasData) {
              return GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/home',
                  //     arguments: HomeScreenArgument(token));
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: color,
                                ),
                                height: 152,
                                alignment: Alignment.topCenter),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              height: 152,
                              width: 120,
                              // child: Image(
                              //   fit: BoxFit.fitHeight,
                              //   imageUrl: snapshot.data!['image'],
                              //   progressIndicatorBuilder:
                              //       (context, url, downloadProgress) =>
                              //           CircularProgressIndicator(
                              //     value: downloadProgress.progress,
                              //   ),
                              //   errorWidget: (context, url, error) =>
                              //       const Icon(
                              //     Icons.error,
                              //     size: 100,
                              //     color: Colors.red,
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Text(
                          snapshot.data!['title'],
                          style: dataBoldAction,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Text(
                          snapshot.data!['author'],
                          style: dataNormalAction,
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Text('idk');
            }
          } else {
            return Text('4.0');
          }
        });
  }
}
