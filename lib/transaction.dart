import 'package:flutter/material.dart';
import 'transach.dart';
import 'utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Services {
 
  
  final String id;
  final double discount;
  final double vat;
  final double subtotal;
  final double totalAmt;
  final double payment;
  final double memberPoints;
  final String dateTime;
  Services(this.id,this.discount,this.vat,this.subtotal,this.totalAmt,this.payment,this.memberPoints,this.dateTime);

}
class Transaction extends StatefulWidget {
  String openingAmt;
  List tranhistory;
  double totalamount;
  Transaction(this.openingAmt,this.tranhistory,this.totalamount);
  @override
  _TransactionState createState() => _TransactionState(openingAmt,tranhistory,totalamount);
}
 
class _TransactionState extends State<Transaction> {
  String openingAmt;
   List tranhistory;
   double totalamount;
  _TransactionState(this.openingAmt,this.tranhistory,this.totalamount);
  Future<List<Services>> _getServices() async {

 http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/tranheader/GetAll"),headers: {
        "Accept":"application/json"
     });
    List reviewdata=json.decode(response.body);

  int x=0;
    List<Services> services = [];
    if(getSearchReceipt==""){
       for(var u in reviewdata){
      
      Services service = Services(u["_id"],u["discount"],u["vat"],u["subtotal"],u["totalAmt"],u["payment"],u["memberPoints"],u["datetime"]);
       
      
       services.add(service);
    }
    }
    else{
       for(var u in reviewdata){
      
      Services service = Services(u["_id"],u["discount"],u["vat"],u["subtotal"],u["totalAmt"],u["payment"],u["memberPoints"],u["datetime"]);
       
      if(getSearchReceipt==reviewdata[x]['_id']){
           services.add(service);
           print("may pumasok");
      }
      x++;
    }
   
    }
  
    if(services==null){

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
  TextEditingController receiptText=new TextEditingController();
  //variable
  String getSearchReceipt="";
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
         Container(
           child:   Card(
                      
      elevation: 2,
       shape: BeveledRectangleBorder(
        
    borderRadius: BorderRadius.circular(5.0),),
      child: TextField(
    textAlign: TextAlign.start,  
 
    onChanged: (value){
        setState(() {
         
        });
    },
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
     
        icon: Container(
          padding: EdgeInsets.only(left: 15),
          height: 50,
          width: 70,
          child: InkWell(
            onTap: (){
              
            //  enterBarcode();
            //  searchCtrlr.text="";
              
            },
            child: Image.asset("assets/q3.png", fit: BoxFit.cover,),
          )

        ),
        hintText: 'ENTER RECEIPT NO.',
        hintStyle: TextStyle(fontSize: 40),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                width: 0, 
                style: BorderStyle.none,
            ),
        ),
        filled: false,
        contentPadding: EdgeInsets.all(16),
        fillColor: Colors.white
    ),
),
    ),
         ),
         DataTable(
     columnSpacing: 200,
     sortAscending: sort,
     sortColumnIndex: 1,
     columns: [
       
       DataColumn(
         label: Text("Receipt NumberS", style: TextStyle(fontSize: 20)),
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
         label: Text("Date",style: TextStyle(fontSize: 20)),
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
         label: Text("Action", style: TextStyle(fontSize: 20)),
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
                 title: Text("Transaction Details", style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
                  content: Text("", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10)),
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
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                       actions: <Widget>[
                         FlatButton(
                           child: Text("Cancel", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
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
        backgroundColor: Color(0xFFF95700),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        elevation: 2,
        actions: <Widget>[
         
     
       
        ],
     
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
        child:  Column(
          children: <Widget>[
             Container(
           child:   Card(
                      
      elevation: 2,
       shape: BeveledRectangleBorder(
        
    borderRadius: BorderRadius.circular(5.0),),
      child: TextField(
    textAlign: TextAlign.start ,  
    controller: receiptText,
    onChanged: (value){
        setState(() {
         
        });
    },
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
     
        icon: Container(
          padding: EdgeInsets.only(left: 15),
          height: 50,
          width: 70,
          child: InkWell(
            onTap: (){
            // input the receipt no. for searching.
            setState(() {
               getSearchReceipt=receiptText.text;
            });
           
              
            },
            child: Image.asset("assets/q3.png", fit: BoxFit.cover,),
          )

        ),
        hintText: 'ENTER RECEIPT NO.', 
        hintStyle: TextStyle(fontSize: 20,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                width: 0, 
                style: BorderStyle.none,
            ),
        ),
        filled: false,
        contentPadding: EdgeInsets.all(16),
        fillColor: Colors.white
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
         Container(padding: EdgeInsets.all(10),   
                child:Center(child:  textCustom1("Receipt Number", 25, Colors.black, "",FontWeight.bold))),
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Date", 25, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Action", 25, Colors.black, "",FontWeight.bold))),
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
        itemCount: getSearchReceipt!="" ? snapshot.data.length : tranhistory.length,
        itemBuilder: (BuildContext context, int index){
           DateTime dateTime = DateTime.parse(snapshot.data[index].dateTime);
                    String dates = DateFormat('dd-MM-yyyy').format(dateTime);
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
          child: textCustom("Transaction Details", 30, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 20, Colors.black, "style",),
              textCustom("${dates}", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 20, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 20, Colors.black, "style"),
              textCustom("", 20, Colors.black, "style"),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].memberPoints).output.nonSymbol}", 20, Colors.black, "style",),
             
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
                child: Center(child:  textCustom1("ITEM", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 22, Colors.white, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      ),
      Container(
        
        height: 165,
        child: Scrollbar(
        
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
                 child: textCustom1("${reviewdata[index]["productName"]}", 15, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1(
                  "${reviewdata[index]["quantity"]}", 15, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${FlutterMoneyFormatter(amount:reviewdata[index]["amount"]).output.nonSymbol}", 15, Colors.black, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      );

            },
        ),
        )
       
      ),
       Divider(),
       Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Subtotal", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].subtotal).output.nonSymbol}", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].vat).output.nonSymbol}", 20, Colors.black, "style",),
             
           ],
         ),
      
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].discount).output.nonSymbol}", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt).output.nonSymbol}", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].payment).output.nonSymbol}", 20, Colors.black, "style",),
             
           ],
         ),
         Divider(),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].payment-snapshot.data[index].totalAmt).output.nonSymbol}", 20, Colors.green, "style",),
             
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
                        child:  textCustom("${dates}", 25, Colors.black, "style"),
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
          child: textCustom("Transaction Details", 30, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 20, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 20, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 20, Colors.black, "style",),
              textCustom("", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
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
                child: Center(child:  textCustom1("ITEM", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 22, Colors.white, "",FontWeight.bold))),
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
                 child: textCustom1("${reviewdata[index]["productName"]}", 15, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 15, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 15, Colors.black, "",FontWeight.bold))),
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
              textCustom("Subtotal", 20, Colors.black, "style",),
              textCustom("${rev["subtotal"]}", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
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
          child: textCustom("Refund", 35, Colors.white, "style",),),
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
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red),
                        onPressed: (){
                          setState(() {
                            
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: (){
                          setState(() {
                            
                          });
                        },
                      )
                    ],
                  ),
                )
            ],

            
          ),
          ],
        ),
      );

            },
        ),
       
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
        )
        )
      );
    },
  );
 },
            child: Container(
                       padding: EdgeInsets.only(left: 50),
                       child:  textCustom("Refund", 20, Colors.black, ""),
                     ),
                     ),
                   ),
                     // VerticalDivider(),
                    ],
                  ),
                ),
              ],
            ),
            ]
          )],
      
        ),
          ):Container( 
            color: Colors.white,
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
          child: textCustom("Refund", 35, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 25, Colors.black, "style",),
              textCustom("${dates}", 25, Colors.black, "style",),
             
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
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].memberPoints).output.nonSymbol}", 25, Colors.black, "style",),
             
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
          child: Center(child:  textCustom1("${FlutterMoneyFormatter(amount:reviewdata[index]["amount"]).output.nonSymbol}", 20, Colors.black, "",FontWeight.bold))),
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
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].subtotal).output.nonSymbol}", 25, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 25, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].vat).output.nonSymbol}", 25, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 25, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].discount).output.nonSymbol}", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 25, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt).output.nonSymbol}", 25, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 25, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].payment).output.nonSymbol}", 25, Colors.black, "style",),
             
           ],
         ),
         Divider(),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 25, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].payment-snapshot.data[index].totalAmt).output.nonSymbol}", 25, Colors.green, "style",),
             
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
          child: textCustom("Transaction Details", 30, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 20, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 20, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 20, Colors.black, "style",),
              textCustom("", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
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
                child: Center(child:  textCustom1("ITEM", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 22, Colors.white, "",FontWeight.bold))),
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
                 child: textCustom1("${reviewdata[index]["productName"]}", 15, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 15, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 15, Colors.black, "",FontWeight.bold))),
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
              textCustom("Subtotal", 20, Colors.black, "style",),
              textCustom("${rev["subtotal"]}", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
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
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))),
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
                   mainAxisAlignment: MainAxisAlignment.center,
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
                        child:  textCustom("${dates}", 25, Colors.black, "style"),
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
          child: textCustom("Transaction Details", 30, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 20, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 20, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 20, Colors.black, "style",),
              textCustom("", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
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
                child: Center(child:  textCustom1("ITEM", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 22, Colors.white, "",FontWeight.bold))),
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
                 child: textCustom1("${reviewdata[index]["productName"]}", 15, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 15, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 15, Colors.black, "",FontWeight.bold))),
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
              textCustom("Subtotal", 20, Colors.black, "style",),
              textCustom("${rev["subtotal"]}", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Tax", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
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
          child: textCustom("Transaction Details", 30, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 20, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 20, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 20, Colors.black, "style",),
              textCustom("", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
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
                child: Center(child:  textCustom1("ITEM", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 22, Colors.white, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
          child: Center(child:  textCustom1("AMOUNT", 22, Colors.white, "",FontWeight.bold))),
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
                 child: textCustom1("${reviewdata[index]["productName"]}", 15, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 15, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 15, Colors.black, "",FontWeight.bold))),
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
              textCustom("Subtotal", 20, Colors.black, "style",),
              textCustom("${rev["subtotal"]}", 20, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("VAT", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Tax", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Discount", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Payment", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
           Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
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
          );
        },
      ),
      ) : Container();
          },
        ),
      
          ],
        )
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: 
       Container(
         padding: EdgeInsets.all(20),
         width: 1650,
         child:Column(
           children: <Widget>[
             Divider(
               height: 5,
               
             ),
              Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Opening Amount:", 25, Colors.black, "style"),
          
              textCustom1("Php ${FlutterMoneyFormatter(amount:double.parse(openingAmt)).output.nonSymbol}", 25, Colors.black, "style",FontWeight.bold)
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Total Amount:", 25, Colors.black, "style"),
             
              textCustom1("Php ${FlutterMoneyFormatter(amount:totalamount).output.nonSymbol}", 25, Colors.black, "style",FontWeight.bold)
           ],
         ),
           ],
         )
       ),
      )
        ],
      )
    );
  }
}