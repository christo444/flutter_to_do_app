import 'package:flutter/material.dart';
import 'package:to_do_app_1/presentation/home_screen.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    waitSplash();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/loading.gif'),
          Text("To do App",style: TextStyle(fontSize: 30),)
        ],
      )));
  }
  waitSplash()async{
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context,).push(MaterialPageRoute(builder: (context) => ScreenHome()));
  }
}