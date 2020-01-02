import 'package:awesome_dialog/awesome_dialog.dart';
import 'transition.dart';
import 'package:flutter/material.dart';
import 'transach.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Services {
 
  
  final String id;
  final double discount;
  final double vat;
  final double subtotal;
  final double totalAmt;
  final double payment;
  Services(this.id,this.discount,this.vat,this.subtotal,this.totalAmt,this.payment);

}
class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}
 
class _TransactionState extends State<Transaction> {
  Future<List<Services>> _getServices() async {

 http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/tranheader/GetAll"),headers: {
        "Accept":"application/json"
     });
    List reviewdata=json.decode(response.body);

 
    List<Services> services = [];
  
    for(var u in reviewdata){
      
      Services service = Services(u["_id"],u["discount"],u["vat"],u["subtotal"],u["totalAmt"],u["payment"]);
       services.add(service);
    }

    print("eto ang laman $services");

    return services;
  }
  Future<void> viewdetails(BuildContext context,int x) {
        
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
          child: textCustom("Password/Username is not recognized.", 25, Colors.red, "style",),),
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
  //function..
  List tranheader=[1,1,1];

  //variable
  List<Transach> transachs;
  List <Transach> selectedtransachs;
  Transach transach;
  bool sort;
  List a;
  @override
  void initState(){
    sort = true;
    selectedtransachs = [];
    transachs = Transach.getTransachs();
    super.initState();
  }
