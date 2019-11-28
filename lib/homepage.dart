import 'dart:math';

import 'package:possystem/fadeAnimation.dart';
import 'package:vector_math/vector_math.dart' as prefix0;

import 'homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import './utils.dart';
import 'package:sunmi_aidl_print/sunmi_aidl_print.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:sunmi/sunmi.dart';
import 'package:flutter/services.dart';
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
            child: FloatingActionButton(
                heroTag: "heroTag",
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
  Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Not in stock'),
        content: const Text('This item is no longer available'),
        actions: <Widget>[
          
          
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
                title: new Text('Profile'),
                trailing: new Icon(Icons.account_circle),
                onTap: () {
                  Navigator.of(context).pop();
                 // Navigator.of(context).push(new MaterialPageRoute( builder:(BuildContext context)=>new profile(image,name,email)));
                }),
               new Divider(),
                new ListTile(
                title: new Text('Transaction'),
                trailing: new Icon(Icons.business),
                onTap: () {
                  Navigator.of(context).pop();
                 // Navigator.of(context).push(new MaterialPageRoute( builder:(BuildContext context)=>new profile(image,name,email)));
                }),
               new Divider(),
                new ListTile(
                title: new Text('Products'),
                trailing: new Icon(Icons.shopping_basket),
                onTap: () {
                  Navigator.of(context).pop();
                 // Navigator.of(context).push(new MaterialPageRoute( builder:(BuildContext context)=>new profile(image,name,email)));
                }),
               new Divider(),
               new ListTile(
                  title: new Text('Logout'),
                  trailing: new Icon(Icons.arrow_drop_down_circle),             
                   onTap: ()async{ 
                     Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
        preferredSize: Size.fromHeight(75.0),
        child: FadeAnimation(1.3, AppBar(title: Row(
          children: <Widget>[
            Text("AUTH",style: TextStyle(fontSize: 50,color: Colors.orange),),
            Text("POS",style: TextStyle(fontSize: 50,),),
          
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
          child: Image(image: AssetImage("assets/barcode.jpg"),fit: BoxFit.cover,),
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
      child:  tableResult(),
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
                          MemberInfo(),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        child:  rButtonView((){
                          _ackAlert(context);
                           AwesomeDialog(context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            tittle: "Rate Our Service!",
            desc: "Let us know we're doing. Please rate your experience using My Communty",
            btnCancelText: "Not now",
            btnCancelOnPress: () {},
            btnOkText: "Rate",
            
          
            btnOkOnPress: () {
                SunmiAidlPrint.setAlignment(align:TEXTALIGN.CENTER);
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
               SunmiAidlPrint.unbindPrinter(); 
              // Navigator.pop(context, false);
      /* Navigator.push(context, SlideRightRoute1(
                            widget: viewreviews("...",userid,"")
                            ));
                              Navigator.push(context, SlideRightRoute1(
                            widget: viewreviews("...",userid,"")
                            ));*/

            }).show();  
                        }, "Check out", MediaQuery.of(context).size.width/3.14),
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

//////////////////////////
///Table//////
class tableResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
      Container(
        color: Colors.orange.withAlpha(50),
        child:   Table(
          border: TableBorder.lerp(TableBorder.all(width: 0), TableBorder.all(width: 0), 0.5),
          
          children: [TableRow(
            children:[
         Container(padding: EdgeInsets.all(10),
                child: textCustom("NAME", 25, Colors.black, ""),),
          Container(padding: EdgeInsets.all(10),
                child: textCustom("QTY", 25, Colors.black, ""),),
           Container(padding: EdgeInsets.all(10),
                child: textCustom("PRICE", 25, Colors.black, ""),),
                
            ]
          )],
      
        ),
      ),

      Container(
        height: MediaQuery.of(context).size.height/1.45,
        child:  ListView.builder(
        shrinkWrap: true,
        itemCount: 18,
        itemBuilder: (BuildContext context, int index){
          return  index%2==1? Container(
            color: Colors.grey.withAlpha(40),
            child: Table(
            border: TableBorder.all(width: 0.5,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("${index+1}. Kojic", 20, Colors.black, ""),),
            Container(padding: EdgeInsets.all(10),
                child: textCustom("2", 20, Colors.black, ""),),
            Container(padding: EdgeInsets.all(10),
                child: textCustom("Php 50.00", 20, Colors.black, ""),),
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
                child: textCustom("${index+1}. Kojica", 20, Colors.black, ""),),
            Container(padding: EdgeInsets.all(10),
                child: textCustom("2", 20, Colors.black, ""),),
            Container(padding: EdgeInsets.all(10),
                child: textCustom("Php 150.00", 20, Colors.black, ""),),
                
            ]
          )],
      
        ),
          );
        },
      ),
      )
  
    
  
      ],
    );
  }
}
//////////////////////MemberInformation///////////
///
class MemberInfo extends StatefulWidget {
  @override
  _MemberInfoState createState() => _MemberInfoState();
}

class _MemberInfoState extends State<MemberInfo> {
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
    return Stack(
      children: <Widget>[
         Column(
      children: <Widget>[
        
        textCustom1("Member Information", 40, Colors.white, "style",FontWeight.bold),
        Text(""),
        Text(""),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             textCustom1("Member :", 20, Colors.white, "style",FontWeight.normal),
             textCustom1("Prokopyo Tunying", 20, Colors.white, "style",FontWeight.normal),
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
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index){
          return  index%2==1? Container(
            color: Colors.grey.withAlpha(40),
            child: Table(
            border: TableBorder.all(width: 1,color: Colors.black87),
          children: [TableRow(
            children:[
                Container(padding: EdgeInsets.all(10),
                child: textCustom("Kojic", 20, Colors.white, ""),),
            Container(padding: EdgeInsets.all(10),
                child: textCustom("2", 20, Colors.white, ""),),
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
                child: textCustom("Kojica", 20, Colors.white, ""),),
            Container(padding: EdgeInsets.all(10),
                child: textCustom("2", 20, Colors.white, ""),),
            Container(padding: EdgeInsets.all(10),
                 child: textCustom("100", 20, Colors.white, ""),),
                     Container(padding: EdgeInsets.all(10),
                 child: textCustom("100", 20, Colors.white, ""),)
                
            ]
          )],
      
        ),
          );
        },
      ),
      Text(""),
       Text(""),
        Text(""),
      Row(
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
   ;
  }
}





