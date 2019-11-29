import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white, size: 25),
        elevation: 0,
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Transaction History", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 10.0),
            Container(
               padding: EdgeInsets.all(10),
            ),
            Card(
              elevation: 10,
                  child: Container(
                    color: Colors.white70,
                   height: MediaQuery.of(context).size.height/1.0,
                    width: MediaQuery.of(context).size.width/1.0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                  
            ),
            ),
            )
            ],
        ),
      ),
    );
  }
}