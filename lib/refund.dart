import 'package:flutter/material.dart';
import 'utils.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class Refund extends StatefulWidget {
  @override
  _RefundState createState() => _RefundState();
}

class _RefundState extends State<Refund> {
  List productName=[];
  List quantity=[];
  List price=[];
  List refunditem=[];

  TextEditingController controller = new TextEditingController();
  TextEditingController search = new TextEditingController();

  void search1()async{
    
    refunditem.clear();

    http.Response response = await http.get(Uri.encodeFull("http://192.168.1.3:424/Api/TranDetails/GetByHeaderId/${controller.text}"),headers: {
        "Accept":"application/json"
     });
     var reviewdata = json.decode(response.body);
     print(reviewdata);
     for (int x = 0; x < reviewdata.length; x++){
       print("CHECK CHECK CHECK");
        
        setState(() {
           refunditem.add(reviewdata[x]['productName']);
        });
      
       print("${refunditem[x]}");

        
     }
     controller.text = "";
     
     
  }

  
  // Refund
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Refund", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
      ),
      // search bar
      body: Column(
        children: <Widget>[
          Container(
         color: Colors.transparent,
         child: Padding(
           padding: const EdgeInsets.all(10.0),
           child: Card(
             child: ListTile(
              // leading: Icon(Icons.search, color: Colors.black),
               title: TextField(
                 onTap: (){
                    print("REFUND RESULT");
                        search1();
                 },
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
        Container(
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
               Container(padding: EdgeInsets.all(5),
                child: Center(child:  textCustom1("ITEM", 33, Colors.black, "",FontWeight.bold))),
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 33, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("PRICE", 33, Colors.black, "",FontWeight.bold))),
            ],
          )],
        ),
      ),
        Container(
          padding: EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height/1.45,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: refunditem.length,
            itemBuilder: (BuildContext context, int index){
              return index%2==0? Container(
                color: Colors.grey.withAlpha(40),
                child: Table(
                  children: [TableRow(
                    children: [
                      InkWell(
                        onDoubleTap: (){

                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: textCustom("${refunditem[index]}", 20, Colors.black, "")),
                          onTap: (){

                          },
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.red),
                              onPressed: (){
                                setState(() {
                                  
                                });
                              },
                            ),
                            InkWell(
                              onTap: (){

                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.green),
                              onPressed: (){
                                setState(() {
                                  
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ]
                  )],
                ),
              ): Container(
                color: Colors.white,
                child: Table(
                  children: [TableRow(
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: textCustom("${refunditem[index]}", 20, Colors.black, "")),
                          onTap: (){},
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove, color:Colors.red),
                              onPressed: (){

                              },
                            ),
                            InkWell(
                              onTap: (){

                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.green,),
                              onPressed: (){

                              },
                            )
                          ],
                        ),
                      ),
                    ]
                  ),
                  ],
                ),
                
              );
            }
          )
        ),
          ],
          )
        );
  }
}