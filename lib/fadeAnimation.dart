import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(Duration(milliseconds: 500), Tween(begin: -130.0, end: 3.0),
      curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(opacity: animation["opacity"],
      child: Transform.translate(
        offset: Offset(0, animation["translateY"]),
        child: child,
      ),
      ),
    );
  }
}

class FadeAnimation1 extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation1(this.delay, this.child);
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateX").add(Duration(milliseconds: 500), Tween(begin: -1400.0, end: 0.0),
      curve: Curves.easeInExpo)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(opacity: animation["opacity"],
      child: Transform.translate(
        offset: Offset.fromDirection(-3.15, animation["translateX"]),
        child: child,
      )
      ),
    );
  }
}