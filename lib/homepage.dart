import 'dart:math';

import 'package:possystem/fadeAnimation.dart';

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
 List productName=["Head and Shoulder","Kojic white","Safeguard Family Size XXL"];
  List quantity=[1,1,1];
  static const MethodChannel _channel = const MethodChannel('sunmi_aidl_print');
  AnimationController controller;
  TextEditingController searchCtrlr=new TextEditingController();
    @override
  initState(){
    SunmiAidlPrint.bindPrinter();
super.initState();
controller=AnimationController(duration: Duration(milliseconds: 900),vsync: this);

  }
    void dispose() {
    SunmiAidlPrint.bindPrinter();
    //textYouWantToPrint.clear();
    super.dispose();
    
  }
    int itemCounter=5;
  TextEditingController qtyCtrlr=new TextEditingController();
  Future<void> _ackAlert(BuildContext context,int x) {
  return showDialog<void>(   
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(15)
        ),
        child: AlertDialog(
        title:Center( 
          child: textCustom("Enter Quantity", 25, Colors.black, "style"),),
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
    color:Color(0xff30336b),
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
  Future a()async{


    List b=[];
    for(int x=0;x<productName.length;x++){
      b.add("${productName[x]} ,${quantity[x]}");
      
    }
    return b;  
  }
  
  
 
  //////// Variables///////////////////////////////////////////
 @override
  Widget build(BuildContext context) {
    return Scaffold(
     drawer: Theme(
        data: ThemeData.dark(),
        child: new Drawer(  //drawer holds the profile and logout function which the user can easily route
        child: new ListView( 
          children: <Widget>[
             SizedBox(
               height: 80,
               child:  new UserAccountsDrawerHeader( //Account Header which to show the picture and the name of the signed user
              accountName: Text("Jervin Macalawa"),
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
                Divider(),
                new ListTile(
                title: new Text('Products', style: TextStyle(fontSize: 24),),
                trailing: new Icon(Icons.shopping_basket, size: 30,),
                onTap: () {
                  Navigator.of(context).pop();
                 // Navigator.of(context).push(new MaterialPageRoute( builder:(BuildContext context)=>new profile(image,name,email)));
                }),
               new Divider(),
                new ListTile(
                title: new Text('Void', style: TextStyle(fontSize: 24),),
                trailing: new Icon(Icons.remove_shopping_cart, size: 30,),
                onTap: () {
                  Navigator.of(context).pop();
                 // Navigator.of(context).push(new MaterialPageRoute( builder:(BuildContext context)=>new profile(image,name,email)));
                }),
               new ListTile(
                  title: new Text('Logout', style: TextStyle(fontSize: 24),),
                  trailing: new Icon(Icons.arrow_drop_down_circle, size: 30,),             
                   onTap: () async{ 
                     Navigator.push(context, SlideRightRoute(widget: HomeScreen()));
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
            Text("AUTH",style: TextStyle(fontSize: 50,color: Colors.orange),),
            FadeAnimation1(2,  Text("POS",style: TextStyle(fontSize: 50,fontFamily: "PSR"),),),
            
           
          
          ],
        ),
      backgroundColor: Colors.black,
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
          padding: EdgeInsets.only(left: 10),
          height: 50,
          width: 70,
          child: Image(image: NetworkImage("https://icons-for-free.com/iconfiles/png/512/upload+icon+upload+line+icon+icon-1320073121636456908.png"),fit: BoxFit.cover),

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
    Container(
      
      padding: EdgeInsets.all(10),
      child: Column(
      children: <Widget>[
        
      Container(
        color: Colors.orange.withAlpha(50),
        child:  Table(
          border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          
          children: [TableRow(
            children:[
         Container(padding: EdgeInsets.all(10),
                child:Center(child:  textCustom("ITEM", 25, Colors.black, ""),)),
          Container(padding: EdgeInsets.all(10),
                child:
                   Center(child:  textCustom("QUANTITY", 25, Colors.black, ""),)
                  
                ),
           Container(padding: EdgeInsets.all(10),
                child: Center(child:  textCustom("PRICE", 25, Colors.black, ""),)),
                
            ]
          )],
      
        ),
      ),

      Container(
        height: MediaQuery.of(context).size.height/1.45,
        child:  ListView.builder(
        shrinkWrap: true,
        itemCount: productName.length,
        itemBuilder: (BuildContext context, int index){
          return  index%2==1? Container(
            color: Colors.grey.withAlpha(40),
            child: Table(
            border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${index+1}. ${productName[index]}", 20, Colors.black, ""),),
            Container(padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                   /* SizedBox(
                      height: 50,
                      child: StepperTouch(
                        initialValue: 1,
                        
                      ),
                    ),*/
                    IconButton(
                    icon:  Icon(Icons.remove,color: Colors.red,), 
                    onPressed: (){
                   setState(() {
                     if(quantity[index]==1){
                        
                          setState(()  {
                               productName.removeAt(index);
                          });
                         
                     }
                     else{
                         quantity[index]=quantity[index]-1;
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
                          quantity[index]=quantity[index]+1;
                      });
                      
                    },
                    ),
                    
                    
                     

                  ],
                )),
            Container(padding: EdgeInsets.all(10),
                child: Center(
                  child: textCustom("Php 50.00", 20, Colors.black, ""),
                )),
            ]
          )],
      
        ),
          ): Container(
            color: Colors.white.withAlpha(50),
            child: Table(
            border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${index+1}. ${productName[index]}", 20, Colors.black, ""),),
            Container(padding: EdgeInsets.all(10),
             
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                    icon:  Icon(Icons.remove,color: Colors.red,), 
                    onPressed: (){
                      setState(() {
                        if(quantity[index]==1){
                            productName.removeAt(index);
                        }
                        else{
                            quantity[index]=quantity[index]-1;
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
                          quantity[index]=quantity[index]+1;
                      });
                    },
                    ),
                    
                     

                  ],
                )),
            Container(padding: EdgeInsets.all(10),
                child: Center(
                  child: textCustom("Php 150.00", 20, Colors.black, ""),
                )),                
            ]
          )],
      
        ),
          );
        },
      ),
      )
  
    
  
      ],
    ),
    )
  
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
              textCustom1("5.0", 20, Colors.white, "style",FontWeight.normal),
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
            height: 420,
            child: FutureBuilder(
              future: a(),

              builder: (BuildContext context, AsyncSnapshot snapshot){

              return  ListView.builder(
         
        shrinkWrap: false,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index){
          
          List a=snapshot.data[index].toString().split(" ,");
        
          return  index%2==1? Container(
            color: Colors.grey.withAlpha(40),
            child: Table(
            border: TableBorder.all(width: 1,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[0]}", 20, Colors.white, ""),),
            Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[1]}", 20, Colors.white, ""),),
            Container(padding: EdgeInsets.all(10),
                child: textCustom("50", 20, Colors.white, ""),),
                 Container(padding: EdgeInsets.all(10),
                child: textCustom("100", 20, Colors.white, ""),),
            ]
          )],
      
        ),
          ): Container(
            color: Colors.transparent.withAlpha(50),
            child: Table(
            border: TableBorder.all(width: 1,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[0]}", 20, Colors.white, ""),),
            Container(padding: EdgeInsets.all(10),
                child: textCustom("${a[1]}s", 20, Colors.white, ""),),
            Container(padding: EdgeInsets.all(10),
                 child: textCustom("100", 20, Colors.white, ""),),
                     Container(padding: EdgeInsets.all(10),
                 child: textCustom("${int.parse(a[1])*100}", 20, Colors.white, ""),)
                
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
                               
                               textCustom("SUBTOTAL : ", 23, Colors.white, "style"),
                               textCustom1("Php 100.00", 23, Colors.white, "style",FontWeight.bold),
                             ],),
                           Text(""),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                               
                               textCustom("VAT : ", 23, Colors.white, "style"),
                               textCustom1("0", 23, Colors.white, "style",FontWeight.bold),
                             ],),
                         
                            Divider(
                              color: Colors.greenAccent,
                            ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: <Widget>[
                               
                               textCustom("TOTAL AMOUNT : ", 23, Colors.white, "style"),
                               textCustom1("Php 100.00", 30, Colors.greenAccent, "style",FontWeight.bold),
                             ],)
                               ],
                             ),
                           ),

                               rButtonView((){
                         
                           AwesomeDialog(context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            tittle: "",
            desc: "Let us know we're doing. Please rate your experience using My Communty",
            body: Column(
              children: <Widget>[
            
                Container(
                    width: double.infinity,
                    color: Colors.black,
                    child: Center(
                      child: textCustom("ENTER PAYMENT AMOUNT", 50, Colors.white, "style"),
                    )
                  ),
                  Row(
                    children: <Widget>[
                      Card(
                        child: Container(
                          color: Colors.grey,
                          height: MediaQuery.of(context).size.height/2,
                          width: MediaQuery.of(context).size.width/2.6,
                          child: Column(
                            children: <Widget>[

                            ],
                          ),
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

            }*/).show();  
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
  
  Future a()async{

  }
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
  
   ;
  }
}





