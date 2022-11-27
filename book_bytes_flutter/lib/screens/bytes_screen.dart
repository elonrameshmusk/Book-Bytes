import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/constants/colors.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';

int flex1 = 2;
int flex2 = 1;
int flex3 = 9;

class ByteScreen extends StatefulWidget {
  const ByteScreen({Key? key}) : super(key: key);

  @override
  State<ByteScreen> createState() => _ByteScreenState();
}

class _ByteScreenState extends State<ByteScreen> {
  TextEditingController textfieldController = TextEditingController();

  Widget _buildPopupDialogTwo(BuildContext context) {
    return AlertDialog(
      backgroundColor: actionColor,
      title: Center(
          child: Column(
        children: const [
          Text(
            'Elon Musk by Ashlee Vance',
            style: dataNormalWhite,
          ),
          Text(
            'Byte #3',
            style: dataNormalWhite,
          ),
        ],
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
          const TextField(
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
          const TextField(
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
          const TextField(
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
                  child: const Text('Close', style: dataBoldWhite),
                ),
              )),
            ],
          ),
        )
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget body(String h, String lines, String lesson) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: Text(
              h,
              style: dataBoldMost,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: Text(
              lines,
              style: dataNormalMostItalic,
            ),
          ),
          Text(
            lesson,
            style: dataNormalMost,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: MaterialApp(
          home: Scaffold(
            body: SafeArea(
              child: Column(children: [
                Expanded(
                  flex: flex1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/nodes.png"),
                              fit: BoxFit.cover),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/godfather.png'),
                              height: 125,
                              width: 78,
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 20,
                                    child: Text(
                                      'The Godfather',
                                      style: dataBoldMost,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: Text(
                                      'Carolais Tackais',
                                      style: dataNormalMost,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.navigate_before,
                          color: actionColor,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: flex2,
                  child: Container(
                    child: Row(
                      children: [
                        const Expanded(
                          child: TabBar(
                            isScrollable: true,
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            tabs: <Widget>[
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "#b1",
                                    style: tabsAction,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "#b2",
                                    style: tabsAction,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "#b3",
                                    style: tabsAction,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "#b4",
                                    style: tabsAction,
                                  ),
                                ),
                              ),
                            ],
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            unselectedLabelStyle:
                                TextStyle(fontWeight: FontWeight.normal),
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: actionColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialogTwo(context),
                            );
                          },
                          child: const SizedBox(
                            width: 60,
                            child: Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                    color: actionColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SSPro',
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: flex3,
                  child: TabBarView(
                    children: <Widget>[
                      body(
                          'Beware of your thoughts',
                          "\"Based on years of reporting and exclusive interviews with all four billionaires, this authoritative account is a dramatic tale of risk and high adventure, the birth of a new Space Age, fueled by some of the world's richest men as they struggle to end governments' monopoly on the cosmos.\"",
                          "The pandemic reshaped modern life in many ways. Over two years later, we still see ongoing shifts to urban centers. With remote and hybrid work here to stay, thriving careers in the tech industry do not depend on living in traditional technology capitals such as San Francisco, Seattle, or New York."),
                      const Center(
                        child: Text('startups'),
                      ),
                      const Center(
                        child: Text("learn new"),
                      ),
                      const Center(
                        child: Text("learn new"),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
