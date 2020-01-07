import 'dart:math';


import 'package:possystem/fadeAnimation.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:possystem/main.dart';
import 'package:possystem/void.dart';
import 'package:vector_math/vector_math.dart' as prefix0;
import 'transaction.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sunmi/sunmi.dart';
import 'package:flutter/services.dart';
import 'transition.dart';
import 'utils.dart';
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
            backgroundColor: Colors.white,
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
              child: Icon(icon),backgroundColor: color,onPressed: (){print("okkkkkkkkkkkkkkkkkkkkkkkkkkk");},
            ) : FloatingActionButton(
             heroTag: "heroTag1",
              child: Icon(icon),backgroundColor: color,onPressed: (){print("okkkkkkkkkkkkkkkkkkkkkkkkkkk");},
            ),
      );
    }
  _open(){
    controller.forward();
  }
  _close(){
  //  print("oooooooooooookkkkkkkkkkkkkk");
    controller.reverse();
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: Homepage(""),
      
    );
  }
}
class Homepage extends StatefulWidget {
  String username;
  Homepage(this.username);
  @override
  _HomepageState createState() => _HomepageState(username);
}
class _HomepageState extends State<Homepage>with SingleTickerProviderStateMixin {
  String user;
  bool checkedOut=false;
  _HomepageState(this.user);
  String usernamePrefs;
  String passwordPrefs;
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  List productName=[];
  List quantity=[];
  List price=[];
  static const MethodChannel _channel = const MethodChannel('sunmi_aidl_print');
  AnimationController controller;
  TextEditingController searchCtrlr=new TextEditingController();
    @override
    Future<void> voidItem(BuildContext context,int x) {
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
          child: Column(
            children: <Widget>[
             Container(
               padding: EdgeInsets.only(bottom: 10),
               child:  textCustom("ENTER USERNAME", 25, Color(0xFFF95700), "style",),
             ),
              Container(
                        height: 40,
                        width: 250,
                        child: TextField(
                          controller: usernameVoid,
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF95700), width: 1.0),
                  borderRadius: BorderRadius.circular(5)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF95700), width: 1.0),
                  borderRadius: BorderRadius.circular(15)
                ),
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                    fontSize: 20,
                color: Colors.black
              ),
              ),
                      ),
                       Container(
               padding: EdgeInsets.only(bottom: 10,top: 20),
               child:  textCustom("ENTER PASSWORD", 25, Color(0xFFF95700), "style",),
             ),
              Container(
                        height: 40,
                        width: 250,
                        child: TextField(
                          obscureText: true,
                          controller: passwordVoid,
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF95700), width: 1.0),
                  borderRadius: BorderRadius.circular(5)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF95700), width: 1.0),
                  borderRadius: BorderRadius.circular(15)
                
                ),
            
               // hintText: 'Mobile Number',
              ),
              style: TextStyle(
                    fontSize: 20,
                color: Colors.black
              ),
              ),
                      ),
            ],
          ),),

        //content:Text(""),
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
            color: Color(0xFFF95700), //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.orange,
  child: new textCustom("OK",25,Color(0xFFF95700),""),
  onPressed: ()async{ 
     if(x==2){  
       if (usernameVoid.text == usernamePrefs ){

         counterData=0;
          replacementDiscount.clear();
                    checkedOut=true;
                   // print("$checkedOut 5d80a894c321c7152c783e69");
                     productId.clear();
                     productName.clear();
                     quantity.clear();
                     price.clear();
                    quantityDiscount=[];
                    quantityDiscountCtrlr.clear();
                    amountDiscountCtrlr.clear();
                     subtotal=0.0;
                    points=0.0;
                    discountLabel=0.0;
                    passwordVoid.text="";
                    usernameVoid.text="";
                
                     // print(a.body);
             Navigator.of(context).pop();
       }
     }
     else{
         print("objectsss");
       if (usernameVoid.text == usernamePrefs ){
         print("objectssssss");
           subtotal=subtotal-(quantity[x]*price[x]);
           print("$subtotal eto ang sub");
                            quantity.removeAt(x);
                              price.removeAt(x);
                               productName.removeAt(x);
                            points=0.0;
                            checkedOut=true;
                            //discountablePrice
                Navigator.of(context).pop();
       }
       else{
         voidFailed(context, 1);
       }
     }


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
  Future<void> discountFunction(BuildContext context,int x) {
        
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
         Container(
           height: 80,
           color: Colors.black,
           child: Center(
             child: textCustom("Discount Payment", 20, Colors.white, "style"),
           ),
         ),
    Container(
       //color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
             Container(padding: EdgeInsets.all(10),
                child:Center(child:  textCustom1("Discount Type  ", 33, Colors.black, "",FontWeight.bold))),
         
       Container(
         height: 60,
         child:  DropdownButton(
            hint: Text('Please choose a location'), // Not necessary for Option 1
            value: _selectedLocation,
            onChanged: (newValue) {
             Navigator.of(context).pop();
              setState(() {
                _selectedLocation = newValue;
              });
              discountFunction(context, 1);
            },
            items: _locations.map((location) {
              return DropdownMenuItem(
                child: new textCustom1(location, 20, Colors.black87,"style", FontWeight.normal),
                value: location,
              );
            }).toList(),
          ),
       ),
          ],
        ),
      ),
      Text(""),
    Container(
      height: 400,
      width: 700,
      child: ListView.builder(
      itemCount: productName.length,
      itemBuilder: (BuildContext context,int index){
      //  TextEditingController s=new TextEditingController(text: quantity[index].toString());
        //quantityDiscountCtrlr[index]=s;
        var textEditingController = new TextEditingController(text: "");
        quantityDiscountCtrlr.add(textEditingController);
        var textEditingController1 = new TextEditingController(text: "");
        amountDiscountCtrlr.add(textEditingController1);
         var textEditingController2 = new TextEditingController(text: "");
      discountablePrice.add(textEditingController2);
        return Container(
          // color:  index%2==0 ? Colors.grey.withAlpha(40) : Colors.white,
            child: Table(
           // border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [
            TableRow(
            children:[
                InkWell(
                  onDoubleTap: (){
                    _ackAlert(context, 1);
                  },
                  child:Container(padding: EdgeInsets.all(10),
                child: textCustom("${productName[index]}", 20, Colors.black, "")),
                onTap: (){                  
                 showDialog(
                   context: context,
                   builder: (BuildContext context){
                     return AlertDialog(
                       title: Text("Product Name",style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
                       content: Text("", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                       actions: <Widget>[
                         FlatButton(
                           child: Text("Cancel", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         ),
                         FlatButton(
                           child: Text("OK", style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Text(""),  
                   Container(
                width: 100,
                child:  TextField(
              textAlign: TextAlign.center,
                decoration: InputDecoration(
                
                  hintText: quantity[index].toString()
                ),
                 controller: quantityDiscountCtrlr[index],
                 onChanged:(value){
                  // print(value);
                  setState(() {
                   // TextEditingController a=new TextEditingController(text:quantityDiscountCtrlr[index].text );
                   if(value=="${quantity[index]}"){
                      quantityDiscount[index]="0";
                         discountablePrice[index].text="0";
                   }
                  else if(int.parse("$value")>int.parse("${quantity[index]}")){
                      quantityDiscount[index]="0";
                      discountablePrice[index].text="0";
                  } 
                   else{
                     
                       int a=int.parse("${quantity[index]}");
                        int b=int.parse("${quantityDiscountCtrlr[index].text}");
                         var c=a-b;
                      discountablePrice[index].text="${int.parse("$c")*price[index]}";
                      discountGlobal=discountablePrice[index].text;
                         TextEditingController sd=new TextEditingController(text: c.toString());
                        // quantityDiscount[index]=c.toString();
                         quantityDiscount[index]=sd;
                      print("$c asdf");
                        //quantityDiscount[index]=int.parse("${quantity[index]-quantityDiscountCtrlr[index].text}");
                   }
                  });
                 } ,
                onTap: (){
                  setState(() {
                      indexDiscount=index;
                  });
                },
               ),
              ),
                ],
              ),
             Row(
                 mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
               //  Text(""),
                  Container(
                width: 120,
                child:  TextField(
                  controller: amountDiscountCtrlr[index],
                  onChanged: (value){ 
                    if(value==null || value==""){
                      discountablePrice[index].text=discountGlobal;
                    }
                    var a=discountablePrice[index].text;
                    
                    TextEditingController b=new TextEditingController(text: discountGlobal.toString());
                   var percent="${double.parse(b.text)*(double.parse("${amountDiscountCtrlr[index].text}")/100)}";
                   
                  discountablePrice[index].text="${percent}";

                 print(percent);
                  },
               ),
              ),
               ],
             ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 // Text(""),
                  Container(
                width: 120,
                child:  TextField( 
                  controller: discountablePrice[index],
                    onChanged: (value){
                        print("object");
                    },
                 
               ),
              ),
                ],
              )
            ]
          )
          ]
          ,
      
        ),
          );


      },
    ),
    )
            ],
          )),
        content:Text(""),
        actions: <Widget>[
           Center(
             child:Container(
               width: 300,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
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
    discountLabel=0.0;
    for(int x=0;x<productName.length;x++){

      if(discountablePrice[x].text=="" || discountablePrice[x].text=="0"){
        replacementDiscount[x]="0";
      }
      else{
          replacementDiscount[x]=discountablePrice[x];
          discountLabel=discountLabel+double.parse("${discountablePrice[x].text}");
      } 
      
      
      print(replacementDiscount[x]);
    }
      setState(() {
           setState(() {
             int a=int.parse("${quantity[0]}");
            // int b=int.parse("${quantityDiscount[0]}");
             print(a);
            //  initialDiscount=int.parse(quantity[0])*int.parse(quantityDiscount[0]);
            //  print(initialDiscount);
                              // quantityDiscount[indexDiscount]=quantityDiscountCtrlr[indexDiscount];
                               print("${ quantityDiscount[indexDiscount]} eto na yunnnnn");
                             });
        //quantityDiscount[index]=
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
 Future<void> voidFailed(BuildContext context,int x) {
        
  return showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
        title:Center( 
          child: textCustom("Password/Username is not recognized.", 25, Color(0xFFF95700), "style",),),
        content:Text(""),
        actions: <Widget>[
           Center(
             child:Container(
               width: 70,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Color(0xFFF95700), //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Color(0xFFF95700),
  child: new textCustom("OK",25,Color(0xFFF95700),""),
  onPressed: (){
    
  Navigator.of(context).pop();
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
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
Future<void> cashierInfo(BuildContext context,int x) {
        
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
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    textCustom("NAME :", 25, Color(0xFFF95700), "style",),
                    textCustom("Emil", 25, Color(0xFFF95700), "style",),
                  ],
                ),
                Text(""),
                Row(
                  children: <Widget>[
                    textCustom("BIRTHDATE :", 25, Color(0xFFF95700), "style",),
                    textCustom("01/01/1999", 25, Color(0xFFF95700), "style",),
                  ],
                ),
                Text(""),
                Row(
                  children: <Widget>[
                    textCustom("EMAIL :", 25, Color(0xFFF95700), "style",),
                    textCustom("Emil@trudi.tech", 25, Color(0xFFF95700), "style",),

                  ],
                ),
                Text(""),
                Row(
                  children: <Widget>[
                    textCustom("CONTACT NO. :", 25, Color(0xFFF95700), "style",),
                    textCustom("02349273542", 25, Color(0xFFF95700), "style",),

                  ],
                ),

              ],
            ),
          )),
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
            color: Color(0xFFF95700), //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.red,
  child: new textCustom("OK",25,Color(0xFFF95700),""),
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
          child:x==1? textCustom("Please enter the payment", 25, Colors.red, "style",): textCustom("Insufficient Amount", 25, Colors.red, "style",),),
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
    color: Colors.red,
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
Future<void> transactFailed(BuildContext context,int x) {
        
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
          child: x==1? textCustom("There is no product to transact.", 25, Color(0xFFF95700), "style",) : x==2? textCustom("There is no product found.", 25, Color(0xFFF95700), "style",) : textCustom("Please Enter Closing Amount", 25, Colors.red, "style",) ,),
        content:Text(""),
        actions: <Widget>[
           Center(
             child:Container(
               width: 100,
               child: Center(
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Color(0xFFF95700), //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 1, //width of the border
          ),
    color:Color(0xFFF95700),
  child: new textCustom("OK",20,Color(0xFFF95700),""),
  onPressed: (){
      if(x==3){

      }
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
      setState(() {
         counterData=1;
      });
      int counterGate=0;
      print(searchCtrlr.text);
      http.Response response=await http.get(Uri.encodeFull("http://192.168.1.3:424/api/Inventories/getbyid/${searchCtrlr.text}"),headers: {
        "Accept":"application/json"
     });
    var reviewdata=json.decode(response.body);
    print("${reviewdata['sellingPrice']} eto ang nakuha");
    //price.removeAt(2);
    int trap=0;
    setState(() {
      for(int x=0;x<productName.length;x++){
        if(productName[x]==reviewdata['productName']){
            print("nag insert");
           //quantity.insert(x, quantity[x]+1);
           quantity[x]=quantity[x]+1;
            trap=1;
            sd=x;
              points=points+reviewdata['points'];
              function="add";
              counterGate=1;
              break;
        }
      }
      if(trap==0 && reviewdata['sellingPrice']!=null ){ 
        replacementDiscount.add("0");
        quantityDiscount.add("0");
        print("$quantityDiscount eto ang quantity discount");
       productId.add(reviewdata['productId']);
       // function="add";
       print("${reviewdata['productId']} eto ang product id");
price.add(reviewdata['sellingPrice']);
quantity.add(1);
productName.add(reviewdata['productName']);
    points=points+reviewdata['points'];
    pointsTotal.add(reviewdata['points']);
  trap=1;
  counterGate=1;
      }
  //quantity.insert(2, 10);
  if(productName.indexOf(reviewdata['productName'])<0){
      print("okkkk");
  }
    });
    sd=productName.length-1;
    if(checkedOut==true){
       function="add";
       checkedOut=false;
    }
 print("eto ang prod ${productName.length}");
       if(productName.length>1){
        function="add";
       }
       if(counterGate==0){
         transactFailed(context, 2);
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
            color: Color(0xFFF95700), //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.black,
  child: new textCustom("Check out",25,Color(0xFFF95700),""),
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
               ), 
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
          borderRadius:BorderRadius.circular(15),
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      backgroundColor: Colors.white,
        title:Center( 
          child: textCustom("Enter Customer TIN", 25, Colors.black87, "style",),),
        content:TextFormField(
          textCapitalization: TextCapitalization.sentences,
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
               height: 200,
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
    color: Colors.black,
  child: new textCustom("Submit",25,Colors.green,""),
  onPressed: (){
  setState(() {
    quantity[x]=int.parse(qtyCtrlr.text);
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
void startTimer()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  setState(() {
    
    usernamePrefs=prefs.getString("userName");
  passwordPrefs=prefs.getString("userPass");
  });
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) => setState(
      
      () {
          timer.cancel();
        if (_start < 9) {
          if(openDialog){
           if(prefs.getString("openingAmount")!="0.0"){
              print("pumasok na dito");
            }
            else{
              shifting(context, 1);
            }
          openDialog=false;
          }
        } 
        else {
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
  List replacementDiscount=[];
  int counterData=1;
  double totalAmountSave=0;
  TextEditingController closingAmountText=new TextEditingController();
  List<String> _locations = ['QUANTITY', 'PERCENT']; // Option 2
  String _selectedLocation; 
  ///////////////variable/////
  List quantityDiscount=[];
  int initialDiscount=0;
  double discountLabel=0.0;
  var discountGlobal;
  int indexDiscount;
  List priceDiscount=[];
   List<TextEditingController> quantityDiscountCtrlr=[];
   List<TextEditingController>amountDiscountCtrlr=[];
   TextEditingController priceDiscountCtrlr=new TextEditingController();
  TextEditingController usernameVoid=new TextEditingController();
   TextEditingController passwordVoid=new TextEditingController();
  FlutterMoneyFormatter fmfSubtotal;
  List productId=[];
  List pointsTotal=[];
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
    sd=x;
    subtotal=0;
    //function="add";
    quantity[x]=int.parse(qtyCtrlr.text) ;
    for(int x=0;x<productName.length;x++){
        subtotal=subtotal+(price[x]*quantity[x]);
        
    }
    qtyCtrlr.text="";
    print(quantity[x]); 
    //subtotal=price[x]*quantity[x];
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
Future<void> shifting(BuildContext context,int x) async{
  SharedPreferences prefs=await SharedPreferences.getInstance();

  return showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return   
  Container(
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
              onFieldSubmitted: (value) async{
 SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("openingAmount","${openingA.text}");

  setState(() {
    //quantity[x]=int.parse(qtyCtrlr.text) ;
    qtyCtrlr.text="";
  });
  Navigator.of(context).pop();
              },
          controller: openingA,
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
               child: Center(
                 child:  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: <Widget>[
                   new OutlineButton(
      borderSide: BorderSide(
            color: Colors.red, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.red,
  child: new textCustom("Cancel",20,Colors.red,""),
  onPressed: (){
    prefs.setString("userUsed", "notUsed");
                                  prefs.setString("openingAmount", "0.0");
                                  prefs.setString("userName", "");
                                  prefs.setString("userPass", "");
                                  prefs.setStringList("tranhistory", []);
                                  prefs.setString("available","");
                                 Navigator.push(context, SlideRightRoute(widget: SignIn1()));
  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
),
Text(""),
Text(""),
Text(""),
Text(""),
Text(""),
Text(""),
Text(""),
Text(""),
Text(""),
new OutlineButton(
      borderSide: BorderSide(
            color: Colors.green, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Colors.black,
  child: new textCustom("Submit",20,Colors.green,""),
  onPressed: ()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("openingAmount","${openingA.text}");

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
       child:FadeAnimation(0.5, AlertDialog(
          // contentPadding: MediaQuery.of(context).viewInsets,
         title: Container(
              color: Colors.white12,
           width: 700,
           height: 550,
           child: Column(
             children: <Widget>[
              Container(
                height: 60,
                color: Colors.deepOrange,
                child:  Center(

                 child: textCustom("Enter Payment Amount", 30, Colors.white, "style"),
               ),
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                  Container(  
                      height: MediaQuery.of(context).size.width/2.9,
                    
                    padding: EdgeInsets.all(30),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                      textCustom("Customer Name", 25, Colors.black, ""),
                    
                      Container(
                        height: 55,
                        width: 300,
                        child: TextField(
                          controller: customerName,
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10)
                
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
                        height: 55,
                        width: 300,
                        child: TextField(
                          controller: tin,
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                 
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10)
                
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
                       height: 55,
                        width: 300,
                        child: TextField(
                          controller: address,
                               textAlign: TextAlign.center,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10)
                
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
                     
                  
                        Container(
                 padding: EdgeInsets.only(bottom: 0.5),         
                 child:  rButtonView3(() async{
                   if(productName.length==0){
                     Navigator.pop(context);
                      transactFailed(context, 1);
                   }
                   else{
                      if(payment.text==""){
                     paymentRestriction(context, 1);
                     
                   }
                   else if(double.parse(payment.text)>=subtotal-discountLabel){
                     var header=  await http.post("http://192.168.1.3:424/api/TranHeader/Add",body:{
                       "discount":"$discountLabel","receiptNo":"001","vat":"${subtotal*0.12}","memberName":"Prokopyo tunying","subtotal":"${subtotal-(subtotal*0.12)}"
                       ,"totalAmt":"${subtotal-discountLabel}","payment":"${double.parse("${payment.text}")}","memberPoints":"$points"
                       
                     });
                     final myString = '${header.body}';
var headers = myString.replaceAll(RegExp('"'), ''); 
print("object $headers");
                     for(int x=0;x<productName.length;x++){
                            await http.post("http://192.168.1.3:424/api/TranDetails/add",body:{
                       "sellingPrice":"${price[x]}","categoryDesc":"safeguard",
                       "productId":"${productId[x]}",
                       "amount":"${price[x]}",
//"productName":"${productName[x]}",
"quantity":"${quantity[x]}",
"points":"20",
//"productId":"5d81a87ac321c71124c19dfc",
"headerId":"$headers"
                     });
                     }
                      //   SunmiAidlPrint.setAlignment(align:TEXTALIGN.CENTER);
               // SunmiAidlPrint.printBarcode(text:"ReceiptBarcode",symbology: SYMBOLOGY.CODE_128   ,height: 20,width: 10,textPosition: TEXTPOS.ABOVE_BARCODE);
              // SunmiAidlPrint.setFontSize(fontSize:30);
            
              //SunmiAidlPrint.printText(text: "             Trudi POS");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.setFontSize(fontSize:20);
              //SunmiAidlPrint.printText(text: "Member:                             Prokopyo tunying\n");
              //SunmiAidlPrint.printText(text: "Points:                             $points'\n");
              //SunmiAidlPrint.printText(text: "ITEM     QTY     PRICE     TOTAL \n");
              //for(int x=0;x<productName.length;x++){
            // SunmiAidlPrint.printText(text: "${productName[x]}         ${quantity[x]}          ${price[x]}         ${quantity[x]*price[x]}\n");
              //}
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "\n");
              //SunmiAidlPrint.printText(text: "                                     Vat: ${FlutterMoneyFormatter(amount:subtotal*0.12).output.nonSymbol}\n");
              //SunmiAidlPrint.printText(text: "                                     Subtotal: ${FlutterMoneyFormatter(amount:subtotal-(subtotal*0.12)).output.nonSymbol}\n");
              //SunmiAidlPrint.printText(text: "                                     Money: ${FlutterMoneyFormatter(amount:double.parse(payment.text)).output.nonSymbol}\n");
              //SunmiAidlPrint.printText(text: "                                     Change: ${FlutterMoneyFormatter(amount:subtotal-discountLabel).output.nonSymbol}\n");
              productName=[];
              quantity=[];
              price=[];
              pointsTotal=[];
              points=0;
                     totalAmountSave+=subtotal-discountLabel;
                    setState(() {
                      counterData=0;
                       replacementDiscount.clear();
                    checkedOut=true;
                   // print("$checkedOut 5d80a894c321c7152c783e69");
                     productId.clear();
                     productName.clear();
                     quantity.clear();
                     price.clear();
                    quantityDiscount=[];
                    quantityDiscountCtrlr.clear();
                    amountDiscountCtrlr.clear();
                     subtotal=0.0;
                    points=0.0;
                    discountLabel=0.0;
                     
                    });
                    
                     // print(a.body);
                     SharedPreferences prefs=await SharedPreferences.getInstance();
                   // List tranhis1=prefs.getStringList("tranhistory");
                   if(prefs.getStringList("tranhistory")==[]){

                   }
                   else if(tranhis.length==0){
                    print("${prefs.getStringList("tranhistory")} wearcerwerawr");
                      tranhis=prefs.getStringList("tranhistory");
                      tranhis.add("$headers");
                   }
                   else{
                      tranhis.add("$headers");
                   prefs.setStringList("tranhistory",tranhis);
                   }
                 
                  
                          print("dumaan sa header");
                   
             Navigator.of(context).pop();
                   }
                   else{
                     paymentRestriction(context, 2);                
                 
                

            
                   }
                   }
                  
                 
                 },"CHECKOUT",300)),
                 Text(""),

                 Container(
                      padding: EdgeInsets.only(bottom: 180),
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
                  padding: EdgeInsets.only(right: 0,top: 0,left: 50),
             height: MediaQuery.of(context).size.width/2.9,
                  width: MediaQuery.of(context).size.width/4.3,
                  child:   Column(
                   crossAxisAlignment:CrossAxisAlignment.start,
                   // crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                           Column(
                             children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                             // margin: EdgeInsets.only(bottom: 10),
                              child:     textCustom("Enter payment amount", 25, Colors.black, ""),
                            ),
                            
                                 Container(
                        width: 200,
                        height: 60,
                        child: TextField(

                          textCapitalization: TextCapitalization.sentences,
                          controller: payment,
                          textAlign: TextAlign.center,
                decoration: new InputDecoration(

             
                
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(20)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
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
                  
                 
                    Text(""),
                   Container(
                     padding: EdgeInsets.only(bottom: 11),
                     child: 
                       Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                          rButtonView2((){
                               setState(() {
                        moneyHoldertext=moneyHoldertext+1;
                           payment.text="${moneyHoldertext.toString()}.00";

                            });
                          },"1", 120,),
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
     ));
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

 
    return b;  
    
  }
  List<String> tranhis=[];
  int emptyTable=0;
  TextEditingController openingA=new TextEditingController();
 List<TextEditingController> discountablePrice=[];
 TextEditingController customerName= new TextEditingController();
  //TextEditingController customerTin= new TextEditingController();
   //TextEditingController customerAddress= new TextEditingController();
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
              accountName: Text("$usernamePrefs",
              style: TextStyle(fontSize: 30,color: Colors.white),
                ),
              ),
             ),
              new Container(    
                child: 
              new Column(
                children: <Widget>[
                new ListTile(
                title: new Text('Transaction', style: TextStyle(fontSize: 20,
                 color: Colors.white),),
                trailing: new Icon(Icons.account_balance, size: 30,),
                onTap: () async{
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  Navigator.pop(context);
                  Navigator.push(context, SlideRightRoute(widget: Transaction(prefs.getString("openingAmount"),prefs.getStringList("tranhistory"),totalAmountSave)));
                 // Navigator.of(context).push(new MaterialPageRoute( builder:(BuildContext c ontext)=>new profile(image,name,email)));
                }),
                 new ListTile(
                title: new Text('Void', style: TextStyle(fontSize: 20, color: Colors.white),),
                trailing: new Icon(Icons.delete_outline, size: 30,),
                onTap: () {
                  if(productName.length==0){
                     Navigator.pop(context);
                  }
                 else{
                        voidItem(context, 2);
                 }
              //    Navigator.push(context, SlideRightRoute(widget: Void()));
         
                 // Navigator.of(context).push(new MaterialPageRoute( builder:(BuildContext context)=>new profile(image,name,email)));
                }),
                 new ListTile(
                title: new Text('Discount', style: TextStyle(fontSize: 20, color: Colors.white),),
                trailing: new Icon(Icons.assignment, size: 30,),
                onTap: () {
                  Navigator.pop(context);
                  if(productName.length==0){
                  }
                  else{
                      quantityDiscountCtrlr.clear();
                      amountDiscountCtrlr.clear();
                      //discountablePrice.clear();
                  discountFunction(context, 1);
                  }
                 // Navigator.of(context).push(new MaterialPageRoute( builder:(BuildContext context)=>new profile(image,name,email)));
                }),
               new Divider(),
               new ListTile(
                  title: new Text('Close Shift', style: TextStyle(fontSize: 20, color: Colors.white),),
                  trailing: new Icon(Icons.arrow_drop_down_circle, size: 30,),             
                   onTap: ()async{
                     SharedPreferences prefs=await SharedPreferences.getInstance();
                     Navigator.of(context).pop();
                     showDialog(
                      
                       context: context, builder: (BuildContext context){
                      
                         return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                           backgroundColor: Colors.white,
                           title: Container(
                             child: Center(
                               child: Column(
                                 children: <Widget>[
                                   Text("Enter Closing Amount", style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                                 
                                   Text(""),
                                   Container(
                                     width: 300,
                                     child: TextField(
                                       onSubmitted: (value)async{
                                            SharedPreferences prefs=await SharedPreferences.getInstance();
                                  prefs.setString("userUsed", "notUsed");
                                  prefs.setString("openingAmount", "0.0");
                                  prefs.setString("userName", "");
                                  prefs.setString("userPass", "");
                                  prefs.setStringList("tranhistory", []);
                                  prefs.setString("available","");
                                 Navigator.push(context, SlideRightRoute(widget: SignIn1()));
                                       },
                                       controller: closingAmountText,
                                       textAlign: TextAlign.center,
                                     ),
                                   )
                                 ],
                               ),
                             ),
                           ),
                           //content: 
                           actions: <Widget>[
                               Center(
                                 child: Container(
                                   child: Row(
                                     children: <Widget>[
                                       OutlineButton(
                                         borderSide: BorderSide(
                                           color: Colors.red,
                                           style: BorderStyle.solid,
                                           width: 2,
                                         ),
                                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                         color: Colors.red,
                                         child: new textCustom("Cancel", 20, Colors.red, ""),
                                         onPressed: (){
                                           Navigator.pop(context);
                                         },
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                               Text(""),
                               Text(""),
                               Text(""),
                              OutlineButton(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  style: BorderStyle.solid,
                                  width: 3,
                                ),
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                               child: Text("Confirm", style: TextStyle(fontSize: 20,color: Colors.green)),
                               onPressed: () async{
                                 if(closingAmountText.text==""){
                                   transactFailed(context, 3);
                                 }
                                 else{
                                     SharedPreferences prefs=await SharedPreferences.getInstance();
                                  prefs.setString("userUsed", "notUsed");
                                  prefs.setString("openingAmount", "0.0");
                                  prefs.setString("userName", "");
                                  prefs.setString("userPass", "");
                                  prefs.setStringList("tranhistory", []);
                                  prefs.setString("available","");
                                 Navigator.push(context, SlideRightRoute(widget: SignIn1()));
                                 }
                                
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
                          new ListTile(
                  title: new Text('Logout', style: TextStyle(fontSize: 20, color: Colors.white),),
                  trailing: new Icon(Icons.arrow_drop_down_circle, size: 30,),      
                   onTap: (){
                     showDialog(
                       context: context, builder: (BuildContext context){
                         return AlertDialog(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                           backgroundColor: Colors.white,
                           title: Text("",style: TextStyle(fontWeight: FontWeight.bold)),
                           content: Text("Are you sure you want to logout?", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                           actions: <Widget>[
                             new OutlineButton(
                             borderSide: BorderSide(
                             color: Colors.red, //Color of the border
                             style: BorderStyle.solid, //Style of the border
                             width: 2, //width of the border
                           ),
                             color:Colors.red,
                           child: new textCustom("No",20,Colors.red,""),
                           onPressed: (){
    
                           Navigator.of(context).pop();
                          },
                           shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0))
                          ),
                             Text(""),
                             Text(""),
                             Text(""),
                             
                             OutlineButton(
                             borderSide: BorderSide(
                               color: Colors.green,
                               style: BorderStyle.solid,
                               width: 2,
                             ),
                              child: Text("Yes", style: TextStyle(fontSize: 20, color: Colors.green)),
                               onPressed: () async{
                                  SharedPreferences prefs=await SharedPreferences.getInstance();
                                  prefs.setString("available", "avail");
                                 Navigator.push(context, SlideRightRoute(widget: SignIn1()));
                               },
                               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
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
            Text("",style: TextStyle(fontSize: 50,color: Colors.white)),
            FadeAnimation1(2,  Text("POS",style: TextStyle(fontSize: 50,fontFamily: "PSR", color: Colors.white),),),
            


          ],
        ),
      backgroundColor: Color(0xFFF95700),
      actions: <Widget>[
              Container(
           padding: EdgeInsets.all(0),
           child:IconButton(
             iconSize: 40,
             icon: Icon(Icons.person_pin,color: Colors.white,),
             onPressed: (){
               cashierInfo(context, 1);
             },
           )
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
    onSubmitted: (value){
        enterBarcode();
              searchCtrlr.text="";
    },
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
     
        icon: Container(
          padding: EdgeInsets.only(left: 15),
          height: 50,
          width: 70,
          child: InkWell(
            onTap: (){
              
              
              
            },
            child: Image.asset("assets/q3.png", fit: BoxFit.cover,),
          )

        ),
        hintText: 'ENTER BARCODE',
        hintStyle: TextStyle(fontSize: 18),
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
                child: Center(child:  textCustom1("ITEM", 33, Colors.black, "",FontWeight.bold))),
          Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("QUANTITY", 33, Colors.black, "",FontWeight.bold))),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom1("PRICE", 33, Colors.black, "",FontWeight.bold))),
            ],
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
                  child:   Container(padding: EdgeInsets.only(left: 10,
                  top: 23),
                child: textCustom("${productName[index]}", 20, Colors.black, "")),
                onTap: (){
                 showDialog(
                   context: context,
                   builder: (BuildContext context){
                     return AlertDialog(
                       title: Text("Product Name",style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
                       content: Text("", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                       actions: <Widget>[
                         FlatButton(
                           child: Text("Cancel", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                           onPressed: (){
                             Navigator.pop(context);
                           },
                         ),
                         FlatButton(
                           child: Text("OK", style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
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
                    icon:  Icon(Icons.remove,color: Colors.black),
                    onPressed: (){
                          

                   setState(() {
                     
                     if(quantity[index]==1){
                          
                         
                     }
                     else{
                       points=points-pointsTotal[index];
                  
                      sd=index;
                      function="remove";
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
                        child: quantityDiscount[index]=="0" || quantityDiscount[index]==null || quantityDiscount[index]=="" || quantityDiscount[index]=="${quantity[index]}" ? textCustom("${quantity[index]}", 25, Colors.black, "style") : textCustom("${quantity[index]}(-${quantityDiscount[index].text})", 25, Colors.black, "style"),
                      ),
                     IconButton(
                    icon:  Icon(Icons.add,color: Color(0xFFF95700),),
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
                       child:  textCustom("Php ${FlutterMoneyFormatter(amount:price[index]).output.nonSymbol}", 20, Colors.black, ""),
                     ),
                     // VerticalDivider(),
                    Container(
                     
                      child:   IconButton(

                        icon: Icon(Icons.delete,color: Colors.black,size: 25,),
                        onPressed:(){
                          voidItem(context, index);
                              
                          //voidItem(context, 1);
                        } ,
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
                 image:Image(image: NetworkImage("https://images-na.ssl-images-amazon.com/images/I/81yMUvgpSLL._SL1500_.jpg"),),
                 buttonCancelColor: Colors.red,
                 buttonCancelText: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 20)),
                 buttonOkColor: Colors.green,
                 buttonOkText: Text("Ok", style: TextStyle(color: Colors.white, fontSize: 20)),
                 title: Text("Discount",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                 ),
                 description: Text("Transaction Details",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                    icon:  Icon(Icons.remove,color: Colors.black,),
                    onPressed: (){
                        
                    
                      setState(() {
                         subtotal=0;
                     lengthOfCount=0;
                        if(quantity[index]==1){
                      
                        }
                        else{
                            quantity[index]=quantity[index]-1;
                            subtotal=0;
                     lengthOfCount=0;
                       sd=index;
                      function="remove";
                       points=points-pointsTotal[index];
                        }
                             
                      });
                
                    },
                    ),
                    
                      InkWell(
                        onTap: (){
                        _ackAlert(context,index);
                        },
                        child: quantityDiscount[index]=="0" || quantityDiscount[index]==null? textCustom("${quantity[index]}", 25, Colors.black, "style") : textCustom("${quantity[index]}(-${quantityDiscount[index].text})", 25, Colors.black, "style"),
                      ),
                     IconButton(
                    icon:  Icon(Icons.add,color: Color(0xFFF95700)), 
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
                       child:  textCustom("Php ${FlutterMoneyFormatter(amount:price[index]).output.nonSymbol}", 20, Colors.black, ""),
                     ),
                  
                      IconButton(
                        icon: Icon(Icons.delete,color: Colors.black,size: 25,),
                        onPressed:(){
                          
                          voidItem(context, index);
                        } ,
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
                    color: Colors.white,
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
     
        Container(
        
          child: Center(
            child:  textCustom1("Member Information", 25, Colors.black, "style",FontWeight.bold),
          ),
        ),
        Text(""),
        Text(""),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             textCustom1("Member :", 15, Colors.black, "style",FontWeight.bold),
             textCustom1("Prokopyo Tunying", 15, Colors.black, "style",FontWeight.bold),
          ],
        ),
         Text(""),
         Text(""),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             textCustom1("Points :", 15, Colors.black, "style",FontWeight.bold),
              textCustom1("${FlutterMoneyFormatter(amount:points).output.nonSymbol}", 15, Colors.black, "style",FontWeight.bold),
          ],
        ),
        Divider(height: 5,),
     Container(
            color: Colors.white,
            child: Table(
            border: TableBorder.all(width: .1 ,color: Colors.white),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(5),
                child: textCustom1("ITEM", 23, Colors.black, "",FontWeight.bold),),
            Container(padding: EdgeInsets.all(5),
                child: textCustom1("QTY", 23, Colors.black, "",FontWeight.bold),),
            Container(padding: EdgeInsets.all(5),
                child: textCustom1("PRICE", 23, Colors.black, "",FontWeight.bold),),
                 Container(padding: EdgeInsets.all(5),
                child: textCustom1("TOTAL", 23, Colors.black, "",FontWeight.bold),),
            ]
          )],
      
        ),
          ),
          Container(
            height: 185,
            child: FutureBuilder(
              future: a(),

              builder: (BuildContext context, AsyncSnapshot snapshot){
                
                
              return snapshot.data==null?Container() : ListView.builder(
         
        //shrinkWrap: false,
        itemCount: counterData!=0 ? snapshot.data.length : 0,
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
    
 FlutterMoneyFormatter fmf1 = FlutterMoneyFormatter(
    amount: double.parse(a[1])
);
 FlutterMoneyFormatter fmf2 = FlutterMoneyFormatter(
    amount:double.parse(a[2])
);
 FlutterMoneyFormatter total = FlutterMoneyFormatter(
    amount:double.parse(a[1])*double.parse(a[2])
);

          
          return  index%2==0? Container(
            color: Colors.grey.withAlpha(40),
            child: Table(
          //  border: TableBorder.all(width: 1,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[0]}", 15, Colors.black, ""),),
              
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[1]}", 15, Colors.black, ""),),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${fmf2.output.nonSymbol}", 15, Colors.black, ""),),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ 
                Container(padding: EdgeInsets.all(10),
                child: replacementDiscount[index]=="0" || replacementDiscount[index]==null ||replacementDiscount[index]==""  ? textCustom("${total.output.nonSymbol}", 15, Colors.black, "") : textCustom("${total.output.nonSymbol}(-${replacementDiscount[index].text})", 10, Colors.black, ""),),
              ],
            ),     
            ]
          )],
      
        ),
          ): Container(
            color: Colors.white,
            child: Table(
           // border: TableBorder.all(width: 1,color: Colors.black87),
          children: [TableRow(
            children:[
                Center(
                  child: Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[0]}", 15, Colors.black, ""),),
                ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               Center(
                 child:  Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[1]}", 15, Colors.black, ""),),
               )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Center(
                   child: Container(padding: EdgeInsets.all(10),
                 child: textCustom("${fmf2.output.nonSymbol}", 15, Colors.black, ""),),
                 ),
               
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Center(
                   child: Container(padding: EdgeInsets.all(10),
                 child: replacementDiscount[index]=="0"  || replacementDiscount[index]==null ||replacementDiscount[index]=="" || replacementDiscount[index]==0  ? textCustom("${total.output.nonSymbol}", 15, Colors.black, "") : textCustom("${total.output.nonSymbol}(-${replacementDiscount[index].text})", 10, Colors.black, ""),),
                 ),
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
                          color: Colors.white60,
                          child: Column(
                        
                            children: <Widget>[
                             // Divider(),
                           Container(
                             padding: EdgeInsets.only(left: 10,top: 10,bottom: 20,right: 15),
                             child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                discountLabel!=0.0?    Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                               
                               textCustom1("Discount : ", 15, Colors.black, "style",FontWeight.bold),
                               textCustom1("Php -${discountLabel}", 15, Colors.red, "style",FontWeight.bold),
                             ],):Container(),
                                  Text(""),
                                 Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                               
                               textCustom1("SUBTOTAL : ", 15, Colors.black, "style",FontWeight.bold),
                               textCustom1("Php ${FlutterMoneyFormatter(amount:subtotal-(subtotal*0.12)).output.nonSymbol}", 15, Colors.black, "style",FontWeight.bold),
                             ],),
                           Text(""),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                               
                               textCustom1("VAT : ", 15, Colors.black, "style",FontWeight.bold),
                               textCustom1("Php ${FlutterMoneyFormatter(amount:subtotal*0.12).output.nonSymbol}", 15, Colors.black, "style",FontWeight.bold),
                             ],),
                         
                            Divider(
                              color: Colors.black,
                            ),
                           
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                               
                              
                               textCustom1("Php ${FlutterMoneyFormatter(amount:subtotal-discountLabel).output.nonSymbol}", 30, Colors.black, "style",FontWeight.bold),// with formula...
                             ],),
                              Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                               
                              
                               textCustom1("(TOTAL AMOUNT)", 15, Colors.black, "style",FontWeight.bold),// with formula...
                             ],),
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
