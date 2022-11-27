import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';

class ByteBox extends StatelessWidget {
  final String title;
  final String content;
  final int index;
  final Color color;
  const ByteBox(
      {Key? key,
      required this.title,
      required this.content,
      required this.index,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Stack(
        children: [
          Container(
            height: 110,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(4, 4), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Text(
                        title,
                        style: dataBoldMost,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '#b${index.toString()}',
                          style: dataLightMost,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Text(
                    content,
                    style: dataNormalMost,
                    overflow: TextOverflow.fade,
                  ),
                )
              ],
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              width: 30,
              height: 30,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, 30);
    path.lineTo(5, 30);
    path.lineTo(5, 5);
    path.lineTo(30, 5);
    path.lineTo(30, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
