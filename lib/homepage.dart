import 'dart:math';
import 'package:possystem/fadeAnimation.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:vector_math/vector_math.dart' as prefix0;
import 'transaction.dart';
import 'homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import './utils.dart';
import 'package:sunmi_aidl_print/sunmi_aidl_print.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stepper_touch/stepper_touch.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:sunmi/sunmi.dart';
import 'package:flutter/services.dart';
import 'transition.dart';
class product {
  final name;
  final qty;
  final total;
  product(this.name,this.qty,this.total);

  }
class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key key,this.controller}):
  scale=Tween<double>(
    begin: 1.5,
    end: 0.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn

    ),),
      translation=Tween<double>(
    begin: 0.0,
    end: 70.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.elasticInOut

    
  ),

  ),super(key:key);
   final AnimationController controller;
    final Animation<double>translation;
  final Animation<double>scale;
  
  @override
  
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context,builder){
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
        
        _buildButton(-193,color: Colors.transparent,icon: FontAwesomeIcons.userCircle),
         _buildButton(-164,color: Colors.transparent,icon: FontAwesomeIcons.signOutAlt),
         // _buildButton(-205,color: Colors.transparent,icon: FontAwesomeIcons.cross),
            Transform.scale(
              scale: scale.value-1.5,
              child:  FloatingActionButton(
                heroTag: "btn1",
              child: Icon(FontAwesomeIcons.stream,color: Colors.orange,),
            onPressed: _close,
            backgroundColor: Colors.transparent,
            ),
            ),
            Transform.scale(
              scale: scale.value,
              child:  FloatingActionButton(
                 heroTag: "btn2",
              child: Icon(Icons.person_pin),
            onPressed: _open,
           backgroundColor: Colors.black,
            )
            )
           
          ],
        );
//buildbutton............. 7:00 mns
  
      },
      
      
    );
  }
  _buildButton(double angle, {Color color, IconData icon}){
      final double rad=prefix0.radians(angle);
      return Transform(
            
            transform: Matrix4.identity()..translate(
              (translation.value) * cos(rad),
              (translation.value) * sin(rad),
            ),
            child: angle==-193 ? FloatingActionButton(
              heroTag: "heroTag",
              child: Icon(icon),backgroundColor: color,onPressed: _close,
            ) : FloatingActionButton(
              heroTag: "heroTag1",
              child: Icon(icon),backgroundColor: color,onPressed: _close,
            ),
      );
    }
  _open(){
    controller.forward();
  }
  _close(){
    controller.reverse();
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Homepage(),
      
    );
  }
}
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>with SingleTickerProviderStateMixin {

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  
  List productName=[];
  List quantity=[];
  List price=[];

  static const MethodChannel _channel = const MethodChannel('sunmi_aidl_print');
  AnimationController controller;
  TextEditingController searchCtrlr=new TextEditingController();
    @override
    //function..
    Future<void> paymentRestriction(BuildContext context,int x) {
        
  return showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Center( 
          child: textCustom("Please enter the payment", 25, Colors.red, "style",),),
        content:Text(""),
        actions: <Widget>[
           Center(
             child:Container(
               width: 300,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.red, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.red,
  child: new textCustom("OK",25,Colors.red,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),
                 ],
               ),
               )
             )
           )
        ],
      ),
      );
    },
  );
}
    void enterBarcode()async{
      print(searchCtrlr.text);
     
      http.Response response=await http.get(Uri.encodeFull("http://192.168.1.115:424/api/Inventories/getbyid/${searchCtrlr.text}"),headers: {
        "Accept":"application/json"
     });
       _ackAlert(context, 1);
    var reviewdata=json.decode(response.body);
   
    print("${reviewdata['sellingPrice']} eto ang nakuha");
    //price.removeAt(2);
    int trap=0;
    setState(() {
      for(int x=0;x<productName.length;x++){
        if(productName[x]==reviewdata['productName']){
            print("nag insert");
            quantity.insert(x, quantity[x]+1);
            trap=1;
            sd=x;
              points=points+reviewdata['points'];
              function="add";
        }
      }
      if(trap==0 && reviewdata['sellingPrice']!=null ){ 
      //  function="add";
              price.add(reviewdata['sellingPrice']);
    quantity.add(1);
  productName.add(reviewdata['productName']);
    points=points+reviewdata['points'];
    pointsTotal.add(reviewdata['points']);
  trap=1;
      }
      else{
        _ackAlert(context, 1);
      }
      
  //quantity.insert(2, 10);
  if(productName.indexOf(reviewdata['productName'])<0){
      print("okkkk");
  }
    });
    sd=productName.length-1;
 print("eto ang prod ${productName.length}");
       if(productName.length>1){
       function="add";
       }

   }
       Future<void> customerAddress(BuildContext context,int x) {
         address.text="";
  return showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Center( 
          child: textCustom("Enter Customer Address", 25, Colors.black87, "style",),),
        content:TextFormField(
          controller: address,
          maxLength: 15,
          textAlign: TextAlign.center,
          keyboardType:TextInputType.number,
        autofocus: true,
        ),
        actions: <Widget>[
           Center(
             child:Container(
               width: 400,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.red, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.red,
  child: new textCustom("Cancel",25,Colors.red,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),

new OutlineButton(
      borderSide: BorderSide(
        
            color: Colors.green, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.black,
  child: new textCustom("Submit",25,Colors.green,""),
  onPressed: (){
  setState(() {
    quantity[x]=int.parse(qtyCtrlr.text) ;
    qtyCtrlr.text="";
  });
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),

                 ],
               ),
               ) 
             )
           )
        ],
      ),
      );
    },
  );
}
     Future<void> customerTin(BuildContext context,int x) {
       tinNumber.text="";
  return showDialog<void>(   
    context: context,
    builder: (BuildContext context) {

      return Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Center( 
          child: textCustom("Enter Customer TIN", 25, Colors.black87, "style",),),
        content:TextFormField(
          controller: tinNumber,
          maxLength: 15,
          textAlign: TextAlign.center,
          keyboardType:TextInputType.number,
        autofocus: true,
        ),
        actions: <Widget>[
           Center(
             child:Container(
               width: 400,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.red, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.red,
  child: new textCustom("Cancel",25,Colors.red,""),
  onPressed: (){
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),

new OutlineButton(
      borderSide: BorderSide(
            color: Colors.green, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.black,
  child: new textCustom("Submit",25,Colors.green,""),
  onPressed: (){
  setState(() {
    quantity[x]=int.parse(qtyCtrlr.text) ;
    qtyCtrlr.text="";
  });
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),
                 ],
               ),
               )
             )
           )
        ],
      ),
      );
    },
  );
}
    Timer _timer;
