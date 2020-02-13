import 'package:flutter/material.dart';
import 'package:possystem/homepage.dart';
import 'package:possystem/utils.dart';
import 'fadeAnimation.dart';
import 'package:nice_button/nice_button.dart';
import 'transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './transition.dart';
import './homepage.dart';
import 'homepage.dart';
import 'package:loading/indicator.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
void main ()async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  if(prefs.getString("userUsed")=="used"){
     // Navigator.push(BuildC, SlideRightRoute(widget: Homepage()));
     runApp(MyApp(""));
  }
  else{ 
  runApp(SignIn1());
  }
}
class SignIn1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String load="dontload";
//variable
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  
  //function
  Future<void> signinFunction(BuildContext context,int x) {
        
  return showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(10)
        ),
        
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
        title:Center( 
          child: x==1?textCustom("Invalid Username/Password!", 25, Colors.red, "style") : x==2?  textCustom("Someone already logged in!", 25, Colors.red, "style",) : textCustom("Please input all required fields", 25, Colors.red, "style",),),
        //content:Text("Kindly ask the current user to close shift.", style: TextStyle(fontSize: 25, color: Colors.red),),
        actions: <Widget>[
           Center(
             child:Container(
               width: 250,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.red, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.red,
  child: new textCustom("OK",25,Colors.red,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           )
        ],
      ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(225),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
             load=="load" ? Container(
        color: Colors.blue[500],
        child: Center(
          child: Loading(indicator: BallPulseIndicator(), size: 100.0,color: Colors.white),
        ),
      ):Container(),
      
              Padding(
              padding: EdgeInsets.only(top: .5, right: 180, left: 180,bottom: .3),
              child: FadeAnimation(1.2,Image.asset("assets/POS6.png"),
             )),
         
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: .2, bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height/1.3),
                  child: FadeAnimation(1.2,Material(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                   // child: Padding(
                     // padding: EdgeInsets.only(right: 32.0, left: 20.0),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        scrollPadding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
                        controller: username,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          icon: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child:  Icon(Icons.person_outline, size: 30,color: Colors.blue),
                          ),
                          labelText: "Username",labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    //),
                  ),
                )),
                Text(""),
                 Container(
                   margin: const EdgeInsets.only(left: 20, right: 20, top: .5, bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height/1.3),
                  child: FadeAnimation (1.2,Material(
                    elevation: 8,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  //  child: Padding(
                     // padding: EdgeInsets.only(right: 32.0, left: 20.0),
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        scrollPadding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
                        controller: password,
                         obscureText: true,
                        decoration: InputDecoration(
                          icon: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Icon(Icons.lock_outline, size: 30, color: Colors.blue,),
                          ),
                          labelText: "Password", labelStyle: TextStyle(color: Colors.black),
                        ),
                      //),
                    ),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 650.0, right: 650.0, top: 30.0),
                  child: FadeAnimation(1.0,Material( 
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(1.0),
                    shadowColor: Colors.white,
                  child: NiceButton(
                    width: 300.0,
                    radius: 60,
                    elevation: 8.0,
                    background: Colors.blue[500],
                    gradientColors: [Colors.blue, Colors.black],
                    onPressed: ()async{
                      setState(() {
                        load="load";
                      });
                  var header=  await http.post("http://192.168.1.3:424/api/User/ValidateCredentials",body:{
                      "Username":"${username.text}",
"Password":"${password.text}"
                     });
                      setState(() {
       load="dontload";
    });
                     
     int a=0;
     var reviewdata = json.decode(header.body);
     print(reviewdata);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getString("available")=="avail"){
   
      if(prefs.getString("userName")==username.text){
          Navigator.push(context, SlideRightRoute(widget: Homepage(reviewdata['_id'])));
      }
      else{
        signinFunction(context, 2);
      }
  }
  else if(username.text=="" || password.text==""){
      signinFunction(context,3);
  }
  else{
       if (reviewdata!=null){
         print(reviewdata);
              a=1;
            print("object dumaan");
                     Navigator.push(context, SlideRightRoute(widget: Homepage(reviewdata['_id'])));
                        SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setString("userUsed", "used");
  prefs.setString("userid", reviewdata['_id']);
  prefs.setString("userName", "${ reviewdata['username']}");
  prefs.setString("userPass", "${password.text}");

       }
    if(a==0){
     
        signinFunction(context, 1);
        a=1;
    }
   
   
  }
      //   Navigator.push(context, SlideRightRoute(widget: Homepage()));
   //Navigator.push(context, SlideRightRoute(widget: Homepage()));
                    },
                    text: "SIGN IN",fontSize: 40,
                    
                  ),
                ),
                )),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                
                Container(
                  child: FadeAnimation(1.2,Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        textCustom1("Trudi IT Solutions", 25, Colors.black, "style", FontWeight.bold),
                    ],
                  ),
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FadeAnimation(1.3,textCustom1("© 2020 v1.0. All rights reserved", 25, Colors.black, "style", FontWeight.bold),
                    )],
                ),
                ],
          ),
    );
  }
}