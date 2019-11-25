import 'homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import './utils.dart';


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

class _HomepageState extends State<Homepage> {
  TextEditingController searchCtrlr=new TextEditingController();
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
              accountEmail: Text("jervinmac@yahoo.com"),
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
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(title: Text("TREX"),
      backgroundColor: Colors.black87,
      ),
      ),
   
   
      
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
                  elevation: 5,
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.2,
                    width: MediaQuery.of(context).size.width/2.1,
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
        icon: Icon(Icons.search),
        
        hintText: 'ENTER BARCODE',
        hintStyle: TextStyle(fontSize: 16),
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
                   height: MediaQuery.of(context).size.height/1.2,
                    width: MediaQuery.of(context).size.width/2.1,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: ListView(
                         // shrinkWrap: true,

                       // physics: NeverScrollableScrollPhysics(),
                        //shrinkWrap: true,
                        children: <Widget>[
                          MemberInfo(),
                        ],
                      ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
           textCustom("Name", 15, Colors.black, ""),
           textCustom("QTY", 15, Colors.black, ""),
           textCustom("Total", 15, Colors.black, ""),
          ],
        ),
    
  
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
          String item, String charge, String dateString, String type,
          {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
            EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontSize: 16.0)),
                Text(charge, style: TextStyle(fontSize: 16.0))
              ],
            ),
            
         
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        textCustom1("Member Information", 20, Colors.black, "style",FontWeight.bold),
        Text(""),
        Text(""),
        Row(
          children: <Widget>[
             textCustom1("Member", 15, Colors.black, "style",FontWeight.normal),
          ],
        ),
         Text(""),
         Text(""),
         Row(
          children: <Widget>[
             textCustom1("Points", 15, Colors.black, "style",FontWeight.normal),
          ],
        ),
        Divider(),
       Container(
         padding: EdgeInsets.all(5),
         color: Colors.black87,
         child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            textCustom("Items", 15, Colors.white, "style"),
            textCustom("Price", 15, Colors.white, "style"),

        ],),
       ),
      
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder:(BuildContext,int index){
              return index%2==0?accountItems("Kojic2x", "50", "20-20-20", "debit"):
              accountItems("Kojic", "50", "20-20-20", "debit",oddColour: Colors.green.withOpacity(0.1));
            },
        
      ),
      Text(""),
       Text(""),
        Text(""),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
           textCustom1("Subtotal", 15, Colors.black, "style",FontWeight.normal),
             textCustom1("Php 100.00", 15, Colors.black, "style",FontWeight.normal),
       ],
      ),
      Text(""),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
           textCustom1("VAT", 15, Colors.black, "style",FontWeight.normal),
             textCustom1("0", 15, Colors.black, "style",FontWeight.normal),
       ],
      ),
      Divider(),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
           textCustom1("Total Amount", 15, Colors.black, "style",FontWeight.normal),
             textCustom1("Php 100.00", 15, Colors.black, "style",FontWeight.bold),
       ],
      ),
      Text(""),
       new SizedBox(
          width: 280,
  child:  new OutlineButton(
      borderSide: BorderSide(
            color: Color(0xff30336b), //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: 2, //width of the border
          ),
    color:Color(0xff30336b),
  child: new textCustom("Check out", 18,Color(0xff30336b), "s"),
  onPressed: (){
 AwesomeDialog(context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            tittle: "Rate Our Service!",
            desc: "Let us know we're doing. Please rate your experience using My Communty",
            btnCancelText: "Not now",
            btnCancelOnPress: () {},
            btnOkText: "Rate",
            
          
            btnOkOnPress: () {
               Navigator.pop(context, false);
      /* Navigator.push(context, SlideRightRoute1(
                            widget: viewreviews("...",userid,"")
                            ));
                              Navigator.push(context, SlideRightRoute1(
                            widget: viewreviews("...",userid,"")
                            ));*/

            }).show();
       
  

  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
)
)

      ],
    
      
    );
  }
}