onSortColum(int columnIndex, bool ascending){
  if (columnIndex ==1){
    if (ascending){
transachs.sort((a,b) => a.date.compareTo(b.date));
    }else{
transachs.sort((a,b,) => b.date.compareTo(a.date));
    }
  }
}
onSelectedRow(bool selected, Transach transach) async{
  setState(() {
    if (selected) {
      selectedtransachs.add(transach);
    }else{
      selectedtransachs.remove(transach);
    }
  });
}
deleteSelected() async{
  setState(() {
    if (selectedtransachs.isNotEmpty){
      List <Transach> temp = [];
      temp.addAll(selectedtransachs);
      for (Transach transach in temp){
        transachs.remove(transach);
        selectedtransachs.remove(transach);
       
        //transachs.add();
      }
    }
  });
}
  SingleChildScrollView dataBody(){
   return SingleChildScrollView(
     scrollDirection: Axis.vertical,
     child: Column(
       children: <Widget>[
         
         DataTable(
     columnSpacing: 200,
     sortAscending: sort,
     sortColumnIndex: 1,
     columns: [
       DataColumn(
         label: Text("Receipt Number", style: TextStyle(fontSize: 40)),
         numeric: false,
         tooltip: "This is the receipt",
         onSort: (columnIndex, ascending){
           setState(() {
             sort =!sort;
           });
           onSortColum(columnIndex, ascending);
         }
       ),
       DataColumn(
         label: Text("Date",style: TextStyle(fontSize: 40)),
         numeric: false,
         tooltip: "This is the date",
         onSort: (columnIndex, ascending){
           setState(() {
             sort=!sort;
           });
           onSortColum(columnIndex, ascending);
         }
       ),
       DataColumn(
         label: Text("Action", style: TextStyle(fontSize: 40)),
         numeric: false,
         tooltip: "This is the refund",
         onSort: (columnIndex, ascending){
           setState(() {
             sort =!sort;
           });
           onSortColum(columnIndex, ascending);
         }
       )
     ], rows: transachs.map((transachs) => DataRow(
       selected: selectedtransachs.contains(transachs),
       onSelectChanged: (b){
         onSelectedRow(b, transachs);
       },
       cells:[
         DataCell(
           Text(transachs.receipt),
           onTap: (){
             showDialog(
             context: context,
             builder: (BuildContext context) {
               return AlertDialog(
                 title: Text("Transaction Details",style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
                  content: Text("", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(40)),
                    actions: <Widget>[
                         FlatButton(
                           child: Text("Cancel", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         ),
                         FlatButton(
                           child: Text("OK", style: TextStyle(fontSize: 20),textAlign: TextAlign.center),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         )
                       ],
               );
             }
             );
           },
         ),
         DataCell(
           Text(transachs.date),
         ),
         DataCell(
           Text(transachs.refund),
           onTap: (){
            showDialog(
                   context: context,
                   builder: (BuildContext context){
                     return AlertDialog(
                       title: Text("",style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
                       content: Text("", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                       actions: <Widget>[
                         FlatButton(
                           child: Text("Cancel", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         ),
                         FlatButton(
                           child: Text("OK", style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         )
                       ],
                     );
                   }
                 );
           }
         ),
       ],
     ),
     ).toList(),
     )
       ],
     )
   );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        elevation: 2,
     
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        child:  Column(
          children: <Widget>[
            Container(
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         Container(padding: EdgeInsets.all(10),
                child:Center(child:  textCustom1("Receipt Number", 33, Colors.black, "",FontWeight.bold))),
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Date", 33, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Action", 33, Colors.black, "",FontWeight.bold))),
            ]
          )],
        ),
      ),
        FutureBuilder(
          future: _getServices(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
           return snapshot.data!=null?Container(
        padding: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height/1.45,
        child:  ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index){
          return  index%2==0? Container( 
            color: Colors.grey.withAlpha(40),
            child: Table(
           // border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [TableRow(
            
            children:[
                InkWell(
                  onDoubleTap: (){
                  },
                  child:   Container(padding: EdgeInsets.all(10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //idclick
                     textCustom("${snapshot.data[index].id}", 20, Colors.black, "")
                  ],
                )),
                onTap: ()async{

                     http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranDetails/GetByHeaderId/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
    var reviewdata=json.decode(response.body);
     http.Response res=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranHeader/getbyid/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
    var rev=json.decode(res.body);
    print(reviewdata);
                 showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 700,
          child: Column(
          children: <Widget>[
         Container(
           
           color: Colors.black,
           child: 
              Center( 
          child: textCustom("Transaction Details", 35, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 25, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 25, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 25, Colors.black, "style",),
              textCustom("", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
         Divider(),
         Container(
           color: Colors.black,
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("ITEM", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 27, Colors.white, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      ),
      Container(
        
        height: 150,
        child: ListView.builder(
          itemCount: reviewdata.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
               
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Expanded(
               child: Container(
                 padding: EdgeInsets.all(2),
                 child: textCustom1("${reviewdata[index]["productName"]}", 20, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 20, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 20, Colors.black, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      );

            },
        ),
       
      ),
       Divider(),
       Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Subtotal", 25, Colors.black, "style",),
              textCustom("${snapshot.data[index].subtotal}", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 25, Colors.black, "style",),
              textCustom("${snapshot.data[index].vat}", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Tax", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 25, Colors.black, "style",),
              textCustom("${snapshot.data[index].discount}", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 25, Colors.black, "style",),
              textCustom("${snapshot.data[index].totalAmt}", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 25, Colors.black, "style",),
              textCustom("${snapshot.data[index].payment}", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 25, Colors.black, "style",),
              textCustom("${snapshot.data[index].payment-snapshot.data[index].totalAmt}", 25, Colors.black, "style",),
             
           ],
         ),
       
          ],
        ),
        ),
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
            color: Colors.transparent, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.green,
  child: Icon(Icons.print,color: Colors.green,size: 50,),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
           Center(
             child:Container(
               width: 300,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.blue, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.blue,
  child: new textCustom("OK",25,Colors.blue,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
         
        ],
      ),
      );
    },
  );

                },
                ),
                //date...
                Container(padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[  
                   /* SizedBox(
                      height: 50,
                      child: StepperTouch(
                        initialValue: 1,
                      ),
                    ),*/
                     InkWell(
                        onTap: ()async{

                     http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranDetails/GetByHeaderId/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
        
     
    var reviewdata=json.decode(response.body);
     http.Response res=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranHeader/getbyid/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
    var rev=json.decode(res.body);

    print(reviewdata);

                 showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 700,
          child: Column(
          children: <Widget>[
         Container(
           
           color: Colors.black,
           child: 
              Center( 
          child: textCustom("Transaction Details", 35, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 25, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 25, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 25, Colors.black, "style",),
              textCustom("", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
         Divider(),
         Container(
           color: Colors.black,
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("ITEM", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 27, Colors.white, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      ),
      Container(
        
        height: 150,
        child: ListView.builder(
          itemCount: reviewdata.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
               
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Expanded(
               child: Container(
                 padding: EdgeInsets.all(2),
                 child: textCustom1("${reviewdata[index]["productName"]}", 20, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 20, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 20, Colors.black, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      );

            },
        ),
       
      ),
       Divider(),
       Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Subtotal", 25, Colors.black, "style",),
              textCustom("${rev["subtotal"]}", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Tax", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
       
          ],
        ),
        ),
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
            color: Colors.transparent, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.green,
  child: Icon(Icons.print,color: Colors.green,size: 50,),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
           Center(
             child:Container(
               width: 300,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.blue, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.blue,
  child: new textCustom("OK",25,Colors.blue,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
         
        ],
      ),
      );
    },
  );

                },
                        child:  textCustom("2019/10/10", 25, Colors.black, "style"),
                      ),
              

                  ],
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                   InkWell(
                     onTap: ()async{
                       
                     http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranDetails/GetByHeaderId/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
        
     
    var reviewdata=json.decode(response.body);
     http.Response res=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranHeader/getbyid/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
    var rev=json.decode(res.body);

    print(reviewdata);

                 showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 700,
          child: Column(
          children: <Widget>[
         Container(
           
           color: Colors.black,
           child: 
              Center( 
          child: textCustom("Transaction Details", 35, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 25, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 25, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 25, Colors.black, "style",),
              textCustom("", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
         Divider(),
         Container(
           color: Colors.black,
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("ITEM", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 27, Colors.white, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      ),
      Container(
        
        height: 150,
        child: ListView.builder(
          itemCount: reviewdata.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
               
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Expanded(
               child: Container(
                 padding: EdgeInsets.all(2),
                 child: textCustom1("${reviewdata[index]["productName"]}", 20, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 20, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 20, Colors.black, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      );

            },
        ),
       
      ),
       Divider(),
       Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Subtotal", 25, Colors.black, "style",),
              textCustom("${rev["subtotal"]}", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Tax", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
       
          ],
        ),
        ),
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
            color: Colors.transparent, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.green,
  child: Icon(Icons.print,color: Colors.green,size: 50,),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
           Center(
             child:Container(
               width: 300,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.blue, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.blue,
  child: new textCustom("OK",25,Colors.blue,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
         
        ],
      ),
      );
    },
  );
                     },
                     child:   InkWell(
                       onTap: ()async{
                         
                     http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranDetails/GetByHeaderId/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
        
     
    var reviewdata=json.decode(response.body);
     http.Response res=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranHeader/getbyid/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
    var rev=json.decode(res.body);

    print(reviewdata);

                 showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 700,
          child: Column(
          children: <Widget>[
         Container(
           
           color: Colors.black,
           child: 
              Center( 
          child: textCustom("Transaction Details", 35, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 25, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 25, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 25, Colors.black, "style",),
              textCustom("", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
         Divider(),
         Container(
           color: Colors.black,
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("ITEM", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 27, Colors.white, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      ),
      Container(
        
        height: 150,
        child: ListView.builder(
          itemCount: reviewdata.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
               
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Expanded(
               child: Container(
                 padding: EdgeInsets.all(2),
                 child: textCustom1("${reviewdata[index]["productName"]}", 20, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 20, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 20, Colors.black, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      );

            },
        ),
       
      ),
       Divider(),
       Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Subtotal", 25, Colors.black, "style",),
              textCustom("${rev["subtotal"]}", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Tax", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
       
          ],
        ),
        ),
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
            color: Colors.transparent, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.green,
  child: Icon(Icons.print,color: Colors.green,size: 50,),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
           Center(
             child:Container(
               width: 300,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.blue, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.blue,
  child: new textCustom("OK",25,Colors.blue,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),
                 ],
               ),
               )
             )
           ),
         
        ],
      ),
      );
    },
  );
 },
            child: Container(
                       padding: EdgeInsets.only(left: 50),
                       child:  textCustom("Refund", 20, Colors.black, ""),
                     ),
                     )
                   )
                     // VerticalDivider(),
                    ],
                  ),
                ),
              ],
            ),
            ]
          )],
      
        ),
          ): Container(
            color: Colors.white.withAlpha(50),
            child: Table(
           // border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [TableRow(
            children:[
              InkWell(
                child:   Container(padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    textCustom("${snapshot.data[index].id}", 20, Colors.black, ""),
                  ],
                )),
                onTap: ()async{

                     http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranDetails/GetByHeaderId/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
        
     
    var reviewdata=json.decode(response.body);
     http.Response res=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranHeader/getbyid/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
    var rev=json.decode(res.body);

    print(reviewdata);

                 showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 700,
          child: Column(
          children: <Widget>[
         Container(
           
           color: Colors.black,
           child: 
              Center( 
          child: textCustom("Transaction Details", 35, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 25, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 25, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 25, Colors.black, "style",),
              textCustom("", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
         Divider(),
         Container(
           color: Colors.black,
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("ITEM", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 27, Colors.white, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      ),
      Container(
        
        height: 150,
        child: ListView.builder(
          itemCount: reviewdata.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
               
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Expanded(
               child: Container(
                 padding: EdgeInsets.all(2),
                 child: textCustom1("${reviewdata[index]["productName"]}", 20, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 20, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 20, Colors.black, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      );

            },
        ),
       
      ),
       Divider(),
       Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Subtotal", 25, Colors.black, "style",),
              textCustom("${rev["subtotal"]}", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Tax", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
       
          ],
        ),
        ),
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
            color: Colors.transparent, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.green,
  child: Icon(Icons.print,color: Colors.green,size: 50,),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
           Center(
             child:Container(
               width: 300,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.blue, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.blue,
  child: new textCustom("OK",25,Colors.blue,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
         
        ],
      ),
      );
    },
  );
                },
              ),
            Container(padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[  
                   /* SizedBox(
                      height: 50,
                      child: StepperTouch(
                        initialValue: 1,
                      ),
                    ),*/
             
                    
                     InkWell(
                        onTap: ()async{
                          
                     http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranDetails/GetByHeaderId/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
        
     
    var reviewdata=json.decode(response.body);
     http.Response res=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranHeader/getbyid/${snapshot.data[index].id}"),headers: {
        "Accept":"application/json"
     });
    var rev=json.decode(res.body);

    print(reviewdata);

                 showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 700,
          child: Column(
          children: <Widget>[
         Container(
           
           color: Colors.black,
           child: 
              Center( 
          child: textCustom("Transaction Details", 35, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 25, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 25, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 25, Colors.black, "style",),
              textCustom("", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
         Divider(),
         Container(
           color: Colors.black,
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("ITEM", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 27, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 27, Colors.white, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      ),
      Container(
        
        height: 150,
        child: ListView.builder(
          itemCount: reviewdata.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
               
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Expanded(
               child: Container(
                 padding: EdgeInsets.all(2),
                 child: textCustom1("${reviewdata[index]["productName"]}", 20, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 20, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 20, Colors.black, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      );

            },
        ),
       
      ),
       Divider(),
       Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Subtotal", 25, Colors.black, "style",),
              textCustom("${rev["subtotal"]}", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Tax", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 25, Colors.black, "style",),
              textCustom("0", 25, Colors.black, "style",),
             
           ],
         ),
       
          ],
        ),
        ),
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
            color: Colors.transparent, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.green,
  child: Icon(Icons.print,color: Colors.green,size: 50,),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
           Center(
             child:Container(
               width: 300,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.blue, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.blue,
  child: new textCustom("OK",25,Colors.blue,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),


                 ],
               ),
               )
             )
           ),
         
        ],
      ),
      );
    },
  );
                        },
                        child:  textCustom("2019/10/10", 25, Colors.black, "style"),
                      ),
              
                    
                    
                     

                  ],
                )
             ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    
                      Container(
                       padding: EdgeInsets.only(left: 50),
                       child:  textCustom("Refund", 20, Colors.black, ""),
                     ),
                  
                   
                    ],
                  ),
                ), 
              ],
            ),               
            ]
          )],
      
        ),
          );
        },
      ),
      ) : Container();
          },
        ),
       Container(
         padding: EdgeInsets.all(20),
         width: double.infinity,
         child: 
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
              textCustom("TOTAL SALES", 40, Colors.black, "style"),
            textCustom("50", 40, Colors.black, "style"),
         ],
       ),
       )
          ],
        )
      )
    );
  }
}