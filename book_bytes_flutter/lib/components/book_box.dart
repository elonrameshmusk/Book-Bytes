import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';
import 'package:book_bytes_flutter/services/authservice.dart';

class BookBox extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String id;
  final String tab;
  final String token;
  const BookBox(
      {Key? key,
      required this.image,
      required this.title,
      required this.author,
      required this.id,
      required this.tab,
      required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 80,
      ),
      child: GestureDetector(
        onTap: (){
          AuthService().addBook(token, tab, id).then((response){
            print(response);
          });
        },
        child: Row(
          children: [
            Image(
              image: NetworkImage(image),
              height: 81,
              width: 49,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: dataBoldWhite,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      author,
                      style: dataNormalWhite,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
