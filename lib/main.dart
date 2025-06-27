
import 'package:flutter/material.dart';
import 'package:to_do_app_1/presentation/home_screen.dart';

void main(){
  runApp(MainApp());

}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: ScreenHome(),
      ),
    );
  }
}