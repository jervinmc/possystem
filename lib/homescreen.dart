import 'package:possystem/homepage.dart';
import 'package:possystem/signin.dart';
import 'transition.dart';
import 'fadeAnimation.dart';
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
          Image.asset("assets/1.png", fit: BoxFit.fitWidth),
          Container(
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/2,
            color: Color(0xFFF001117).withOpacity(0.1),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 500),
            margin: EdgeInsets.only(top: 50, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                    FadeAnimation(2, Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("AUTH",
                    style: TextStyle(color: Colors.orange.withOpacity(.8),
                     fontStyle: FontStyle.italic,
                     fontSize: 50,
                     letterSpacing: 2,
                     ),
                    ),
                    Text("POS",
                    style: TextStyle(color: Colors.white.withOpacity(.8),
                     fontStyle: FontStyle.italic,
                     fontSize: 50,
                     letterSpacing: 2,
                     ),
                    )
                      ],
                    )),
                    SizedBox(height: 15),
                    FadeAnimation(1.3, Text("Infinite Possibilities",
                    style: TextStyle(color: Colors.white.withOpacity(.65),
                    fontSize: 33,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                     height: 1.4),)),
                    SizedBox(height: 170),
                     Center(
                        child: Container(
                          width: 100,
                          height: 90,
                          padding: EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.black.withOpacity(.6)
                          ),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, SlideRightRoute(widget: SignIn()));
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orange
                                ),
                                child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
              ],
            ),
                )
        ]
      )
          );
  }
}