int _start = 10;
void startTimer() {
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) => setState(
      
      () {
          timer.cancel();
        if (_start < 9) {
          if(openDialog){
         shifting(context, 1);
        
          openDialog=false;
          }
        } else {
          _start = _start - 1;
            print(_start);
        }
      },
    ),
  );
}
  initState(){
    SunmiAidlPrint.bindPrinter();
super.initState();
controller=AnimationController(duration: Duration(milliseconds: 900),vsync: this);

  }

    void dispose() {
      _timer.cancel();
    SunmiAidlPrint.bindPrinter();
    //textYouWantToPrint.clear();
    super.dispose();

 }
 
  ///////////////variable/////
  FlutterMoneyFormatter fmfSubtotal;
  List pointsTotal=[0.0,0.0,0.0];
  double points=0.0;
  String function="";
  int sd=0;
  int lengthOfCount=0;
  bool openDialog=true;
  double subtotal=0.0;
  bool shifted=false;
  int moneyHoldertext=0;
    int itemCounter=5;
  TextEditingController qtyCtrlr=new TextEditingController();
   TextEditingController payment=new TextEditingController();
     TextEditingController tinNumber=new TextEditingController();

    TextEditingController tin=new TextEditingController();
     TextEditingController address=new TextEditingController();
  Future<void> _ackAlert(BuildContext context,int x) {
  return showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Center( 
          child: textCustom("Enter Quantity", 25, Colors.black87, "style",),),
        content:TextFormField(
          controller: qtyCtrlr,
          maxLength: 5,
          textAlign: TextAlign.center,
          keyboardType:TextInputType.number,
        autofocus: true,
        ),
        actions: <Widget>[
           Center(
             child:Container(
               width: 260,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.red, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.red,
  child: new textCustom("Cancel",25,Colors.red,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),

new OutlineButton(
      borderSide: BorderSide(
        
            color: Colors.green, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.black,
  child: new textCustom("Submit",25,Colors.green,""),
  onPressed: (){
  setState(() {
    quantity[x]=int.parse(qtyCtrlr.text) ;
    qtyCtrlr.text="";
  });
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),

                 ],
               ),
               )
             )
           )
        ],
      ),
      );
    },
  );
}
Future<void> shifting(BuildContext context,int x) {
  return showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
        title:Center( 
          child:Column(
          children: <Widget>[
            textCustom("Enter Opening Amount", 20, Colors.black, "style"),
            TextFormField(
          controller: qtyCtrlr,
          maxLength: 5,
          textAlign: TextAlign.center,
          keyboardType:TextInputType.number,
        autofocus: true,
        ),
          ],
        ),),
        actions: <Widget>[
           Center(
             child:Container(
               width: 260,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.red, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.red,
  child: new textCustom("Cancel",25,Colors.red,""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),

new OutlineButton(
      borderSide: BorderSide(
        
            color: Colors.green, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.black,
  child: new textCustom("Submit",25,Colors.green,""),
  onPressed: (){
  setState(() {
    //quantity[x]=int.parse(qtyCtrlr.text) ;
    qtyCtrlr.text="";
  });
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),

                 ],
               ),
               )
             )
           )
        ],
      ),
      );
    },
  );
}
 Future<void> _checkOut(BuildContext context,int x) {
   moneyHoldertext=0;
  return showDialog<void>(   
    
    context: context,
    builder: (BuildContext context) {
     return Container(
      //padding:EdgeInsets.only(bottom: 200) ,
       //color: Colors.green,
      // color: Colors.orange,
       width: 700,
       height: double.infinity,
       child: AlertDialog(
          // contentPadding: MediaQuery.of(context).viewInsets,
         title: Container(
              color: Colors.white12,
           width: 700,
           height: 520,
           child: Column(
             children: <Widget>[
              Container(
                height: 80,
                color: Colors.black,
                child:  Center(

                 child: textCustom("Enter Payment Amount", 30, Colors.white, "style"),
               ),
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                  Container(  
                      height: MediaQuery.of(context).size.width/3.4,
                    
                    padding: EdgeInsets.all(20),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                      textCustom("Customer Name", 25, Colors.black, ""),
                    
                      Container(
                        height: 40,
                        width: 250,
                        child: TextField(
                          controller: tin,
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                  borderRadius: BorderRadius.circular(20)
                
                ),
            
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                    fontSize: 30,
                color: Colors.black
              ),
              ),
                      ),

                   
 textCustom("Customer TIN", 25, Colors.black, ""),
                    
                      Container(
                        height: 40,
                        width: 250,
                        child: TextField(
                          controller: tin,
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                  borderRadius: BorderRadius.circular(20)
                
                ),
            
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                    fontSize: 30,
                color: Colors.black
              ),
              ),
                      ),
                       textCustom("Customer Address", 25, Colors.black, ""),
                    
                      Container(
                        height: 40,
                        width: 250,
                        child: TextField(
                          controller: tin,
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                  borderRadius: BorderRadius.circular(20)
                
                ),
            
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                    fontSize: 30,
                color: Colors.black
              ),
              ),
                      ),
                      Text(""),
                      Text(""),
                      Text(""),
                  
                        Container(
                 padding: EdgeInsets.only(bottom: 10),
                 child:  rButtonView3((){
                   if(payment.text==""){
                     paymentRestriction(context, 1);
                     
                   }
                   else if(0<subtotal){
                     
                   }
                   else{
                     SunmiAidlPrint.setAlignment(align:TEXTALIGN.CENTER);
                SunmiAidlPrint.printBarcode(text:"ReceiptBarcode",symbology: SYMBOLOGY.CODE_128,height: 20,width: 10,textPosition: TEXTPOS.ABOVE_BARCODE);
               SunmiAidlPrint.setFontSize(fontSize:30);
               
               SunmiAidlPrint.printText(text: "Trudi POS");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.setFontSize(fontSize:20);
              SunmiAidlPrint.printText(text: "Member:__________________Prokopyo tunying\n");
              SunmiAidlPrint.printText(text: "Points:___________________________$points'\n");
               SunmiAidlPrint.printText(text: "NAME     QTY     PRICE     TOTAL$points'\n");
              for(int x=0;x<productName.length;x++){
                SunmiAidlPrint.printText(text: "${productName[x]}         ${quantity[x]}          ${price[x]}         ${quantity[x]*price[x]}\n");
              }
            
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "                    Subtotal: 150.00\n");
              SunmiAidlPrint.printText(text: "                    Money: 150.00\n");
              SunmiAidlPrint.printText(text: "                    Change: 150.00\n");
              productName=[];
              quantity=[];
              price=[];
              pointsTotal=[];
              points=0;
                  Navigator.of(context).pop();

            
                   }
                 
                 },"SUBMIT",300),
               ),
                 Container(
                      padding: EdgeInsets.only(bottom: 10),
                 child:  rButtonView4((){
                   Navigator.of(context).pop();
                 },"CANCEL", 300),
               ),
                     
                     ],
                     
                   ),
                  ),
                  
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.only(right: 0,top: 0),
             height: MediaQuery.of(context).size.width/3.9,
                  width: MediaQuery.of(context).size.width/4.3,
                  child:   Column(
                   crossAxisAlignment:CrossAxisAlignment.start,
                   // crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                           Column(
                             children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 5),
                             // margin: EdgeInsets.only(bottom: 10),
                              child:     textCustom("Enter payment amount", 25, Colors.black, ""),
                            ),

                                 Container(
                        width: 250,
                        height: 40,
                        child: TextField(
                          controller: payment,
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                        
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5.0),
                  borderRadius: BorderRadius.circular(20),
                
                ),
            
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                    fontSize: 30,
                color: Colors.black
              ),
              ),
                      ),
                             ],
                           )
                        ],
                      ),
               
                 

                   Container(
                     padding: EdgeInsets.only(bottom: 11),
                     child: 
                       Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                          rButtonView2((){
                            setState(() {
                             moneyHoldertext=moneyHoldertext+1000;
                              payment.text="${moneyHoldertext.toString()}.00";

                            });

                          }, "1000", 120),
                                Text("  "),
                           rButtonView2((){
                                setState(() {
                              //payment.text="500";
                            //  String paymentHolder=payment.text;
                          moneyHoldertext=moneyHoldertext+500;
                              payment.text="${moneyHoldertext.toString()}.00";
                            });
                           }, "500 ", 120),
                       ],
                     ),
                   ),
                    
                      Container(
                        padding: EdgeInsets.only(bottom: 11),
                        child:  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                          rButtonView2((){
                               setState(() {
                           moneyHoldertext=moneyHoldertext+200;
                               payment.text="${moneyHoldertext.toString()}.00";

                            });
                          }, "200", 120),
                                Text("  "),
                           rButtonView2((){
                                setState(() {
                               moneyHoldertext=moneyHoldertext+100;
                               payment.text="${moneyHoldertext.toString()}.00";

                            });
                           }, "100 ",120),
                       ],
                     ),
                      ),
                 Container(
                        padding: EdgeInsets.only(bottom: 11),
                        child:  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                          rButtonView2((){
                               setState(() {
                             moneyHoldertext=moneyHoldertext+50;
                            payment.text="${moneyHoldertext.toString()}.00";

                            });
                          }, "50", 120),
                                Text("  "),
                           rButtonView2((){
                                setState(() {
                             moneyHoldertext=moneyHoldertext+20;
                              payment.text="${moneyHoldertext.toString()}.00";

                            });
                           }, "20 ",120),
                       ],
                     ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 11),
                        child:  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                          rButtonView2((){
                               setState(() {
                            moneyHoldertext=moneyHoldertext+10;
                               payment.text="${moneyHoldertext.toString()}.00";

                            });
                          }, "10", 120),
                                Text("  "),
                           rButtonView2((){
                                setState(() {
                            moneyHoldertext=moneyHoldertext+5;
                             payment.text="${moneyHoldertext.toString()}.00";

                            });
                           }, "5 ",120),
                       ],
                     ),
                      ),
                       Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                       children: <Widget>[
                          rButtonView2((){
                               setState(() {
                        moneyHoldertext=moneyHoldertext+1;
                           payment.text="${moneyHoldertext.toString()}.00";

                            });
                          },"1", 120),
                                Text("  "),
                           rButtonView6((){
                                setState(() {
                              payment.text="";
                              tin.text="";
                              address.text="";
                              moneyHoldertext=0;

                            });
                           },"Clear",120),
                       ],
                     ),
 
                    ],
                  ),
                ),

                 ],
               ),
             
             
             ],
           ),
         ),
       )
     );
    },
  );
}
  Future a()async{

    
    if(function=="add"){
      setState(() {
         // quantity[sd]=quantity[sd]+1;
          subtotal=subtotal+price[sd];
          function="";
      });
      print("${quantity[sd]} eto sd");
    sd=0;
    }
    else if(function=="remove"){
      setState(() {
         // quantity[sd]=quantity[sd]+1;
          subtotal=subtotal-price[sd];
          function="";
      });
      print("${quantity[sd]} eto sd");
    sd=0;
    }
    List b=[];
    for(int x=0;x<productName.length;x++){
      b.add("${productName[x]} ,${quantity[x]} ,${price[x]}");
    }
  if(b.length==0){
      emptyTable=0;
  }
  else{
     emptyTable=1;
  }
  print("eto ang b $b");
 
    return b;  
    
  }
  int emptyTable=0;
  //////// Variables/////////////////////////////////////////// 
 @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
     drawer: Theme(
        data: ThemeData.dark(),
        child: new Drawer(  //drawer holds the profile and logout function which the user can easily route
        child: new ListView( 
          children: <Widget>[
             SizedBox(
               height: 80,
               child:  new UserAccountsDrawerHeader( //Account Header which to show the picture and the name of the signed user
              accountName: Text("Prokopyo Tunying",
              style: TextStyle(fontSize: 20),
              ),

            ),
             ),
              new Container(    
                child: 
              new Column(
                children: <Widget>[
                new ListTile(
                title: new Text('Transaction', style: TextStyle(fontSize: 24),),
                trailing: new Icon(Icons.business, size: 30,),
                onTap: () {
                  Navigator.push(context, SlideRightRoute(widget: Transaction()));
                 // Navigator.of(context).push(new MaterialPageRoute( builder:(BuildContext context)=>new profile(image,name,email)));
                }),
               new Divider(),
               new ListTile(
                  title: new Text('Logout', style: TextStyle(fontSize: 24),),
                  trailing: new Icon(Icons.arrow_drop_down_circle, size: 30,),             
                   onTap: (){
                     showDialog(
                       context: context, builder: (BuildContext context){
                         return AlertDialog(
                           backgroundColor: Colors.white,
                           title: Text("",style: TextStyle(fontWeight: FontWeight.bold)),
                           content: Text("Are you sure you want to LOGOUT?", style: TextStyle(fontSize: 35), textAlign: TextAlign.center,),
                           actions: <Widget>[
                             FlatButton(
                               child: Text("Yes", style: TextStyle(fontSize: 20)),
                               onPressed: (){
                                 Navigator.push(context, SlideRightRoute(widget: HomeScreen()));
                               },
                             ),
                             FlatButton(
                               child: Text("No", style: TextStyle(fontSize: 20)),
                               onPressed: (){
                                 Navigator.pop(context);
                               },
                             ),
                           ],
                         );
                     }
                     );
                    // SharedPreferences prefs=await SharedPreferences.getInstance();
                                  //       prefs.setString("loginFB", "0");
                      //runApp(MyApp1());
                       }      
                          ),
            //new Divider(),
                ],
              ),),
          ],
        ),
      ) ,
      ),
      appBar: 
      
      PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: FadeAnimation(1.3, AppBar(title: Row(
          children: <Widget>[
            Text("AUTHs",style: TextStyle(fontSize: 50,color: Colors.orange)),
            FadeAnimation1(2,  Text("POS",style: TextStyle(fontSize: 50,fontFamily: "PSR"),),),
            


          ],
        ),
      backgroundColor: Colors.black87,
      actions: <Widget>[
              Container(
           padding: EdgeInsets.all(0),
           child:  RadialAnimation(controller: controller,),
         ),
        
      

 

      ], 
      ),
      )),
   
   
      
      body:ListView(
        children: <Widget>[
          
          
        Column(
          children: <Widget>[
        
            /*Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: textCustom1("DASHBOARD", 20, Colors.black, "style",FontWeight.bold),
            ),
            ////////////////////////////////////DASHBOARD//////////////////////////////
            Container(
              padding:EdgeInsets.only(left: 10,bottom: 10,right: 10),
              child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                      Card(
                  shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  ),
                  elevation: 2,
                  child: Container(
                        decoration: BoxDecoration(
                    color: Color(0xffff7979),
                    borderRadius:BorderRadius.circular(5)
                  ),
                    height: 60,
                    width: 140,
                   // color: Color(0xffff7979),
                    child:Center(
                      child: textCustom("Analytics", 20, Colors.white, "PSR")
                    )
                  
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Image(image: NetworkImage("https://icons-for-free.com/iconfiles/png/512/analytics-1319971782504051776.png"),fit: BoxFit.cover)
                  )
                )
                  ],
                ),
                 Stack(
                   children: <Widget>[
                     Card(
                  shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  ),
                  elevation: 2,
                  child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff686de0),
                    borderRadius:BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(5),
                    height: 60,
                    width: 140,
                    //color: Color(0xff686de0),
                    child:Center(
                      child: textCustom("Today's Transaction", 20, Colors.white, "PSR")
                    )
                  
                  ),
                ),
                   Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Image(image: NetworkImage("https://icons-for-free.com/iconfiles/png/512/Ice+cream+Cart-1320568096861440223.png"),fit: BoxFit.cover)
                  )
                )
                   ],
                 ),
               Stack(
                 children: <Widget>[
                    Card(
                  shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  ),
                  elevation: 2,
                  child: Container(
                       decoration: BoxDecoration(
                    color: Color(0xffbe2edd),
                    borderRadius:BorderRadius.circular(5)
                  ),
                  padding: EdgeInsets.all(5),
                    height: 60,
                    width: 140,
                  //  color: Color(0xfff0932b),
                    child:Center(
                      child: textCustom("Today's Items Sold", 20, Colors.white, "PSR")
                    )
                  
                  ),
                ),
                 Positioned(
                  top: -1,
                  right:-5,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Image(image: NetworkImage("https://icons-for-free.com/iconfiles/png/512/file+list+menu+task+type+icon-1320167012464782381.png"),fit: BoxFit.cover)
                  )
                )
                
                 ],
               ),
                Stack(
                  children: <Widget>[
                    Card(
                    shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  ),
                  elevation: 2,
                  child: Container(
                         decoration: BoxDecoration(
                    color: Color(0xff6ab04c),
                    borderRadius:BorderRadius.circular(5)
                  ),
                    height: 60,
                    width: 140,
                   // color: Color(0xff6ab04c),
                    child:Center(
                      child: textCustom("Total Members", 20, Colors.white, "PSR")
                    )
                  
                  ),
                ),
                 Positioned(
                  top: 0,
                  right:0,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Image(image: NetworkImage("https://icons-for-free.com/iconfiles/png/512/human+member+office+remove+remove+user+user+icon-1320183168815428124.png"),fit: BoxFit.cover)
                  )
                )
                  ],
                )
              ],
            ),
            ),*/
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 5  ,
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.1,
                    width: MediaQuery.of(context).size.width/1.509,
                    child: Column(
                      children: <Widget>[
                        Card(
                      
      elevation: 2,
       shape: BeveledRectangleBorder(
        
    borderRadius: BorderRadius.circular(5.0),),
      child: TextField(
    textAlign: TextAlign.start,  
    controller: searchCtrlr,
    onChanged: (value){
        setState(() {
         
        });
    },
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
     
        icon: Container(
          padding: EdgeInsets.only(left: 15),
          height: 50,
          width: 70,
          child: InkWell(
            onTap: (){
              
              enterBarcode();
              searchCtrlr.text="";
              
            },
            child: Image.asset("assets/q3.png", fit: BoxFit.cover,),
          )

        ),
        hintText: 'ENTER BARCODE',
        hintStyle: TextStyle(fontSize: 40),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                width: 0, 
                style: BorderStyle.none,
            ),
        ),
        filled: false,
        contentPadding: EdgeInsets.all(16),
        fillColor: Colors.white
    ),
),
    ),
    emptyTable!=0?Container(
      padding: EdgeInsets.all(10),
      child: Column(
      children: <Widget>[
      Container(
       //color: Colors.green,
        child:  Table(
         // border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          children: [TableRow(
            children:[
         Container(padding: EdgeInsets.all(10),
                child:Center(child:  textCustom1("ITEM", 33, Colors.black, "",FontWeight.bold))),
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 33, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("PRICE", 33, Colors.black, "",FontWeight.bold))),
            ]
          )],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height/1.45,
        child:  ListView.builder(
        shrinkWrap: true,
        itemCount: productName.length,
        itemBuilder: (BuildContext context, int index){
          return  index%2==0? Container(
            color: Colors.grey.withAlpha(40),
            child: Table(
           // border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [TableRow(
            children:[
                InkWell(
                  onDoubleTap: (){
                    _ackAlert(context, 1);
                  },
                  child:   Container(padding: EdgeInsets.all(10),
                child: textCustom("${productName[index]}", 20, Colors.black, "")),
                onTap: (){
                 showDialog(
                   context: context,
                   builder: (BuildContext context){
                     return AlertDialog(
                       title: Text("Product Name:",style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                       content: Text("KOJIC WHITE", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                       actions: <Widget>[
                         FlatButton(
                           child: Text("No"),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         ),
                         FlatButton(
                           child: Text("Yes"),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         )
                       ],
                     );
                   }
                 );
                },
                ),
                Container(padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[  
                   /* SizedBox(
                      height: 50,
                      child: StepperTouch(
                        initialValue: 1,
                      ),
                    ),*/
                    IconButton(
                    icon:  Icon(Icons.remove,color: Colors.red),
                    onPressed: (){
                          points=points-pointsTotal[index];
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Enter Username And Password", style: TextStyle(fontSize: 25)),
                            content: Container(
                              width: 200.0,
                              height: 200.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xFFFFF),
                                borderRadius: BorderRadius.all(Radius.circular(32.0)
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white
                                          ),
                                          child: Text("",style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                        controller: username,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          filled: false,
                                          contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            top: 10.0,
                                            right: 10.0,
                                          ),
                                          hintText: "Username", hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.black
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                        controller: password,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          filled: false,
                                          contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            top: 10.0,
                                            right: 10.0
                                          ),
                                          hintText: "Password", hintStyle: TextStyle(
                                            fontSize: 20.0, color: Colors.black
                                          )
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                                
                              ),
                              
                            ),
                            
                            
                            actions: <Widget>[
                               new FlatButton(
                                child: Text("VOID", style: TextStyle(color: Colors.black),),
                                onPressed: ()async{
                                   http.Response response = await http.get(Uri.encodeFull("http://192.168.1.115:424/api/User/GetAll"), headers: {
                                     'Accept' : 'application/json'
                                   });
                                   var reviewdata = json.decode(response.body);
                                   for (int x = 0; x < reviewdata.length; x++){
                                     if (username.text == reviewdata [x] ['firstname']) {
                                       Navigator.pop(context);
                                     }
                                     
                                   }
                                  
                                 
                                },
                              ),
                             
                             
                            ],
                          );
                        }
                      );


                      sd=index;
                      function="remove";

                   setState(() {
                     
                     if(quantity[index]==1){
                          setState(()  {
                               productName.removeAt(index);
                          });
                         
                     }
                     else{
                         quantity[index]=quantity[index]-1;
                         subtotal=0;
                     lengthOfCount=0;
                     }
                     
                   });
                    },
                    ),
                    
                     InkWell(
                        onTap: (){
                       _ackAlert(context,index);
                        },
                        child: textCustom("${quantity[index]}", 25, Colors.black, "style"),
                      ),
                     IconButton(
                    icon:  Icon(Icons.add,color: Colors.green,),
                    onPressed: (){
                      setState(() {
                         print("awerc");
                         function="add";
                         points=points+pointsTotal[index];
                         sd=index;
                          quantity[index]=quantity[index]+1;
                          subtotal=0;
                     lengthOfCount=0;
                      });
                    },
                    ),
                    
                    
                     

                  ],
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(""),
                     Container(
                       padding: EdgeInsets.only(left: 50),
                       child:  textCustom("Php ${price[index]}0", 20, Colors.black, ""),
                     ),
                     // VerticalDivider(),
                    Container(
                     
                      child:   IconButton(
                        icon: Icon(Icons.delete,color: Color(0xffED4C67),size: 25,),
                        onPressed:(){} ,
                      ),
                    )
                    ],
                  ),
                ),
              ],
            ),
            ]
          )],
      
        ),
          ): Container(
            color: Colors.white.withAlpha(50),
            child: Table(
           // border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [TableRow(
            children:[
              InkWell(
                child:   Container(padding: EdgeInsets.all(10),
                child: textCustom("${productName[index]}", 20, Colors.black, ""),),
                onTap: (){
                   showDialog(
               context: context, builder: (_) =>  AssetGiffyDialog(
                 image: Image.asset('assets/sp1.gif'),
                 buttonCancelColor: Colors.red,
                 buttonCancelText: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 20)),
                 buttonOkColor: Colors.green,
                 buttonOkText: Text("Ok", style: TextStyle(color: Colors.white, fontSize: 20)),
                 title: Text("DETAILS",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                 ),
                 description: Text("Transaction Details",style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                 textAlign: TextAlign.center),
                 entryAnimation: EntryAnimation.RIGHT,
                 onOkButtonPressed: (){
                   Navigator.pop(context);
                 },
               ));
                },
              ),
            Container(padding: EdgeInsets.all(10),
             
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                    icon:  Icon(Icons.remove,color: Colors.red,),
                    onPressed: (){
                        showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Enter Username And Password ", style: TextStyle(fontSize: 25)),
                            content: Container(
                              width: 250.0,
                              height: 220.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(0xFFFFF), 
                                borderRadius: BorderRadius.all(Radius.circular(32.0)
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white
                                          ),
                                          child: Text("",style: TextStyle(
                                            fontSize: 25, fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          filled: false,
                                          contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            top: 10.0,
                                            right: 10.0,
                                          ),
                                          hintText: 'Username',hintStyle: TextStyle(
                                            fontSize: 25, fontWeight: FontWeight.bold
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                    Expanded(
                                    child: Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          filled: false,
                                          contentPadding: EdgeInsets.only(
                                            left: 10.0,
                                            top: 10.0,
                                            right: 10.0,
                                          ),
                                          hintText: 'Password',hintStyle: TextStyle(
                                            fontSize: 25, fontWeight: FontWeight.bold
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                               new FlatButton(
                                child: Text("VOID", style: TextStyle(color: Colors.black),),
                                onPressed: ()async{
                                   http.Response response = await http.get(Uri.encodeFull("http://192.168.1.115:424/api/User/GetAll"), headers: {
                                     'Accept' : 'application/json'
                                   });
                                   var reviewdata = json.decode(response.body);
                                   for (int x = 0; x < reviewdata.length; x++){
                                     if (username.text == reviewdata [x] ['firstname']){
                                       Navigator.pop(context);
                                     }
                                     
                                   }
                                  
                                 
                                },
                              ),
                             
                             
                            ],
                          );
                        }
                      );
                      sd=index;
                      function="remove";
                       points=points-pointsTotal[index];
                      setState(() {
                         subtotal=0;
                     lengthOfCount=0;
                        if(quantity[index]==1){
                            productName.removeAt(index);
                        }
                        else{
                            quantity[index]=quantity[index]-1;
                            subtotal=0;
                     lengthOfCount=0;
                        }
                            
                      });
                
                    },
                    ),
                    
                      InkWell(
                        onTap: (){
                        _ackAlert(context,index);
                        },
                        child: textCustom("${quantity[index]}", 25, Colors.black, "style"),
                      ),
                     IconButton(
                    icon:  Icon(Icons.add,color: Colors.green,), 
                    onPressed: (){
                      setState(() {
                      
                          function="add";
                           points=points+pointsTotal[index];
                          sd=index;
                          quantity[index]=quantity[index]+1;
                          subtotal=0;
                     lengthOfCount=0;
                      });
                    },
                    ),
                    
                     

                  ],
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(""),
                      Container(
                       padding: EdgeInsets.only(left: 50),
                       child:  textCustom("Php ${price[index]}0", 20, Colors.black, ""),
                     ),
                  
                      IconButton(
                        icon: Icon(Icons.delete,color: Color(0xffED4C67),size: 25,),
                        onPressed:(){} ,
                      )
                    ],
                  ),
                ), 
              ],
            ),               
            ]
          )],
      
        ),
          );
        },
      ),
      )
  
    
  
      ],
    ),
    ):Container()
  
    ///////////////////////////////COLUMNNNNNNNNNNNNNNNN FOR TABLE CONTENTS///////////////////////////////
                      ],
                    )
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    color: Colors.black87,
                   height: MediaQuery.of(context).size.height/1.1,
                    width: MediaQuery.of(context).size.width/3.05,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        child:Stack(
                          children: <Widget>[
                             ListView(
                         // shrinkWrap: true,

                       // physics: NeverScrollableScrollPhysics(),
                        //shrinkWrap: true,
                        children: <Widget>[
                         Stack(
      children: <Widget>[
         Column(
      children: <Widget>[
         Text(""),
     
        textCustom1("Member Information", 40, Colors.greenAccent, "style",FontWeight.bold),
        Text(""),
        Text(""),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             textCustom1("Member :", 20, Colors.white, "style",FontWeight.normal),
             textCustom1("Prokopyo Tunying", 25, Colors.white, "style",FontWeight.bold),
          ],
        ),
         Text(""),
         Text(""),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             textCustom1("Points :", 20, Colors.white, "style",FontWeight.normal),
              textCustom1("$points", 20, Colors.white, "style",FontWeight.normal),
          ],
        ),
        Divider(),
     Container(
            color: Colors.grey,
            child: Table(
            border: TableBorder.all(width: 1,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(5),
                child: textCustom("NAME", 28, Colors.black, ""),),
            Container(padding: EdgeInsets.all(5),
                child: textCustom("QTY", 28, Colors.black, ""),),
            Container(padding: EdgeInsets.all(5),
                child: textCustom("PRICE", 28, Colors.black, ""),),
                 Container(padding: EdgeInsets.all(5),
                child: textCustom("TOTAL", 28, Colors.black, ""),),
            ]
          )],
      
        ),
          ),
          Container(
            height: 185,
            child: FutureBuilder(
              future: a(),

              builder: (BuildContext context, AsyncSnapshot snapshot){
                

              return  ListView.builder(
         
        //shrinkWrap: false,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index){
          List a=snapshot.data[index].toString().split(" ,");
          if(lengthOfCount!=2){
             double firstNumber=double.parse(a[1]);
          double secondNumber=double.parse(a[2]);
            subtotal=(firstNumber*secondNumber)+subtotal;
            print("sec ${a[1]}");
            print("first $subtotal");
          if(snapshot.data.length==index+1){
            lengthOfCount=2;
            print("$index");            
           }
          }
          
          return  index%2==1? Container(
            color: Colors.grey.withAlpha(40),
            child: Table(
          //  border: TableBorder.all(width: 1,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[0]}", 14, Colors.white, ""),),
              
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[1]}", 14, Colors.white, ""),),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[2]}", 14, Colors.white, ""),),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[ 
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${double.parse(a[1])*double.parse(a[2])}", 14, Colors.white, ""),),
              ],
            ),     
            ]
          )],
      
        ),
          ): Container(
            color: Colors.transparent.withAlpha(50),
            child: Table(
           // border: TableBorder.all(width: 1,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[0]}", 14, Colors.white, ""),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[1]}", 14, Colors.white, ""),),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                 child: textCustom("${a[2]}", 14, Colors.white, ""),),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                 Container(padding: EdgeInsets.all(10),
                 child: textCustom("${double.parse(a[1])*double.parse(a[2])*1}", 14, Colors.white, ""),)
              ],
            ),        
                
            ]
          )],
      
        ),
          );

        },
      );

              },
              
            )
          ),
          
      Text(""),
       Text(""),
        Text(""),
     /* Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
           textCustom1("Subtotal", 15, Colors.white, "style",FontWeight.normal),
             textCustom1("Php 100.00", 15, Colors.white, "style",FontWeight.normal),
       ],
      ),
      Text(""),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
           textCustom1("VAT", 15, Colors.white, "style",FontWeight.normal),
             textCustom1("0", 15, Colors.white, "style",FontWeight.normal),
       ],
      ),
      Divider(),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
           textCustom1("Total Amount", 15, Colors.white, "style",FontWeight.normal),
             textCustom1("Php 100.00", 15, Colors.white, "style",FontWeight.bold),
       ],
      ),*/
      Text(""),
      Text(""),
     
       
       Text(""),
        Text(""),
         
       Text(""),
        Text(""),
         
       Text(""),
        Text(""),
         
       Text(""),
        Text(""),
         
       Text(""),
        Text(""),
         
       Text(""),
        Text(""),
          
       Text(""),
       
        Text(""),
          
    
        
   /* rButtonView((){
       /*SunmiAidlPrint.setAlignment(align:TEXTALIGN.CENTER);
               SunmiAidlPrint.setFontSize(fontSize:30);
               SunmiAidlPrint.printText(text: "Trudi POS");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.setFontSize(fontSize:20);
              SunmiAidlPrint.printText(text: "Product: kojic normal1x");
              SunmiAidlPrint.setAlignment(align:TEXTALIGN.RIGHT);
               SunmiAidlPrint.printText(text: "Php 50.00\n");
               SunmiAidlPrint.setAlignment(align:TEXTALIGN.LEFT);
                SunmiAidlPrint.printText(text: "Product: kojic blue2x");
              SunmiAidlPrint.setAlignment(align:TEXTALIGN.RIGHT);
               SunmiAidlPrint.printText(text: "Php 100.00\n");
               SunmiAidlPrint.setAlignment(align:TEXTALIGN.LEFT);
                SunmiAidlPrint.printText(text: "Product: kojic white1x");
              SunmiAidlPrint.setAlignment(align:TEXTALIGN.RIGHT);
               SunmiAidlPrint.printText(text: "Php 50.00\n");
               SunmiAidlPrint.setAlignment(align:TEXTALIGN.LEFT);
               SunmiAidlPrint.printText(text: "Product: kojic green1x");
              SunmiAidlPrint.setAlignment(align:TEXTALIGN.RIGHT);
               SunmiAidlPrint.printText(text: "Php 50.00\n");
               SunmiAidlPrint.setAlignment(align:TEXTALIGN.LEFT);
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "Subtotal: 150.00\n");
              SunmiAidlPrint.printText(text: "Money: 150.00\n");
              SunmiAidlPrint.printText(text: "Change: 150.00\n");
                SunmiAidlPrint.printBitmap(bitmap:ByteData(10).buffer.asUint8List(10));
               SunmiAidlPrint.printBarcode(text:"ReceiptBarcode",symbology: SYMBOLOGY.CODE_128,height: 20,width: 10,textPosition: TEXTPOS.ABOVE_BARCODE);
               SunmiAidlPrint.unbindPrinter(); */
                  AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.ERROR,
            body: Center(child:  Text("Sorry! your email and password is not matched ",style: TextStyle(fontSize: 18,color: Colors.red), ),),
            tittle: 'This is Ignored',
            desc:   'This is also Ignored',
            btnOkColor: Colors.red,
            btnOkOnPress: (){

            }
                 ).show();
    }, "Check Out", 600),*/
 



      ],
    
      
    )
        
      ],
    )
                        ],
                      ),
                    
                      Positioned(
                        bottom: 0,
                        child: Container(
                     width: MediaQuery.of(context).size.width/3.13,
                          color: Colors.black,
                          child: Column(
                        
                            children: <Widget>[
                           Container(
                             padding: EdgeInsets.only(left: 10,top: 10,bottom: 20,right: 15),
                             child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                 Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                               
                               textCustom("SUBTOTAL : ", 16, Colors.white, "style"),
                               textCustom1("Php ${subtotal-(subtotal*0.12)}", 16, Colors.white, "style",FontWeight.bold),
                             ],),
                           Text(""),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                               
                               textCustom("VAT : ", 16, Colors.white, "style"),
                               textCustom1("Php ${subtotal*0.12}", 16, Colors.white, "style",FontWeight.bold),
                             ],),
                         
                            Divider(
                              color: Colors.greenAccent,
                            ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                               
                               textCustom("TOTAL AMOUNT : ", 23, Colors.white, "style"),
                               textCustom1("Php $subtotal", 30, Colors.greenAccent, "style",FontWeight.bold),// with formula...
                             ],)
                               ],
                             ),
                           ),
                               rButtonView((){
                                 setState(() {
                                   payment.text="";
                                   tin.text="";
                                   address.text="";
                                 });
                                 _checkOut(context, 1); 
                                // shifting(context, 1);

                         /*
                           AwesomeDialog(context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            tittle: "",
            desc: "Let us know we're doing. Please rate your experience using My Communty",
            body: Column(
              children: <Widget>[
            
                Container(
                
                    width: double.infinity,
                 //   color: Colors.black,
                    child: Center(
                      child: textCustom("CHECK OUT", 50, Colors.black, "style"),
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ) ,
                        elevation: 0,
                        child: Container(
                          
                        
                          padding: EdgeInsets.all(20),
                          //color: Colors.black87,
                          height: MediaQuery.of(context).size.height/1.5,
                          width: MediaQuery.of(context).size.width/2.6,
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                         
                              textCustom("Enter Payment Amount", 30, Colors.black, "style"),
                           Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10)
                             ),
                             padding: EdgeInsets.all(10),
                             child:   TextField(
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(20)
                
                ),
            
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                color: Colors.black
              ),
              )
                           ),
                            Text(""),
                             textCustom1("Customer Name", 30, Colors.black, "style",FontWeight.normal),
                           Container(
                             padding: EdgeInsets.all(10),
                             child:   TextField(
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                     borderRadius: BorderRadius.circular(20)
                
                ),
            
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                color: Colors.black
              ),
              )
                           ),
                           Text(""),
                            textCustom1("Customer TIN", 30, Colors.black, "style",FontWeight.normal),
                           Container(
                             padding: EdgeInsets.all(10),
                             child:   TextField(
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                     borderRadius: BorderRadius.circular(20)
                
                ),
            
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                color: Colors.black
              ),
              )
                           ),
                            Text(""),
                            textCustom1("Contact Number", 30, Colors.black, "style",FontWeight.normal),
                           Container(
                             padding: EdgeInsets.all(10),
                             child:    TextField(
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                     borderRadius: BorderRadius.circular(20)
                
                ),
            
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                color: Colors.black
              ),
              )
                           ),
                                textCustom("Total Amount : 400", 40, Colors.teal, "style"),

                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        height: MediaQuery.of(context).size.height/1.5,
                        child: 
                        Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              //Text("               "),
                              rButtonView2((){}, "500", 200),
                              Text("    "),
                              rButtonView2((){}, "1000", 200),
                            ],
                          ),
                            Text("    "),
                           Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              //Text("               "),
                              rButtonView2((){}, "100", 200),
                              Text("    "),
                              rButtonView2((){}, "200", 200),
                            ],
                          ),
                            Text("    "),
                           Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              //Text("               "),
                              rButtonView2((){}, "50", 200),
                              Text("    "),
                              rButtonView2((){}, "20", 200),
                            ],
                          ),
                          
                        ],
                      ),
                      )
                    
                    ],
                  )
                

              ],
            )
            //btnCancelText: "Not now",
           // btnCancelOnPress: () {},
           // btnOkText: "Rate",
            
          
           /* btnOkOnPress: () {
                SunmiAidlPrint.setAlignment(align:TEXTALIGN.CENTER);
               SunmiAidlPrint.setFontSize(fontSize:30);
               SunmiAidlPrint.printText(text: "Trudi POS");
              /* SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
               SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.setFontSize(fontSize:20);
              SunmiAidlPrint.printText(text: "Product: kojic normal1x");
              SunmiAidlPrint.setAlignment(align:TEXTALIGN.RIGHT);
               SunmiAidlPrint.printText(text: "Php 50.00\n");
               SunmiAidlPrint.setAlignment(align:TEXTALIGN.LEFT);
                SunmiAidlPrint.printText(text: "Product: kojic blue2x");
              SunmiAidlPrint.setAlignment(align:TEXTALIGN.RIGHT);
               SunmiAidlPrint.printText(text: "Php 100.00\n");
               SunmiAidlPrint.setAlignment(align:TEXTALIGN.LEFT);
                SunmiAidlPrint.printText(text: "Product: kojic white1x");
              SunmiAidlPrint.setAlignment(align:TEXTALIGN.RIGHT);
               SunmiAidlPrint.printText(text: "Php 50.00\n");
               SunmiAidlPrint.setAlignment(align:TEXTALIGN.LEFT);
               SunmiAidlPrint.printText(text: "Product: kojic green1x");
              SunmiAidlPrint.setAlignment(align:TEXTALIGN.RIGHT);
               SunmiAidlPrint.printText(text: "Php 50.00\n");
               SunmiAidlPrint.setAlignment(align:TEXTALIGN.LEFT);
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "\n");
              SunmiAidlPrint.printText(text: "Subtotal: 150.00\n");
              SunmiAidlPrint.printText(text: "Money: 150.00\n");
              SunmiAidlPrint.printText(text: "Change: 150.00\n");
                SunmiAidlPrint.printBitmap(bitmap:ByteData(10).buffer.asUint8List(10));
               SunmiAidlPrint.printBarcode(text:"ReceiptBarcode",symbology: SYMBOLOGY.CODE_128,height: 20,width: 10,textPosition: TEXTPOS.ABOVE_BARCODE);
               SunmiAidlPrint.unbindPrinter(); 
              // Navigator.pop(context, false);
      /* Navigator.push(context, SlideRightRoute1(
                            widget: viewreviews("...",userid,"")
                            ));
                              Navigator.push(context, SlideRightRoute1(
                            widget: viewreviews("...",userid,"")
                            ));*/*/

            }*/).show(); */ 
                        }, "Check out", MediaQuery.of(context).size.width/3.14),
                            ],
                          ),
                        )
                      )
                          ],
                        )
                      )
                      /////////////////////////////////////////MEMBERINFO CONTENT//////////////////////////
                    )
                  ),
                )
              ],
            )
          ],
        )

        ],
      )
    );
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path=Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/2, size.height-100, size.width, size.height);
    path.quadraticBezierTo(size.width*2, size.height-100, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;

  }
  @override
  bool shouldReclip(CustomClipper<Path>oldClipper){
    return true;
  }
}

