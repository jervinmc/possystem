import 'buttonSigninanimation.dart';
import 'customTextfield.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'fadeAnimation.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}
class _SignInState extends State<SignIn> {

    final TextEditingController username_controller = new TextEditingController();
    final TextEditingController password_controller = new TextEditingController();

 

  @override
  void initState(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/POS.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              )
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text("", style: TextStyle(fontSize: 40, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 2),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: Colors.black87, size: 35),
                            onPressed: (){
                              Navigator.pop(context);
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 500, vertical: 50),
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(4.5, Text("Welcome to POS", style: TextStyle(
                          color: Colors.orange[300],
                          fontSize: 70,
                          letterSpacing: .5,
                          fontWeight: FontWeight.bold
                        ))),
                        FadeAnimation(5.5,Text("Sign in to continues", style: TextStyle(
                          fontSize: 35,
                          letterSpacing: .5,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold
                        ))),
                        /*SizedBox(height: 5),
                        FadeAnimation(6.5, CustomTextfield(
                          label: "Username",
                        )),
                        SizedBox(height: 5),
                         FadeAnimation(7.5,CustomTextfield(
                          label: "Password",
                          isPassword: true,
                        )),*/
                        SizedBox(height: 8),
                        FadeAnimation(8.5,ButtonSigninAnimation(
                          label: "SIGN IN",
                          fontColor: Colors.black87,
                          background: Colors.transparent,
                          borderColor: Colors.transparent,
                          child: Homepage(),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Homepage()));
                          }
                        ),
                        )],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}