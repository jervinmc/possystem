import 'package:flutter/material.dart';
import 'transach.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<Transach> transachs;
  List <Transach> selectedtransachs;
  bool sort;

  @override
  void initState(){
    sort = false;
    transachs = Transach.getTransachs();
    super.initState();
  }
onSortColum(int columnIndex, bool ascending){
  if (columnIndex ==0){
    if (ascending){
transachs.sort((a,b) => a.id.compareTo(b.id));
    }else{
transachs.sort((a,b) => b.id.compareTo(a.id));
    }
  }
}
 DataTable dataBody(){
   return DataTable(
     columnSpacing: 400,
     sortAscending: sort,
     sortColumnIndex: 0,
     columns: [
       DataColumn(
         label: Text("ID", style: TextStyle(fontSize: 50)),
         numeric: false,
         tooltip: "This is the ID",
         onSort: (columnIndex, ascending){
           setState(() {
             sort =!sort;
           });
           onSortColum(columnIndex, ascending);
         }
       ),
       DataColumn(
         label: Text("Productname",style: TextStyle(fontSize: 50)),
         numeric: false,
         tooltip: "This is the productname",
         onSort: (columnIndex, ascending){
           setState(() {
             sort =!sort;
           });
           onSortColum(columnIndex, ascending);
         }
       ),
       DataColumn(
         label: Text("Date",style: TextStyle(fontSize: 50)),
         numeric: false,
         tooltip: "This is the date",
         onSort: (columnIndex, ascending){
           setState(() {
             sort =!sort;
           });
           onSortColum(columnIndex, ascending);
         }
       )
     ], rows: transachs.map((transachs) => DataRow(
       cells: [
         DataCell(
           Text(transachs.id),
           onTap: (){
             print("Selected ${transachs.id}");
           }
         ),
         DataCell(
           Text(transachs.productname),
           onTap: (){
             print("Selected ${transachs.productname}");
           }
         ),
         DataCell(
           Text(transachs.date),
         ),
       ],
     ),
     ).toList(),
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
            padding: const EdgeInsets.only(top: 45),
          ),
          Center(
            child: dataBody(),
          ),
        ],
      )
    );
  }
}