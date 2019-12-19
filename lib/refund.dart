import 'package:flutter/material.dart';

class Refund extends StatefulWidget {
  @override
  _RefundState createState() => _RefundState();
}

class _RefundState extends State<Refund> {
  
  TextEditingController controller = new TextEditingController();
  
  

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
         color: Colors.transparent,
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Card(
             child: ListTile(
               leading: Icon(Icons.search),
               title: TextField(
                 textCapitalization: TextCapitalization.sentences,
                 controller: controller,
                 decoration: InputDecoration(
                   hintText: "Search", border: InputBorder.none),
               ),
                trailing: IconButton(icon: Icon(Icons.cancel),
                onPressed: (){
                  controller.clear();
                },),
               ),
           ),
         ),
        ),
        Expanded(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              )
            ],
          ),
        )
        ],
      ),
    );
  }
}