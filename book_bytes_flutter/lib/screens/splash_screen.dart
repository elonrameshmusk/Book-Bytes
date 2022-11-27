import 'dart:async';
import 'package:flutter/material.dart';
import 'package:book_bytes_flutter/screens/wrapper_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                const WrapperScreen()
            )
        )
    );


  }
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Not welcome!'),
        ),
      ),
    );
  }
}
