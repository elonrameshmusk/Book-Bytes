import 'package:book_bytes_flutter/screens/auth_screen.dart';
import 'package:book_bytes_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
class WrapperScreen extends StatefulWidget {
  const WrapperScreen({Key? key}) : super(key: key);

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}
