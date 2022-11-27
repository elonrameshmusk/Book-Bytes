import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/constants/colors.dart';
import 'package:book_bytes_flutter/constants/text_styles.dart';
import 'package:book_bytes_flutter/services/authservice.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool newuser = false;
  bool olduser = true;
  Widget box(bool user, String heading, String buttontext) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (user == true) ? mostColor : Colors.white,
          border:
              (user == true) ? null : Border.all(color: disableColor, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        height: 300,
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(''),
                Text(
                  heading,
                  style: (user == true) ? dataBoldWhite : disabledBold,
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1000),
                    border: (user == true)
                        ? null
                        : Border.all(color: disableColor, width: 1),
                  ),
                  child: Center(
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        color: (user == true) ? mostColor : Colors.white,
                        borderRadius: BorderRadius.circular(1000),
                        border: (user == true)
                            ? null
                            : Border.all(color: disableColor, width: 1),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Text(
              'Email',
              style: (user == true) ? dataNormalWhite : disabledNormal,
            ),
            TextField(
                enabled: user,
                decoration: InputDecoration(
                  hintText: 'Type',
                  hintStyle: (user == true) ? hintText : disabledLight,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: (user == true) ? Colors.white : disableColor,
                        width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: (user == true) ? Colors.white : disableColor,
                        width: 1),
                  ),
                ),
                textAlign: TextAlign.start,
                controller: emailController,
                style: (user == true) ? dataNormalWhite : disabledNormal),
            Text(
              'Password',
              style: (user == true) ? dataNormalWhite : disabledNormal,
            ),
            TextField(
                enabled: user,
                decoration: InputDecoration(
                  hintText: 'Type',
                  hintStyle: (user == true) ? hintText : disabledLight,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: (user == true) ? Colors.white : disableColor,
                        width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: (user == true) ? Colors.white : disableColor,
                        width: 1),
                  ),
                ),
                textAlign: TextAlign.start,
                controller: passwordController,
                style: (user == true) ? dataNormalWhite : disabledNormal),
            Center(
              child: GestureDetector(
                onTap: () async {
                  print('button clicked');
                  print(emailController.text);
                  print(passwordController.text);
                  if (olduser) {
                    AuthService()
                        .login(emailController.text, passwordController.text)
                        .then((response) async {
                          print(response);
                      const storage = FlutterSecureStorage();
                      await storage.write(key: 'token', value: response);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(token: response)));
                    });
                  } else {
                    AuthService()
                        .signup(emailController.text, passwordController.text)
                        .then((response) async {
                          print(response);
                      const storage = FlutterSecureStorage();
                      await storage.write(key: 'token', value: response);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(token: response)));
                    });
                  }
                },
                child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                      color: (user == true) ? actionColor : disableColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      buttontext,
                      style: dataBoldWhite,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        if (user == false) {
          setState(() {
            newuser = !newuser;
            olduser = !olduser;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Book Bytes'),
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
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                box(newuser, 'Signup', 'Submit'),
                box(olduser, 'Login', 'Submit')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
