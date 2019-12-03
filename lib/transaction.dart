import 'package:flutter/material.dart';
import 'transach.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<Transach> transachs;

  @override
  void initState(){
    transachs = Transach.getTransachs();
    super.initState();
  }

 DataTable dataBody(){
   return DataTable(
     columns: <DataColumn>[
       DataColumn(
         label: Text("ID", style: TextStyle(fontSize: 50),),
         numeric: false,
         tooltip: "This is the ID"
       ),
       DataColumn(
         label: Text("Productname",style: TextStyle(fontSize: 50),),
         numeric: false,
         tooltip: "This is the productname",
       ),
       DataColumn(
         label: Text("Date",style: TextStyle(fontSize: 50),),
         numeric: false,
         tooltip: "This is the date",
       )
     ], rows: transachs.map((transachs) => DataRow(
       cells: [
         DataCell(
           Text(transachs.id)
         ),
         DataCell(
           Text(transachs.productname)
         ),
         DataCell(
           Text(transachs.date)
         ),
       ]
     ),
     )
     .toList(),
   );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white, size: 25),
        elevation: 0,
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
          ),
          Center(
            child: dataBody(),
          ),
        ],
      ),
    );
  }
}