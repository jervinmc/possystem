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
class ScreenUtil {
  static ScreenUtil instance = new ScreenUtil();

  //设计稿的设备尺寸修改
  double width;
  double height;
  bool allowFontScaling;

  static MediaQueryData _mediaQueryData;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;

  static double _bottomBarHeight;

  static double _textScaleFactor;

  ScreenUtil({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  });

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => _textScaleFactor;

  ///设备的像素密度
  static double get pixelRatio => _pixelRatio;

  ///当前设备宽度 dp
  static double get screenWidthDp => _screenWidth;

  ///当前设备高度 dp
  static double get screenHeightDp => _screenHeight;

  ///当前设备宽度 px
  static double get screenWidth => _screenWidth * _pixelRatio;

  ///当前设备高度 px
  static double get screenHeight => _screenHeight * _pixelRatio;

  ///状态栏高度 dp 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight;

  ///底部安全区距离 dp
  static double get bottomBarHeight => _bottomBarHeight;

  ///实际的dp与设计稿px的比例
  get scaleWidth => _screenWidth / instance.width;

  get scaleHeight => _screenHeight / instance.height;

  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  setWidth(double width) => width * scaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  setHeight(double height) => height * scaleHeight;

  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  setSp(double fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}

class rButtonView extends StatelessWidget {
  Function rBut;
  String text;
  double width;
   rButtonView(this.rBut,this.text,this.width);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      child: new MaterialButton(color:Colors.orange,textColor: Colors.black87,child: new Text(text,style: TextStyle(fontSize: 40),),
                               /*()=>{
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder:(BuildContext context)=>new MyApp1()))*/minWidth: width,
                                    height: 60,
                                onPressed: rBut,
                                shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(3.0),
        side: BorderSide(color: Colors.orange.withOpacity(0.9))
),
                                
                            )

    );
  }
}
class showdialogFunction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
class rButtonView2 extends StatelessWidget {
  Function rBut;
  String text;
  double width;
   rButtonView2(this.rBut,this.text,this.width);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      child: new MaterialButton(color:Colors.black87,textColor: Colors.white,child: new Text(text,style: TextStyle(fontSize: 30),),
                               /*()=>{
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder:(BuildContext context)=>new MyApp1()))*/minWidth: width,
                                    height: 45,
                                onPressed: rBut,
                                shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(5.0),
        side: BorderSide(color: Colors.black,width: 5)
),
                                
                            )

    );
  }
}
class rButtonView6 extends StatelessWidget {
  Function rBut;
  String text;
  double width;
   rButtonView6(this.rBut,this.text,this.width);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      child: new MaterialButton(color:Colors.red,textColor: Colors.white,child: new Text(text,style: TextStyle(fontSize: 30),),
                               /*()=>{
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder:(BuildContext context)=>new MyApp1()))*/minWidth: width,
                                    height: 65,
                                onPressed: rBut,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  
        borderRadius: new BorderRadius.circular(20.0),
        //side: BorderSide(color: Colors.white,width: 2)
),
                                
                            )

    );
  }
}
class rButtonView3 extends StatelessWidget {
  Function rBut;
  String text;
  double width;
   rButtonView3(this.rBut,this.text,this.width);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      child: new MaterialButton(color:Colors.white,textColor: Colors.green,child: new Text(text,style: TextStyle(fontSize: 30),),
                               /*()=>{
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder:(BuildContext context)=>new MyApp1()))*/minWidth: width,
                                    height: 50,
                                onPressed: rBut,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  
        borderRadius: new BorderRadius.circular(25.0),
        side: BorderSide(color: Colors.green,width: 2)
),
                                
                            )

    );
  }
}
class rButtonView4 extends StatelessWidget {
  Function rBut;
  String text;
  double width;
   rButtonView4(this.rBut,this.text,this.width);
  @override
  Widget build(BuildContext context) {
   
    return Container(
      child: new MaterialButton(color:Colors.white,textColor: Colors.redAccent,child: new Text(text,style: TextStyle(fontSize: 30),),
                               /*()=>{
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder:(BuildContext context)=>new MyApp1()))*/minWidth: width,
                                    height: 50,
                                onPressed: rBut,
                                   elevation: 0,
                                shape: RoundedRectangleBorder(
                                  
        borderRadius: new BorderRadius.circular(25.0),
        side: BorderSide(color: Colors.redAccent.withOpacity(0.9),width: 2)
),
                                
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