class Transach{
  String receipt;
  String date;
  String refund;
  
  Transach({this.receipt, this.date, this.refund});

  static List<Transach> getTransachs(){
    return <Transach> [
      Transach(receipt: "000001", date: "01-01-2019",refund: "Refund"),
      Transach(receipt: "000002", date: "01-01-2020",refund: "Refund"),
      Transach(receipt: "000003", date: "01-01-2018",refund: "Refund"),
      Transach(receipt: "000004", date: "01-01-2021",refund: "Refund"),
    ];
  }

}