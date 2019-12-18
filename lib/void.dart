import 'package:flutter/material.dart';

class Void extends StatefulWidget {
  @override
  _VoidState createState() => _VoidState();
}

class _VoidState extends State<Void> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Void", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        
      ),
    );
  }
}