import 'package:book_bytes_flutter/screens/auth_screen.dart';
import 'package:book_bytes_flutter/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/components/add_shelf_popup.dart';
import 'package:book_bytes_flutter/components/tab_bar_view_widget.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';
import 'package:book_bytes_flutter/constants/colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<dynamic> _shelves;


  @override
  void initState() {
    super.initState();

    _shelves = AuthService().getShelves(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Book Bytes'),
          actions: [
            GestureDetector(
              onTap: () async {
                const storage = FlutterSecureStorage();
                await storage.delete(key: 'token');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AuthScreen()));
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: const Icon(
                  Icons.logout,
                  size: 25,
                  color: actionColor,
                ),
              ),
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
              color: mostColor,
              fontFamily: 'NY',
              fontSize: 25,
              fontWeight: FontWeight.bold),
          elevation: 0,
          primary: true,
        ),
        body: Container(
          color: Colors.white,
          child: FutureBuilder<dynamic>(
              future: _shelves,
              builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('load...aim...');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    print(snapshot);
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
                      tabbarViews.add(TabBarViewWidget(
                        tab: snapshot.data![i],
                        token: widget.token,
                      ));
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    tabs: tabs,
                                    labelStyle: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    unselectedLabelStyle: const TextStyle(
                                        fontWeight: FontWeight.normal),
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorColor: actionColor,
                                  )),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AddShelfPopup(token: widget.token));
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
                                              fontSize: 25),
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
                    return const Text('4.0');
                  }
                } else {
                  return const Text('hello world!');
                }
              }),
        ),
      ),
    );
  }
}