class tableres extends StatefulWidget {
  
  List productName;
  List quantity;
  List price;
  tableres(this.productName,this.quantity);
  @override
  _tableresState createState() => _tableresState(productName,quantity);
}
class _tableresState extends State<tableres> {
    List productName;
  List quantity;
  _tableresState(this.productName,this.quantity);

  @override
  Widget build(BuildContext context) {
  
  }
}
//////////////////////////
///Table//////

//////////////////////MemberInformation///////////
///
class MemberInfo extends StatefulWidget {
  List productName;
  List quantity;
 MemberInfo(this.productName,this.quantity);
  @override
  _MemberInfoState createState() => _MemberInfoState(productName,quantity);
}

class _MemberInfoState extends State<MemberInfo> {
List productName;
  List quantity;
  

  _MemberInfoState(this.productName,this.quantity);
  Container accountItems(
          String item, String charge, String price, String type,
          {Color oddColour = Colors.transparent}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
            EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontSize: 20.0,color: Colors.white)),
                Text(charge, style: TextStyle(fontSize: 20.0,color: Colors.white)),
                Text(price, style: TextStyle(fontSize: 20.0,color: Colors.white)),
                Text(type, style: TextStyle(fontSize: 20.0,color: Colors.white))
              ],
            ),
            
         
          ],
        ),
      );
      
  @override
  Widget build(BuildContext context) {

  }
}
