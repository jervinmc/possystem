import 'package:flutter/material.dart';
import 'package:sunmi_aidl_print/sunmi_aidl_print.dart' as prefix0;
import 'transach.dart';
import 'utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fadeAnimation.dart';
import 'package:sunmi_aidl_print/sunmi_aidl_print.dart';
class Services {
 

  final String headerId;
  final String productName;
  final double sellingPrice;
  final int quantity;
  final double amount;
  
  Services(this.headerId,this.productName,this.sellingPrice,this.quantity,this.amount);

}
class Reporting extends StatefulWidget {
  String openingAmt;
  List tranhistory;
  double totalamount;
  Reporting(this.openingAmt,this.tranhistory,this.totalamount);
  @override
  _ReportingState createState() => _ReportingState(openingAmt,tranhistory,totalamount);
}
 
class _ReportingState extends State<Reporting> {
  String openingAmt;
   List tranhistory;
   double totalamount;
  _ReportingState(this.openingAmt,this.tranhistory,this.totalamount);
  Future<List<Services>> _getServices() async {

 http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/voidTdetails/GetAll"),headers: {
        "Accept":"application/json"
     });
    List reviewdata=json.decode(response.body);

  int x=0;
    List<Services> services = [];
    if(getSearchReceipt==""){
       for(var u in reviewdata){
             print("may pumasok ${u["headerId"]}");
             print("may pumasoks $tranhistory");
      Services service = Services(u["headerId"],u["productName"],u["sellingPrice"],u["quantity"],u["amount"]);
         print("may pumasok");
      if(tranhistory.contains(u["headerId"])){
            services.add(service);
          
      }
      else{
 print("walang pumasok");
      }
    }
    }
    else{
       for(var u in reviewdata){

      
      Services service = Services(u["headerId"],u["productName"],u["sellingPrice"],u["quantity"],u["amount"]);
       
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
        child: FadeAnimation(1.0,AlertDialog(
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
            color: Colors.green, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.green,
  child: new textCustom("OK",25,Colors.green,""),
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
      ));
    },
  );
}

  //function..
  List tranheader=[1,1,1];
   List<TextEditingController> refundTextCtrlr=[];
  TextEditingController receiptText=new TextEditingController();
  double totalRefund=0.0;
  //variable
  String getSearchReceipt="";
  List totalRefund1=[];
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
    onSubmitted: (value){

    }, 
 
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
               return FadeAnimation(1.0,AlertDialog(
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
               ));
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
        title: Text("Report", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue[650],
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        elevation: 2,
        actions: <Widget>[
         
     
       
        ],
     
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: false,
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
    onSubmitted: (val){
        setState(() {
          getSearchReceipt=receiptText.text;
        });
    },
    onChanged: (value){
        setState(() {
         
        });
    },
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
     
        icon: Container(
          padding: EdgeInsets.only(left: 15,),
          height: 65,
          width: 80,
          child: InkWell(
            onTap: (){
            // input the receipt no. for searching.
            setState(() {
               getSearchReceipt=receiptText.text;
            });
           
              
            },
            child: Image.asset("assets/b2.png", fit: BoxFit.cover,),
          )

        ),
        hintText: 'ENTER RECEIPT NO.', 
        hintStyle: TextStyle(fontSize: 20,),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 0, 
                style: BorderStyle.none,
            ),
        ),
        filled: false,
        contentPadding: EdgeInsets.all(20),
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
                child:Center(child:  textCustom1("Transaction Number", 25, Colors.black, "",FontWeight.bold))),
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Date/Time", 25, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Store", 25, Colors.black, "",FontWeight.bold))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Cashier", 25, Colors.black, "",FontWeight.bold))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Item", 25, Colors.black, "",FontWeight.bold))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Quantity", 25, Colors.black, "",FontWeight.bold))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Price", 25, Colors.black, "",FontWeight.bold))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Type", 25, Colors.black, "",FontWeight.bold))),
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
        itemCount: getSearchReceipt!="" ? snapshot.data.length : snapshot.data.length,
        itemBuilder: (BuildContext context, int index){
         //  DateTime dateTime = DateTime.parse(snapshot.data[index].dateTime);
                    //String dates = DateFormat('dd-MM-yyyy').format(dateTime);
          return  index%2==0? Container( 
            color: Colors.grey.withAlpha(40),
            child: Table(
           // border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [TableRow(
            
            children:[
                Container(padding: EdgeInsets.all(10),   
                child:Center(child:  textCustom1("XXX-XXXX-0923", 25, Colors.black, "",FontWeight.normal))),
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("8-8-19", 25, Colors.black, "",FontWeight.normal))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("MAKATI STORE", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("PROKOPYO", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("${snapshot.data[index].productName}", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("${snapshot.data[index].quantity}", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("${FlutterMoneyFormatter(amount:snapshot.data[index].amount).output.nonSymbol}", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Void", 25, Colors.black, "",FontWeight.normal))),
               
            ]
          )],
      
        ),
          ):Container( 
            color: Colors.white,
            child: Table(
           // border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [TableRow(
            
            children:[
                Container(padding: EdgeInsets.all(10),   
                child:Center(child:  textCustom1("XXX-XXXX-0923", 25, Colors.black, "",FontWeight.normal))),
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("8-8-19", 25, Colors.black, "",FontWeight.normal))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("MAKATI STORE", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("PROKOPYO", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("${snapshot.data[index].productName}", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("${snapshot.data[index].quantity}", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("${FlutterMoneyFormatter(amount:snapshot.data[index].amount).output.nonSymbol}", 25, Colors.black, "",FontWeight.normal))),
                 Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Void", 25, Colors.black, "",FontWeight.normal))),
               
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
            
          Column(
           mainAxisAlignment: MainAxisAlignment.end,
           children: <Widget>[
              textCustom("Trudi IT Solutions", 25, Colors.black, "style"),
             
              textCustom1(" © 2020 v1.0  All rights reserved", 25, Colors.black, "style",FontWeight.bold)
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