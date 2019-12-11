import 'package:flutter/material.dart';
import 'transach.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'utils.dart';
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
      }
    }
  });
}
  SingleChildScrollView dataBody(){
   return SingleChildScrollView(
     scrollDirection: Axis.vertical,
     child: DataTable(
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
             sort =!sort;
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
               context: context, builder: (_) =>  AssetGiffyDialog(
                 image: Image.asset('assets/transaction.gif'),
                 buttonCancelColor: Colors.red,
                 buttonCancelText: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 30)),
                 buttonOkColor: Colors.green,
                 buttonOkText: Text("Ok", style: TextStyle(color: Colors.white, fontSize: 30)),
                 title: Text("Transaction Details",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                 ),
                 description: Text("",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                 textAlign: TextAlign.center),
                 entryAnimation: EntryAnimation.RIGHT,
                 onOkButtonPressed: (){
                   Navigator.pop(context);
                 },
               ),
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
                   title: Text("Transaction Details", style: TextStyle(fontSize: 40),),
                   content: Text("CONTENT TRANSACTION......." ,style: TextStyle(fontSize: 40),),
                   contentPadding: EdgeInsets.all(100),
                   actions: <Widget>[
                     new FlatButton(
                       child: Text("Cancel", style: TextStyle(fontSize: 25),),
                       onPressed: (){
                         Navigator.pop(context);
                       },
                     ),
                     Text(""),
                     Text(""),
                     FlatButton(
                       child: Text("Confirm", style: TextStyle(fontSize: 25),),
                       onPressed: (){
                         Navigator.pop(context);
                       },
                     ),
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
        actions: <Widget>[
         textCustom('Selected ${selectedtransachs.length}', 30, Colors.white, "")
      
        ],
      ),
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.up,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
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