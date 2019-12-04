class Transach{
  String id;
  String productname;
  String date;

  Transach({this.id, this.productname, this.date });

  static List<Transach> getTransachs(){
    return <Transach> [
      Transach(id: "001", productname: "Head and Shoulder",date: "01-01-2019"),
      Transach(id: "002", productname: "SafeGuard Family",date: "01-01-2020"),
    ];
  }

}