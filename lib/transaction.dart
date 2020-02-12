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
 
  
  final String id;
  final double discount;
  final double vat;
  final double subtotal;
  final double totalAmt;
  final double payment;
  final double memberPoints;
  final String dateTime;
  final String remarks;
  final String username;
  final String userid;
  final String memberName;
  final String receiptNo;
  Services(this.id,this.discount,this.vat,this.subtotal,this.totalAmt,this.payment,this.memberPoints,this.dateTime,this.remarks,this.username,this.userid,this.memberName,this.receiptNo);

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
      
      Services service = Services(u["_id"],u["discount"],u["vat"],u["subtotal"],u["totalAmt"],u["payment"],u["memberPoints"],u["datetime"],u["remarks"],u["username"]
      ,u["userId"],u["memberName"],u['receiptNo']);
       
      if(tranhistory.contains(u["_id"])){
            services.add(service);
            print("may pumasok");
      }
      else{
 print("walang pumasok");
      }
    }
    }
    else{
       for(var u in reviewdata){

      
      Services service = Services(u["_id"],u["discount"],u["vat"],u["subtotal"],u["totalAmt"],u["payment"],u["memberPoints"],u["datetime"],u["remarks"],u["username"],
      u["userId"],u["memberName"],u['receiptNo']);
       
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
        title: Text("Transaction History", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
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
                child:Center(child:  textCustom1("Receipt Number", 25, Colors.black, "",FontWeight.bold))),
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("Transaction Type", 25, Colors.black, "",FontWeight.bold))),
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
        itemCount: getSearchReceipt!="" ? snapshot.data.length : snapshot.data.length,
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
               
                  child:   Container(padding: EdgeInsets.all(10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //idclick
                     textCustom("XXX-XXXX-${snapshot.data[index].receiptNo[snapshot.data[index].receiptNo.length-4] }${snapshot.data[index].receiptNo[snapshot.data[index].receiptNo.length-3]}${snapshot.data[index].receiptNo[snapshot.data[index].receiptNo.length-2]}${snapshot.data[index].receiptNo[snapshot.data[index].receiptNo.length-1]}", 20, Colors.black, "")
                  ],
                )),
                
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
                      
                        child:  textCustom("${snapshot.data[index].remarks}", 25, Colors.black, "style"),
                      ),
              

                  ],
                )),
            Column( //////// replacing action dont use it
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
        child: FadeAnimation(1.0,AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 700,
          child: Column(
          children: <Widget>[
         Container(
           
           color: Colors.deepOrange,
           child: 
              Center( 
          child: textCustom("Transaction Details", 35, Colors.white, "style",),),
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Time", 30, Colors.black, "style",),
              textCustom("15/10/2019 2:52:31 AM", 30, Colors.black, "style",),
             
           ],
         ),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 30, Colors.black, "style",),
              textCustom("Prokopyo Tunying", 30, Colors.black, "style",),
             
           ],
         ),
        snapshot.data[index].memberName!=null?  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 30, Colors.black, "style",),
              textCustom("${snapshot.data[index].memberName}", 30, Colors.black, "style",),
             
           ],
         ):Container(),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 30, Colors.black, "style",),
              textCustom("0", 30, Colors.black, "style",),
             
           ],
         ),
         Divider(),
         Container(
           color: Colors.deepOrange,
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
                 child: textCustom1("${reviewdata[index]["productName"]}", 25, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
                child: Center(child:  textCustom1("${reviewdata[index]["quantity"]}", 25, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${reviewdata[index]["sellingPrice"]}", 25, Colors.black, "",FontWeight.bold))),
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
    //SunmiAidlPrint.openDrawer1();
             // SunmiAidlPrint.printText(text: "             Trudi POS");
           /*   SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
            SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "Member:                            PT\n");
              SunmiAidlPrint.printText(text: "Points:                             ${snapshot.data[index].memberPoints}'\n");
              SunmiAidlPrint.printText(text: "ITEM     QTY     PRICE     TOTAL \n");
              for(int x=0;x<snapshot.data.length;x++){
             SunmiAidlPrint.printText(text: "${snapshot.data[x]["productName"]}         ${snapshot.data[x]["quantity"]}          ${reviewdata[index]["amount"]}         ${snapshot.data[x]["quantity"]*reviewdata[index]["amount"]}\n");
              }
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "                                     Vat: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt*0.12).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Subtotal: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt-(snapshot.data[index].totalAmt*0.12)).output.nonSymbol}\n");
            SunmiAidlPrint.printText(text: "                                     Money: ${FlutterMoneyFormatter(amount:snapshot.data[index].payment).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Change: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt-snapshot.data[index].payment).output.nonSymbol}\n");
            SunmiAidlPrint.cutpaper12();
            */
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
           ),
         
        ],
      ),
      ));
    },
  );
                     },
                     child:   Row(  /////
                       children: <Widget>[
                         InkWell(
                       onTap: ()async{
                         //baliks
                       
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
        child: FadeAnimation(1.0, AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 528,
          child: Column(
          children: <Widget>[
         Container(
            height: 40,
           color: Colors.blue[500],
           child: 
              Center( 
          child: textCustom("Transaction Details", 30, Colors.white, "style",),),
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Date/Times", 20, Colors.black, "style",),
              textCustom("${dates}", 20, Colors.black, "style",),
           ],
         ),
         snapshot.data[index].memberName!=null?  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 20, Colors.black, "style",),
              textCustom("${snapshot.data[index].memberName}", 20, Colors.black, "style",),
             
           ],
         ):Container(),
             Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Cashier", 20, Colors.black, "style",),
              textCustom("${snapshot.data[index].username}", 20, Colors.black, "style",),
             
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
           color: Colors.blue[500],
           height: 40,
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
               
           height: 40,
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
                child: Center(child:  textCustom1(
                  "${reviewdata[index]["quantity"]}", 20, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${FlutterMoneyFormatter(amount:reviewdata[index]["amount"]).output.nonSymbol}", 20, Colors.black, "",FontWeight.bold))),
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
              textCustom("Discount", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].discount).output.nonSymbol}", 20, Colors.black, "style",),
             
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
              textCustom("Subtotal", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].subtotal).output.nonSymbol}", 20, Colors.black, "style",),
             
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
         snapshot.data[index].remarks=="Transaction Completed"? Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].payment-snapshot.data[index].totalAmt).output.nonSymbol}", 20, Colors.green, "style",),
             
           ],
         ): snapshot.data[index].remarks=="Previous Transaction" ? Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].payment-snapshot.data[index].totalAmt).output.nonSymbol}", 20, Colors.green, "style",),
             
           ],
         ): Container(),
       
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
    //SunmiAidlPrint.openDrawer1();
              SunmiAidlPrint.printText(text: "                Benevolence Enterprise\n");
              SunmiAidlPrint.printText(text: "                Fairview, Quezon City\n");
              SunmiAidlPrint.setAlignment(align: prefix0.TEXTALIGN.CENTER);
              SunmiAidlPrint.printText(text: "========================================\n");
              SunmiAidlPrint.printText(text: "Cashier: Paul Jervin OB. Alipor\n");
              SunmiAidlPrint.printText(text: "Date/Time: MM/DD/YY\n");
              SunmiAidlPrint.setAlignment(align: prefix0.TEXTALIGN.LEFT);
              SunmiAidlPrint.printText(text: "========================================\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.setFontSize(fontSize:24);
              SunmiAidlPrint.printText(text: "Member:                           \n");
              SunmiAidlPrint.printText(text: "Points:                             ${snapshot.data[index].memberPoints}'\n");
              SunmiAidlPrint.printText(text: "ITEM     QTY     PRICE     TOTAL \n");
              for(int x=0;x<snapshot.data.length;x++){
             SunmiAidlPrint.printText(text: "${snapshot.data[x]["productName"]}         ${snapshot.data[x]["quantity"]}          ${reviewdata[index]["amount"]}         ${snapshot.data[x]["quantity"]*reviewdata[index]["amount"]}\n");
              }
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
             // SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "                                     Vat: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt*0.12).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Subtotal: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt-(snapshot.data[index].totalAmt*0.12)).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Money: ${FlutterMoneyFormatter(amount:snapshot.data[index].payment).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Change: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt-snapshot.data[index].payment).output.nonSymbol}\n");

               SunmiAidlPrint.cutpaper12();           
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
           ),
         
        ],
      ),
      ));
    },
  );
 },
 
            child:Row(
              children: <Widget>[
               
                     Container(
              height: 40,
                             child: Image(image:AssetImage("assets/eye1.png"),),
                     )
              ],
            ),
                     ),
                       ],
                     )
                   ),
                   VerticalDivider(),
                  snapshot.data[index].remarks=="Refunded Items"  ? Container():  snapshot.data[index].remarks!="Previous Transaction"  ? InkWell(
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
        child: FadeAnimation(1.0,AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 450,
          child: Column(
          children: <Widget>[
         Container(
           height: 50,
           color: Colors.deepOrange,
           child: 
              Center( 
          child: textCustom("Refund Item", 35, Colors.white, "style",),),
         ),
        
         Container(
        
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("ITEM", 27, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 27, Colors.black, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      ),
      Container(
        
        height: 270,
        child: ListView.builder(
          itemCount: reviewdata.length,
            itemBuilder: (BuildContext context, int index){
              print(index);
              totalRefund1.add(0.0);
             // totalamountRefundedItems.add(0.0);
                var textEditingController = new TextEditingController(text: "");
        refundTextCtrlr.add(textEditingController);
              return Container(
               
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Expanded(
               child: Container(
                 padding: EdgeInsets.only(top: 20,left: 15),
                 child: textCustom1("${reviewdata[index]["productName"]}", 20, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
           width: 20,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: refundTextCtrlr[index], 
                  textAlign: TextAlign.center,
                  onSubmitted: (val){
                 },
                  onChanged: (val){ 
                     if(val=="" || val=="0"){
                        totalRefund1[index]=0.0;
                      }
                      else{
                           totalRefund1[index]=(double.parse("$val")*double.parse("${reviewdata[index]["amount"]}"));    
                      }
                  
                  },
                  decoration: InputDecoration(       
                    hintText:"${reviewdata[index]["quantity"]}"
                  ),
                )),
            
            ],

            
          ),
          ],
        ),
      );

            },
        ),
       
      ),
      Text(""),
   
           Center(
             child:Container(
               margin: EdgeInsets.only(top: 5),
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
  child: new textCustom("Cancel",25,Colors.red,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),
Text("  "),
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.green, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.green,
  child: new textCustom("Submit",25,Colors.green,""),
  onPressed: ()async{
    print("eto ang id ${snapshot.data[index].userid}");
    for(int x=0;x<totalRefund1.length;x++){
                    totalRefund=totalRefund+totalRefund1[x];
                    print("totalrefund $totalRefund");
                  }
                  var d=await http.get("http://192.168.1.3:424/api/TranHeader/getall");
                  var e=json.decode(d.body);
    var header=await http.post("http://192.168.1.3:424/api/TranHeader/Add",body:{
                       "discount":"${rev["discount"]}","receiptNo":"${e.length}","vat":"${rev["totalAmt"]*0.12}","memberName":"Prokopyo tunying","subtotal":"${rev["subtotal"]}"
                       ,"totalAmt":"${rev["totalAmt"]-totalRefund}","payment":"${rev["payment"]}","memberPoints":"${rev["points"]}","remarks":"Transaction Refunded Receipt",
                      "userid":"${snapshot.data[index].userid}"
                     });
                          print("object");
                     final myString = '${header.body}';
var headers = myString.replaceAll(RegExp('"'), ''); 
//print("object $headers");
                     for(int x=0;x<reviewdata.length;x++){
                       if(refundTextCtrlr[x].text==""){
                         setState(() {
                            refundTextCtrlr[x].text="0";
                         });
                       
                       }
                         int refund=reviewdata[x]["quantity"]-int.parse("${refundTextCtrlr[x].text}");
                       if(refund==0){
                         

                      }
                      else{

                      
                      print(refundTextCtrlr[x].text);
                        
                    

                            await http.post("http://192.168.1.3:424/api/TranDetails/add",body:{
                       "sellingPrice":"${reviewdata[x]["sellingPrice"]}","categoryDesc":"safeguard",
                       "productId":"${reviewdata[x]["productId"]}",
                       "amount":"${reviewdata[x]["amount"]}",
//"productName":"${productName[x]}",
"quantity":"$refund",
"points":"20",
//"productId":"5d81a87ac321c71124c19dfc",
"headerId":"$headers"
                     });
                     }
                     }
                var c=await http.get("http://192.168.1.3:424/api/TranHeader/getall");
                  var y=json.decode(c.body);
                       var headersId=await http.post("http://192.168.1.3:424/api/TranHeader/Add",body:{
                       "discount":"${rev["discount"]}","receiptNo":"${y.length}","vat":"${rev["totalAmt"]*0.12}","memberName":"Prokopyo tunying","subtotal":"${rev["subtotal"]}"
                       ,"totalAmt":"$totalRefund","payment":"${rev["payment"]}","memberPoints":"${rev["points"]}","remarks":"Refunded Items","userId":"${snapshot.data[index].userid}"
                     });
                          print("object");
                     final s = '${headersId.body}';
var headerId = s.replaceAll(RegExp('"'), ''); 
                     for(int x=0;x<reviewdata.length;x++){
                       
                            if(refundTextCtrlr[x].text=="" || refundTextCtrlr[x].text=="0"){

                            }
                            else{
                              
                                         await http.post("http://192.168.1.3:424/api/TranDetails/add",body:{
                       "sellingPrice":"${reviewdata[x]["sellingPrice"]}","categoryDesc":"safeguard",
                       "productId":"${reviewdata[x]["productId"]}",
                       "amount":"${reviewdata[x]["amount"]}",
//"productName":"${productName[x]}",
"quantity":"${int.parse("${refundTextCtrlr[x].text}")}",
"points":"20",
//"productId":"5d81a87ac321c71124c19dfc",
"headerId":"$headerId"
                     });
                            }
                   
                 
                     }
                     await http.get("http://192.168.1.3:424/api/TranHeader/UpdateRemarks/${snapshot.data[index].id}/Previous Transaction");
                            SharedPreferences prefs = await SharedPreferences.getInstance();
  //double a =prefs.getDouble("totalAmountSaveprefs");
  
  
                     setState(() {
                       totalamount=totalamount-totalRefund;
                       prefs.setDouble("totalAmountSaveprefs", totalamount);
                                   tranhistory.add("$headerId");
                                  tranhistory.add("$headers");
                            
                     });
         refundTextCtrlr.clear();
         totalRefund1.clear();
         totalRefund=0;
       
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
      ));
    },
  );
 },
 
            child:Row(
              children: <Widget>[
                Container(
              height: 40,
                       child: Image(image: AssetImage("assets/refund1.png"),),
                     ),
            
              ],
            ),
                     ):Container(),
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
                 
                  child:   Container(padding: EdgeInsets.all(10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //idclick
                    // textCustom("${snapshot.data[index].id}", 20, Colors.black, "")
                    textCustom("XXX-XXXX-${snapshot.data[index].receiptNo[snapshot.data[index].receiptNo.length-4] }${snapshot.data[index].receiptNo[snapshot.data[index].receiptNo.length-3]}${snapshot.data[index].receiptNo[snapshot.data[index].receiptNo.length-2]}${snapshot.data[index].receiptNo[snapshot.data[index].receiptNo.length-1]}", 20, Colors.black, "")
                  ],
                )),
            
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
                       
                        child:  textCustom("${snapshot.data[index].remarks}", 25, Colors.black, "style"),
                      ),
              

                  ],
                )),
            Column( //////// replacing action dont use it
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
        child: FadeAnimation(1.0,AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 700,
          child: Column(
          children: <Widget>[
         Container(
           
           color: Colors.deepOrange,
           child: 
              Center( 
          child: textCustom("Transaction Details", 30, Colors.white, "style",),),
         ),
         snapshot.data[index].memberName!=null?  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 25, Colors.black, "style",),
              textCustom("${snapshot.data[index].memberName}", 25, Colors.black, "style",),
             
           ],
         ):Container(),
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
              textCustom("Points", 20, Colors.black, "style",),
              textCustom("0", 20, Colors.black, "style",),
             
           ],
         ),
         Divider(),
         Container(
           color: Colors.deepOrange,
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
    //  SunmiAidlPrint.openDrawer1();
              SunmiAidlPrint.printText(text: "             Benevolence Enterprise\n");
              SunmiAidlPrint.printText(text: "               Fairview, Quezon City\n");
              SunmiAidlPrint.printText(text: "\n");
            SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.setFontSize(fontSize:20);
              SunmiAidlPrint.printText(text: "Member:                            PT\n");
              SunmiAidlPrint.printText(text: "Points:                             ${snapshot.data[index].memberPoints}'\n");
              SunmiAidlPrint.printText(text:"ITEM       QTY         PRICE         TOTAL \n");
              for(int x=0;x<snapshot.data.length;x++){
             SunmiAidlPrint.printText(text:"${snapshot.data[x]["productName"]}         ${snapshot.data[x]["quantity"]}          ${reviewdata[index]["amount"]}         ${snapshot.data[x]["quantity"]*reviewdata[index]["amount"]}\n");
              }
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "==================================================\n");
              SunmiAidlPrint.printText(text: "                                     Vat: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt*0.12).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Subtotal: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt-(snapshot.data[index].totalAmt*0.12)).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Money: ${FlutterMoneyFormatter(amount:snapshot.data[index].payment).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Change: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt-snapshot.data[index].payment).output.nonSymbol}\n");
              SunmiAidlPrint.cutpaper12();
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
           ),
         
        ],
      ),
      ));
    },
  );
                     },
                     child:   Row(  /////
                       children: <Widget>[
                         InkWell(
                       onTap: ()async{
                         //baliks
                       
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
        child: FadeAnimation(1.0, AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 528,
          child: Column(
          children: <Widget>[
         Container(
            height: 40,
           color: Colors.deepOrange,
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
              textCustom("${snapshot.data[index].username}", 20, Colors.black, "style",),
             
           ],
         ),
        snapshot.data[index].memberName!=null?  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Member", 20, Colors.black, "style",),
              textCustom("${snapshot.data[index].memberName}", 20, Colors.black, "style",),
             
           ],
         ):Container(),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Points", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].memberPoints).output.nonSymbol}", 20, Colors.black, "style",),
             
           ],
         ),
         Divider(),
         Container(
           color: Colors.deepOrange,
           height: 40,
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
               
           height: 40,
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
                child: Center(child:  textCustom1(
                  "${reviewdata[index]["quantity"]}", 20, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(2),
          child: Center(child:  textCustom1("${FlutterMoneyFormatter(amount:reviewdata[index]["amount"]).output.nonSymbol}", 20, Colors.black, "",FontWeight.bold))),
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
              textCustom("Discount", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].discount).output.nonSymbol}", 20, Colors.black, "style",),
             
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
              textCustom("Subtotal", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].subtotal).output.nonSymbol}", 20, Colors.black, "style",),
             
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
        snapshot.data[index].remarks=="Transaction Completed" ? Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].payment-snapshot.data[index].totalAmt).output.nonSymbol}", 20, Colors.green, "style",),
             
           ],
         ): snapshot.data[index].remarks=="Previous Transaction" ? Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              textCustom("Change", 20, Colors.black, "style",),
              textCustom("${FlutterMoneyFormatter(amount:snapshot.data[index].payment-snapshot.data[index].totalAmt).output.nonSymbol}", 20, Colors.green, "style",),
             
           ],
         ):Container(),
       
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
   // SunmiAidlPrint.openDrawer1();
              SunmiAidlPrint.printText(text: "             Benevolence Enterprise\n");
              SunmiAidlPrint.printText(text: "               Fairview, Quezon City\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.setAlignment(align:TEXTALIGN.CENTER);
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.setFontSize(fontSize:20);
              SunmiAidlPrint.printText(text: "Member:                            PT\n");
              SunmiAidlPrint.printText(text: "Points:                             ${snapshot.data[index].memberPoints}'\n");
              SunmiAidlPrint.printText(text: "ITEM        QTY        PRICE     TOTAL \n");
              for(int x=0;x<snapshot.data.length;x++){
             SunmiAidlPrint.printText(text:"${snapshot.data[x]["productName"]}         ${snapshot.data[x]["quantity"]}           ${reviewdata[index]["amount"]}        ${snapshot.data[x]["quantity"]*reviewdata[index]["amount"]}\n");
              }
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "==================================================\n");
              SunmiAidlPrint.printText(text: "                                     Vat: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt*0.12).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Subtotal: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt-(snapshot.data[index].totalAmt*0.12)).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Money: ${FlutterMoneyFormatter(amount:snapshot.data[index].payment).output.nonSymbol}\n");
              SunmiAidlPrint.printText(text: "                                     Change: ${FlutterMoneyFormatter(amount:snapshot.data[index].totalAmt-snapshot.data[index].payment).output.nonSymbol}\n");
            SunmiAidlPrint.cutpaper12();
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
           ),
         
        ],
      ),
      ));
    },
  );
 },
            child:Row(
              children: <Widget>[
               
                     Container(
              height: 40,
                       child: Image(image:AssetImage("assets/eye1.png"),),
                     )
              ],
            ),
                     ),
                       ],
                     )
                   ),
                    VerticalDivider(),
                 snapshot.data[index].remarks=="Refunded Items"  ? Container():   snapshot.data[index].remarks!="Previous Transaction" ? InkWell(
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
        child: FadeAnimation(1.0,AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Container(
          width: 700,
          height: 450,
          child: Column(
          children: <Widget>[
         Container(
           height: 50,
           color: Colors.deepOrange,
           child: 
              Center( 
          child: textCustom("Refund Item", 35, Colors.white, "style",),),
         ),
         Container(
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("ITEM", 27, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 27, Colors.black, "",FontWeight.bold))),
            ]
          
            
          )
          ],
        ),
      ),
      Container(
        
        height: 270,
        child: ListView.builder(
          itemCount: reviewdata.length,
            itemBuilder: (BuildContext context, int index){
              print(index);
              totalRefund1.add(0.0);
             // totalamountRefundedItems.add(0.0);
                var textEditingController = new TextEditingController(text: "");
        refundTextCtrlr.add(textEditingController);
              return Container(
               
           height: 50,
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             Expanded(
               child: Container(
                 padding: EdgeInsets.only(top: 20,left: 15),
                 child: textCustom1("${reviewdata[index]["productName"]}", 20, Colors.black, "",FontWeight.bold),
               ),
             ),
           ],
         ),
           Container(padding: EdgeInsets.all(2),
           width: 20,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: refundTextCtrlr[index],
                  textAlign: TextAlign.center,
                  onSubmitted: (val){
                     
                 },
                  onChanged: (val){ 
                     if(val=="" || val=="0"){
                        totalRefund1[index]=0.0;
                      }
                      else{
                           totalRefund1[index]=(double.parse("$val")*double.parse("${reviewdata[index]["amount"]}"));    
                      }
           
                  },
                  decoration: InputDecoration(       
                    hintText:"${reviewdata[index]["quantity"]}"
                  ),
                )),
            
            ],

            
          ),
          ],
        ),
      );

            },
        ),
       
      ),
      Text(""),
   
           Center(
             child:Container(
               margin: EdgeInsets.only(top: 5),
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
  child: new textCustom("Cancel",25,Colors.red,""),
  onPressed: (){
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),
Text("  "),
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.green, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.green,
  child: new textCustom("Submit",25,Colors.green,""),
  onPressed: ()async{
    print("eto ang id ${snapshot.data[index].userid}");
          for(int x=0;x<totalRefund1.length;x++){
                    totalRefund=totalRefund+totalRefund1[x];
                    print("totalrefund $totalRefund");
                  }
                  var d=await http.get("http://192.168.1.3:424/api/TranHeader/getall");
                  var e=json.decode(d.body);

    var header=await http.post("http://192.168.1.3:424/api/TranHeader/Add",body:{
                       "discount":"${rev["discount"]}","receiptNo":"${e.length}","vat":"${rev["totalAmt"]*0.12}","memberName":"Prokopyo tunying","subtotal":"${rev["subtotal"]}"
                       ,"totalAmt":"${rev["totalAmt"]-totalRefund}","payment":"${rev["payment"]}","memberPoints":"${rev["points"]}","remarks":"Transaction Refunded Receipt",
                      "userid":"${snapshot.data[index].userid}"
                     });
                          print("object");
                     final myString = '${header.body}';
var headers = myString.replaceAll(RegExp('"'), ''); 
//print("object $headers");
                     for(int x=0;x<reviewdata.length;x++){
                        if(refundTextCtrlr[x].text==""){
                          setState(() {
                               refundTextCtrlr[x].text="0";
                          });
                     
                       }
                         int refund=reviewdata[x]["quantity"]-int.parse("${refundTextCtrlr[x].text}");
                       if(refund==0){
                       

                      }
                      else{

                      
                      print(refundTextCtrlr[x].text);
                        
                    

                            await http.post("http://192.168.1.3:424/api/TranDetails/add",body:{
                       "sellingPrice":"${reviewdata[x]["sellingPrice"]}","categoryDesc":"safeguard",
                       "productId":"${reviewdata[x]["productId"]}",
                       "amount":"${reviewdata[x]["amount"]}",
//"productName":"${productName[x]}",
"quantity":"$refund",
"points":"20",
//"productId":"5d81a87ac321c71124c19dfc",
"headerId":"$headers"
                     });
                     }
                     }
                  var a=await http.get("http://192.168.1.3:424/api/TranHeader/getall");
                  var x=json.decode(a.body);
                       var headersId=await http.post("http://192.168.1.3:424/api/TranHeader/Add",body:{
                       "discount":"${rev["discount"]}","receiptNo":"${x.length}","vat":"${rev["totalAmt"]*0.12}","memberName":"Prokopyo tunying","subtotal":"${rev["subtotal"]}"
                       ,"totalAmt":"$totalRefund","payment":"${rev["payment"]}","memberPoints":"${rev["points"]}","remarks":"Refunded Items","userId":"${snapshot.data[index].userid}"
                     });
                          print("object");
                     final s = '${headersId.body}';
var headerId = s.replaceAll(RegExp('"'), ''); 
                     for(int x=0;x<reviewdata.length;x++){
                            if(refundTextCtrlr[x].text=="" || refundTextCtrlr[x].text=="0"){

                            }
                            else{
                              
                                         await http.post("http://192.168.1.3:424/api/TranDetails/add",body:{
                       "sellingPrice":"${reviewdata[x]["sellingPrice"]}","categoryDesc":"safeguard",
                       "productId":"${reviewdata[x]["productId"]}",
                       "amount":"${reviewdata[x]["amount"]}",
//"productName":"${productName[x]}",
"quantity":"${int.parse("${refundTextCtrlr[x].text}")}",
"points":"20",
//"productId":"5d81a87ac321c71124c19dfc",
"headerId":"$headerId"
                     });
                            }
                   
                 
                     }
                      await http.get("http://192.168.1.3:424/api/TranHeader/UpdateRemarks/${snapshot.data[index].id}/Previous Transaction");
                       SharedPreferences prefs = await SharedPreferences.getInstance();
  //double a =prefs.getDouble("totalAmountSaveprefs");
  
                    setState(() {
                       totalamount=totalamount-totalRefund;
                       prefs.setDouble("totalAmountSaveprefs", totalamount);
                                   tranhistory.add("$headerId");
                                  tranhistory.add("$headers");
                                  
                     });
         
  Navigator.of(context).pop();
  totalRefund=0;
  refundTextCtrlr.clear();
  totalRefund1.clear();
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
      ));
    },
  );
 },
 
            child:Row(
              children: <Widget>[
                Container(
              height: 40,
                       child: Image(image: AssetImage("assets/refund1.png"),),
                     ),
              
              ],
            ),
                     ):Container(),
                     // VerticalDivider(),
                    ],
                  ),
                ),
              ],
            )
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
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
              textCustom("Opening Amount: ", 25, Colors.black, "style"),
          
              textCustom1("Php ${FlutterMoneyFormatter(amount:double.parse(openingAmt)).output.nonSymbol}", 25, Colors.black, "style",FontWeight.bold)
           ],
         ),
          Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
              textCustom("Total Amount: ", 25, Colors.black, "style"),
             
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