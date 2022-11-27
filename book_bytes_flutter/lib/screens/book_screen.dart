import 'package:book_bytes_flutter/components/add_folder_popup.dart';
import 'package:book_bytes_flutter/components/bytes_tab_bar_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';
import 'package:book_bytes_flutter/constants/colors.dart';
import 'package:book_bytes_flutter/services/authservice.dart';


int flex1 = 2;
int flex2 = 10;

class BookScreen extends StatefulWidget {
  final String image;
  final String title;
  final String author;
  final String shelf;
  final String id;
  final String token;
  const BookScreen(
      {Key? key,
      required this.image,
      required this.title,
      required this.author,
      required this.shelf,
      required this.id,
      required this.token})
      : super(key: key);

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  TextEditingController textfieldController = TextEditingController();
  late Future<dynamic> _folders;
  @override
  void initState() {
    super.initState();
    _folders = AuthService().getFolders(widget.token, widget.shelf, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //
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
                        Image(
                          image: NetworkImage(widget.image),
                          height: 125,
                          width: 78,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                child: Text(
                                  widget.title,
                                  style: dataBoldMost,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Text(
                                  widget.author,
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
                child: FutureBuilder<dynamic>(
                    future: _folders,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('load...aim...');
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Text('error');
                        } else if (snapshot.hasData) {
                          List<Widget> tabs = [];
                          List<Widget> tabbarViews = [];
                          for (var i = 0; i < snapshot.data!.length; i++) {
                            tabs.add(
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data![i],
                                    style: tabsAction,
                                  ),
                                ),
                              ),
                            );
                            tabbarViews.add(BytesTabBarViewWidget(
                                token: widget.token,
                                shelf: widget.shelf,
                                id: widget.id,
                                folder: snapshot.data![i]));
                          }
                          return DefaultTabController(
                              length: snapshot.data.length,
                              initialIndex: 0,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: TabBar(
                                          isScrollable: true,
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 10),
                                          tabs: tabs,
                                          labelStyle: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          unselectedLabelStyle: const TextStyle(
                                              fontWeight: FontWeight.normal),
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          indicatorColor: actionColor,
                                        )),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AddFolderPopup(
                                                            shelf: widget.shelf,
                                                            id: widget.id,
                                                            token:
                                                                widget.token));
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
                                  Expanded(
                                    flex: 10,
                                    child: TabBarView(children: tabbarViews),
                                  ),
                                ],
                              ));
                        } else {
                          return const Text('2.0');
                        }
                      } else {
                        return const Text('memory exceeded');
                      }
                    })),
          ]),
        ),
      ),
    );
  }
}
