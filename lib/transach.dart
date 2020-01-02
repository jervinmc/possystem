import 'package:http/http.dart' as http;
import 'dart:convert';
class Transach{
  String receipt;
  String date;
  String refund;
  
  Transach({this.receipt, this.date, this.refund});

  static List<Transach> getTransachs(){

    var reviewdata;
    
    void dataTable()async{
        
      http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/TranHeader/GetAll"),headers: {
        "Accept":"application/json"
     });
   reviewdata=json.decode(response.body);

    }
  
    dataTable();
    print("eto ang reviewdataaaaaaaaa ${reviewdata}");
    for(int x=0;x<5;x++){
      print("object");
      return <Transach> [
      Transach(receipt: "000001", date: "01-01-2019",refund: "Refund"),
       Transach(receipt: "000001", date: "01-01-2019",refund: "Refund"),
        Transach(receipt: "000001", date: "01-01-2019",refund: "Refund"),
    ];
    }
  }
}
