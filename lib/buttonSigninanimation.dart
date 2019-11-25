import 'Homepage.dart';
import 'package:flutter/material.dart';

class ButtonSigninAnimation extends StatefulWidget {
  
  final String label;
  final Color background;
  final Color borderColor;
  final Color fontColor;
  final Function onTap;
  final Widget child;

  const ButtonSigninAnimation({Key key,
   this.label, 
   this.background, 
   this.borderColor,
    this.fontColor, 
    this.onTap, 
    this.child}) 
    : super(key: key);

  @override
  _ButtonSigninAnimationState createState() => _ButtonSigninAnimationState();
}
class _ButtonSigninAnimationState extends State<ButtonSigninAnimation> with TickerProviderStateMixin{
  
  AnimationController _positionController;
  Animation<double> _positionAnimation;

  AnimationController _scaleController;
  Animation<double> _scaleAnimation;

  bool _isSignin = false;
  bool _isIconHide = false;

  @override
  void initState(){
    super.initState();

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000)
    );

    _positionAnimation = Tween<double>(begin: 2.0, end: 700.0)
    .animate(_positionController)..addStatusListener((status){
      if (status == AnimationStatus.completed){
        setState(() {
          _isIconHide = true;
        });
        _scaleController.forward();
      }
    });

      _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000)
      );
      _scaleAnimation = Tween<double>(begin: 2.0, end: 60)
      .animate(_scaleController)..addStatusListener((status){
        if (status == AnimationStatus.completed){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          _isSignin = true;
        });
        _positionController.forward();
      },
      child: Container(
        height: 63,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: BorderRadius.circular(350),
        ),
        child: !_isSignin ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.label, style: TextStyle(
              color: widget.fontColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
            SizedBox(width: 5),
            Icon(Icons.arrow_forward_ios, color: Colors.black87,size: 25),
          ],
        ) : Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _positionController,
              builder: (context, child) =>Positioned(
                  left: _positionAnimation.value,
                  right: 100,
                  child: AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, build) => Transform.scale(
                      scale: _scaleAnimation.value,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: ! _isIconHide ? 
                      Icon(Icons.arrow_forward_ios,
                       color: Colors.white, 
                       size: 25)
                       : Homepage(),
                    )),
                  ),
                ),
            ),
          ],
        )
      ),
    );
  }
}