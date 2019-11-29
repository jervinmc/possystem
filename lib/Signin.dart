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
                padding: EdgeInsets.only(left: 80,top: 0),
                child: FadeAnimation(2.1,Image.asset("assets/AUTHPOS.png"),
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
                        child: FadeAnimation(2.2,Text("SIGN IN",style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
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

                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height/1.45, vertical: 5.0),

     
                  child: FadeAnimation(2.3,Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular (30),
                   // child: Padding(
                     // padding: EdgeInsets.only(right: 32.0, left: 20.0),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.normal, fontSize: 25),
                          icon: Icon(Icons.person_outline, size: 30),
                          labelText: "Username", labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    //),
                  ),
                )),
                Text(""),
                 Container(

                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height/1.45, vertical: 5.0),

                  child: FadeAnimation (2.4,Material(
                    elevation: 5,
                     borderRadius: BorderRadius.circular (30),
                  //  child: Padding(
                     // padding: EdgeInsets.only(right: 32.0, left: 20.0),
                      child: TextField(
                         textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.black, fontStyle: FontStyle.normal, fontSize: 25),
                          icon: Icon(Icons.lock_outline, size: 30),
                          labelText: "Password", labelStyle: TextStyle(color: Colors.black),
                        ),
                      //),
                    ),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                  child: FadeAnimation(2.5,Material(
                    color: Colors.orange[400],
                    borderRadius: BorderRadius.circular(60.0),
                    shadowColor: Colors.white,
                  child: MaterialButton(
                    minWidth: 250.0,
                    height: 30.0,
                    onPressed: (){
                     Navigator.push(context, SlideRightRoute(widget: Homepage()));
                    },
                    child: Text("SIGN IN",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
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