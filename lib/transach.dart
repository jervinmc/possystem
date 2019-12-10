class Transach{
  String id;
  String productname;
  String date;

  Transach({this.id, this.productname, this.date });

  static List<Transach> getTransachs(){
    return <Transach> [
      Transach(id: "01", productname: "Head and Shoulder",date: "01-01-2019"),
      Transach(id: "02", productname: "SafeGuard Family",date: "01-01-2020"),
      Transach(id: "03", productname: "Clear",date: "01-01-2018"),
      Transach(id: "04", productname: "Dove",date: "01-01-2021"),
    ];
  }

}