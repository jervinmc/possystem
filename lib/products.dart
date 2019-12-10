import 'package:flutter/material.dart';
import 'package:possystem/homepage.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white60,
      body: Container(
        child: Stack(
          children: <Widget>[
            Image.asset("assets/prod.gif",
            ),
            Positioned(child: FloatingActionButton(
              elevation: 0,
              child: Image.asset("assets/heart.png",
              width: 100,
              height: 100,),
              backgroundColor: Colors.white,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
              },
            ),
            bottom: 0,
            right: 20,
            )
          ],
        ),
      ),
    );
  }
}