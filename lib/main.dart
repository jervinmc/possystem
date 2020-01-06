import 'package:flutter/material.dart';
import 'package:possystem/homepage.dart';
import 'package:possystem/utils.dart';
import 'fadeAnimation.dart';
import 'transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './transition.dart';
import './homepage.dart';
import 'homepage.dart';
void main ()async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  if(prefs.getString("userUsed")=="used"){
     // Navigator.push(BuildC, SlideRightRoute(widget: Homepage()));
     runApp(MyApp());
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
      
    );
  }
}
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
          borderRadius:BorderRadius.circular(15)
        ),
        
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Center( 
          child: x==1?textCustom("Invalid Username/Password", 25, Colors.red, "style"): textCustom("Current shift not yet closed", 25, Colors.red, "style"),),
        content:Text(""),
        actions: <Widget>[
           Center(
             child:Container(
               width: 300,
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
    return Scaffold(
      backgroundColor: Colors.white12,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 2,top: 1, right: 2),
                child: FadeAnimation(2.9,Image.asset("assets/POS.png"),
              )),
              Padding(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        height: 15.0,
                        color: Colors.transparent,
                      ),),
                      Expanded(
                        child: Divider(
                          height: 15.0,
                          color: Colors.transparent,
                        ),
                      ),
                  ],
                ),
                ),
                Container( 
                  padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height/1.5, vertical: 5.0),
                  child: FadeAnimation(2.9,Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular (50),
                   // child: Padding(
                     // padding: EdgeInsets.only(right: 32.0, left: 20.0),
                      child: TextField(
                        controller: username,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          icon:Container(
                            padding: EdgeInsets.only(left: 20),
                            child:  Icon(Icons.person_outline, size: 40),
                          ),
                          labelText: "Username", labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    //),
                  ),
                )),
                Text(""),
                 Container(

                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height/1.5, vertical: 5.0),

                  child: FadeAnimation (2.9,Material(
                    elevation: 5,
                     borderRadius: BorderRadius.circular (50),
                  //  child: Padding(
                     // padding: EdgeInsets.only(right: 32.0, left: 20.0),
                      child: TextField(
                        controller: password,
                         obscureText: true,
                        decoration: InputDecoration(
                          icon: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(Icons.lock_outline, size: 40),
                          ),
                          labelText: "Password", labelStyle: TextStyle(color: Colors.black),
                        ),
                      //),
                    ),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                  child: FadeAnimation(2.9,Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(60.0),
                    shadowColor: Colors.white,
                  child: MaterialButton(
                    minWidth: 250.0,
                    height: 35.0,
                    onPressed: ()async{
                  
                      http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/User/GetAll"),headers: {
                     "Accept":"application/json"
     });
     int a=0;
     var reviewdata = json.decode(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getString("available")=="avail"){
      if(prefs.getString("userName")==username.text){
          Navigator.push(context, SlideRightRoute(widget: Homepage(username.text)));
      }
      else{
        signinFunction(context, 2);
      }
  }
  else{
     for (int x = 0; x < reviewdata.length; x++) { 
       if (username.text == reviewdata[x]['firstname'] ){
              a=1;
            print("object dumaan");
                     Navigator.push(context, SlideRightRoute(widget: Homepage(reviewdata[x]['firstname'])));
                        SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setString("userUsed", "used");
  prefs.setString("userName", "${ reviewdata[x]['firstname']}");
  prefs.setString("userPass", "used");

       }
     }
    if(a==0){
        signinFunction(context, 1);
        a=1;
    }

  }

   
    


      //   Navigator.push(context, SlideRightRoute(widget: Homepage()));
   //Navigator.push(context, SlideRightRoute(widget: Homepage()));
                    },
                    child: Text("SIGN IN",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
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