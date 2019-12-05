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
    selectedtransachs = [];
    transachs = Transach.getTransachs();
    super.initState();
  }

onSortColum(int columnIndex, bool ascending){
  if (columnIndex ==1){
    if (ascending){
transachs.sort((a,b) => a.productname.compareTo(b.productname));
    }else{
transachs.sort((a,b,) => b.productname.compareTo(a.productname));
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
      }
    }
  });
}
  SingleChildScrollView dataBody(){
   return SingleChildScrollView(
     scrollDirection: Axis.vertical,
     child: DataTable(
     columnSpacing: 300,
     sortAscending: sort,
     sortColumnIndex: 0,
     columns: [
       DataColumn(
         label: Text("Transaction ID", style: TextStyle(fontSize: 40)),
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
         label: Text("Items",style: TextStyle(fontSize: 40)),
         numeric: false,
         tooltip: "This is the items",
         onSort: (columnIndex, ascending){
           setState(() {
             sort =!sort;
           });
           onSortColum(columnIndex, ascending);
         }
       ),
       DataColumn(
         label: Text("Date", style: TextStyle(fontSize: 40)),
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
       selected: selectedtransachs.contains(transachs),
       onSelectChanged: (b){
         onSelectedRow(b, transachs);
       },
       cells:[
         DataCell(
           Text(transachs.id),
           onTap: (){
             print("Selected ${transachs.id}");
           },
         ),
         DataCell(
           Text(transachs.productname),
           onTap: (){
             print("Selected ${transachs.productname}");
           },
         ),
         DataCell(
           Text(transachs.date),
           onTap: (){
             print("Selected ${transachs.date}");
           }
         ),
       ],
     ),
     ).toList(),
     )
   );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        elevation: 2,
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white60,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: OutlineButton(
                  child: Text("Selected ${selectedtransachs.length}"),
                  onPressed: (){

                  },
                ),
              ),
               Padding(
            padding: EdgeInsets.all(20),
            child: OutlineButton(
              child: Text("Delete"),
              onPressed: selectedtransachs.isEmpty
              ? null
              : (){
                deleteSelected();
              },
            ),
          )
            ],
          ),
        ],
      )
    );
  }
}