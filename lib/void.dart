import 'package:flutter/material.dart';

class Void extends StatefulWidget {
  @override
  _VoidState createState() => _VoidState();
}

class _VoidState extends State<Void> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Void", style: TextStyle(fontSize: 35)),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Text("List of Void Transactions", style: TextStyle(fontSize: 35),textAlign: TextAlign.center),
      ),
    );
  }
}