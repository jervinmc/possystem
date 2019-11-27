import 'package:flutter/material.dart';
import 'package:possystem/homepage.dart';
import 'fadeAnimation.dart';
import 'transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: FadeAnimation(2.5,Image.asset("assets/POSHUB.png"),
              )),
              Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        height: 5.0,
                        color: Colors.transparent,
                      ),),
                      Expanded(
                        child: FadeAnimation(2.5,Text("SIGN IN",style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                        ),
                        textAlign: TextAlign.center,
                        ),
                      )),
                      Expanded(
                        child: Divider(
                          height: 5.0,
                          color: Colors.transparent,
                        ),
                      )
                  ],
                ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 720.0, vertical: 5.0),
                  child: FadeAnimation(2.6,Material(
                    elevation: 5,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: EdgeInsets.only(right: 32.0, left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.normal, fontSize: 25),
                          icon: Icon(Icons.person_outline, size: 30),
                          labelText: "Username", labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                )),
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 720.0, vertical: 5.0),
                  child: FadeAnimation (2.7,Material(
                    elevation: 5,
                    shape: StadiumBorder(),
                    child: Padding(
                      padding: EdgeInsets.only(right: 32.0, left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.normal, fontSize: 25),
                          icon: Icon(Icons.vpn_key, size: 30),
                          labelText: "Password", labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                  child: FadeAnimation(2.8,Material(
                    color: Colors.orange.withOpacity(.8),
                    borderRadius: BorderRadius.circular(50.0),
                    shadowColor: Colors.black,
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 30.0,
                    onPressed: (){
                     Navigator.push(context, SlideRightRoute(widget: Homepage()));
                    },
                    child: Text("Sign In",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                    ),),
                  ),
                )
                )),
            ],
          ),
        ],
      ),
    );
  }
}