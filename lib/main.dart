import 'homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './transition.dart';
import './homepage.dart';
void main ()async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  if(prefs.getString("userUsed")=="used"){
     // Navigator.push(BuildC, SlideRightRoute(widget: Homepage()));
     runApp(MyApp());
  }
  else{ 
  runApp(POS());
  }

}

class POS extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POS12s',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
