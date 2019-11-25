import 'fadeAnimation.dart';
import 'customButton.dart';
import 'customButtonAnimation.dart';
import 'SignIn.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/t2.jpg", fit: BoxFit.fitWidth),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFFF001117).withOpacity(0.5),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 500),
            margin: EdgeInsets.only(top: 100, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  FadeAnimation(4.4,Text("", style: TextStyle(
                  color: Colors.orange[300],
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  letterSpacing: 1
                ))),
                  FadeAnimation(3.2,Text("", style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold
                ))),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 300),
                ),
                    SizedBox(height: 20),
                      FadeAnimation(3.2,CustomButtonAnimation1(
                      label: "SIGN IN",
                      background: Colors.transparent,
                      borderColor: Colors.transparent,
                      fontColor: Colors.black87,
                      child: SignIn(),
                      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context) => SignIn()));
                      }
                    )),
                    SizedBox(height: 35),
                  ],
                )
          )],
            ),
          );
  }
}