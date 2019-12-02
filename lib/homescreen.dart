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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("AUTH",
                    style: TextStyle(color: Colors.orange.withOpacity(.8),
                     fontStyle: FontStyle.italic,
                     fontWeight: FontWeight.bold,
                     fontSize: 70,
                     letterSpacing: 2,
                     ),
                    ),
                    Text("POS",
                    style: TextStyle(color: Colors.white.withOpacity(.8),
                     fontStyle: FontStyle.italic,
                     fontSize: 30,
                     letterSpacing: 1.8,
                     fontWeight: FontWeight.bold
                     ),
                    )
                      ],
                    )),
                    SizedBox(height: 10),
                    FadeAnimation(1.3, Text(".Welcome to AUTHentic Point of Sales.",
                    style: TextStyle(color: Colors.white54,
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontStyle: FontStyle.italic,
                     height: 2.5),)),
                    SizedBox(height: 200),
                     Center(
                        child: Container(
                          width: 100,
                          height: 90,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.grey.withOpacity(.6)
                          ),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, SlideRightRoute(widget: SignIn()));
                              },
                              child: Container(
                                width: 60,
                                height: 0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orange
                                ),
                                child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
              ],
            ),
                ),
        ],
      ),
          );
  }
}