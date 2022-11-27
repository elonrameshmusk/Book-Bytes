import 'package:book_bytes_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/screens/home_screen.dart';
import 'package:book_bytes_flutter/screens/book_screen.dart';
import 'package:book_bytes_flutter/screens/bytes_screen.dart';

void main() {
  // const storage = FlutterSecureStorage();
  // dynamic token = await storage.read(key: 'token');
  // print(token);
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}
