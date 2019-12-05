class Transach{
  String id;
  String productname;
  String date;

  Transach({this.id, this.productname, this.date });

  static List<Transach> getTransachs(){
    return <Transach> [
      Transach(id: "001", productname: "Head and Shoulder",date: "01-01-2019"),
      Transach(id: "002", productname: "SafeGuard Family",date: "01-01-2020"),
      Transach(id: "003", productname: "Clear",date: "01-01-2018"),
      Transach(id: "004", productname: "Dove",date: "01-01-2021"),
      Transach(id: "005", productname: "Close up",date: "01-01-2022"),
      Transach(id: "006", productname: "Wetlook",date: "01-01-2003"),
      Transach(id: "007", productname: "Shoulder",date: "01-01-1997"),
      Transach(id: "008", productname: "Ash Family",date: "01-01-1995"),
      Transach(id: "009", productname: "Head ",date: "01-01-1996"),
      Transach(id: "010", productname: " Family",date: "01-01-1999"),
      Transach(id: "011", productname: "Head and Shoulder",date: "01-01-1998"),
      Transach(id: "012", productname: "SafeGuard Family",date: "01-01-1993"),
      Transach(id: "013", productname: "Shoulder",date: "01-01-1994"),
      Transach(id: "014", productname: "SafeGuard Family",date: "01-01-2027"),
      Transach(id: "015", productname: "Head and Shoulder",date: "01-01-2028"),
      Transach(id: "016", productname: "Guard",date: "01-01-2003"),
      Transach(id: "017", productname: "and ",date: "01-01-2004"),
      Transach(id: "018", productname: "SafeGuard Family",date: "01-01-2005"),
    ];
  }

}