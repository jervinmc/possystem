import 'package:flutter/material.dart';


class rButton1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(onPressed: null),

    );
  }
}

class rButtonAccept extends StatelessWidget {
  Function rBut;
   rButtonAccept(this.rBut);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      child: new MaterialButton(color: Colors.teal,textColor: Colors.white,child: new Text("Login"),
                               /*()=>{
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder:(BuildContext context)=>new MyApp1()))*/
                                onPressed: rBut,
                            )

    );
  }
}
class rButtonDelete extends StatelessWidget {
  Function rBut;
  String text;
   rButtonDelete(this.rBut,this.text);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      child: new MaterialButton(color:Color(0xffe74c3c),textColor: Colors.white,child: new Text(text),
                               /*()=>{
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder:(BuildContext context)=>new MyApp1()))*/
                                onPressed: rBut,
                            )

    );
  }
}
class rButtonView extends StatelessWidget {
  Function rBut;
  String text;
  double width;
   rButtonView(this.rBut,this.text,this.width);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      child: new MaterialButton(color:Color(0xffc0392b),textColor: Colors.white,child: new Text(text),
                               /*()=>{
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder:(BuildContext context)=>new MyApp1()))*/minWidth: width,
                                onPressed: rBut,
                                
                            )

    );
  }
}

class Question extends StatelessWidget {
  int entry;
  String questionText;
  Question(this.questionText);


  @override
  Widget build(BuildContext context) {
    if(entry==null) {
      return Container(
          width: double.infinity,   
          child: Text(questionText,
            style: TextStyle(fontFamily:'Comic Sans MS',fontSize: 28, color: Colors.white),
            textAlign: TextAlign.center
            ,)
      );
    }
    else{
      return Container(
          width: double.infinity,
          child: Text(questionText,
            style: TextStyle(fontSize: 28,color: Colors.blue),
            textAlign: TextAlign.center
            ,)
      );

    }

  }
}
class textWhite extends StatelessWidget {
  String text;
  double size;
  
  textWhite(this.text,this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,style: TextStyle(fontSize: size,color: Colors.white),),
    );
  }
}
class textCustom extends StatelessWidget {
  String text;
  double size;
  Color color;
  String style;
  

  textCustom(this.text,this.size,this.color,this.style);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,style: TextStyle(fontSize: size,color: color,fontFamily:style),),
    );
  }
}
class textCustom1 extends StatelessWidget {
  String text;
  double size;
  Color color;
  String style;
  FontWeight weight;
  
  textCustom1(this.text,this.size,this.color,this.style,this.weight);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,style: TextStyle(fontSize: size,color: color,fontFamily:style,fontWeight: weight),),
    );
  }
}
class imageCustom extends StatelessWidget {
  String urlImage;
  double widths;
  imageCustom(this.urlImage,this.widths);

  @override
  Widget build(BuildContext context) {
    
    
    AssetImage assetImage=AssetImage(urlImage);
    Image image=Image(image:assetImage);
    
    return Container(
     
      child: image,margin: EdgeInsets.all(25),
    decoration: BoxDecoration(
   // border: Border.all(color: Colors.black,width: widths), 
    ),
      
    
    );
  }
}

class outlineButton extends StatelessWidget {
  double length;
  double width;
  Color colors;
  String label;
  Function widget;
  Color colorLabel;
  double sizeLabel;
  outlineButton(this.length,this.width,this.colors,this.label,this.widget,this.colorLabel,this.sizeLabel);
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
          width: length,
  child:  new OutlineButton(
      borderSide: BorderSide(
            color: colors, //Color of the border
            style: BorderStyle.solid, //Style of the border
            width: width, //width of the border
          ),
    color:Color(0xff30336b),
  child: new textCustom("$label",sizeLabel,colorLabel, "s"),
  onPressed: (){
    widget();

  },
  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
)
);
  }
}