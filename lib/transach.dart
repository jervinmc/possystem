class Transach{
  String receipt;
  String date;
  String view;
  
  Transach({this.receipt, this.date, this.view});

  static List<Transach> getTransachs(){
    return <Transach> [
      Transach(receipt: "000001", date: "01-01-2019",view: "VIEW"),
      Transach(receipt: "000002", date: "01-01-2020",view: "VIEW"),
      Transach(receipt: "000003", date: "01-01-2018",view: "VIEW"),
      Transach(receipt: "000004", date: "01-01-2021",view: "VIEW"),
      
    ];
  }

}