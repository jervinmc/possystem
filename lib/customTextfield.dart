import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {

  final String label;
  final Widget icon;
  final bool isPassword;

  const CustomTextfield({Key key,
   this.label,
    this.icon,
     this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
      obscureText: isPassword,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.black87,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
          fontSize: 35),
      ),
    );
  }
}