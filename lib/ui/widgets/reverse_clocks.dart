import 'dart:math' as math;

import 'package:flutter/material.dart';

// TODO: Добавить extension для math?

double _getRads(double angle) => angle * math.pi / 180;

double _kTwoPi = 2 * math.pi;

class ReverseClocks extends StatefulWidget {
  const ReverseClocks({
    Key? key,
    this.angle = 0,
    this.seconds = 0,
  }) : super(key: key);

  final double angle;
  final int seconds;

  @override
  State<ReverseClocks> createState() => _ReverseClocksState();
}

class _ReverseClocksState extends State<ReverseClocks>
    with SingleTickerProviderStateMixin {
  double _getTheta(int seconds) {
    final fraction = (seconds / 60) % 60;
    print(fraction);
    return (math.pi / 2 - fraction * _kTwoPi) % _kTwoPi;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClocksPainter(
        angle: widget.angle,
        theta: _getTheta(widget.seconds),
        secondTheta: _getTheta(15),
        thickness: 80,
      ),
    );
  }
}

class _ClocksPainter extends CustomPainter {
  // TODO: Добавить свойста

  final double angle;
  final double thickness;
  final double theta;
  final double secondTheta;

  _ClocksPainter({
    required this.angle,
    required this.theta,
    required this.secondTheta,
    this.thickness = 20,
  });

  // Offset getOffsetForTheta(double theta) {
  //   return center + Offset(labelRadius * math.cos(theta), -labelRadius * math.sin(theta));
  // }

  //    return (math.pi / 2.0 - fraction * _kTwoPi) % _kTwoPi;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.shortestSide / 2.0;
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    canvas.drawCircle(center, radius, Paint()..color = Colors.blueGrey);

    Offset getOffsetForTheta(double theta) {
      return center +
          Offset(radius * math.cos(theta), -radius * math.sin(theta));
    }

    Offset getInnerOffsetForTheta(double theta) {
      return center +
          Offset((radius - thickness) * math.cos(theta),
              -(radius - thickness) * math.sin(theta));
    }

    final thetaOffset = getOffsetForTheta(theta);
    final innerThetaOffset = getInnerOffsetForTheta(theta);

    final Rect baseRect = Rect.fromCircle(center: center, radius: radius);
    final Rect innerRect =
        Rect.fromCircle(center: center, radius: radius - thickness);
    final Rect lineRect = Rect.fromCircle(
        center: Offset(thetaOffset.dx, thetaOffset.dy), radius: thickness / 2);

    final rad = _getRads(angle);
    print(Offset(angle, rad));
    final path = Path()
      // ..moveTo(0, 0)
      ..moveTo(center.dx, 0)
      ..arcTo(baseRect, _getRads(270), rad, true)
      // ..lineTo(innerThetaOffset.dx, innerThetaOffset.dy)
      // ..arcToPoint(
      //   innerThetaOffset,
      //   radius: Radius.circular(thickness / 2),
      // )
      ..conicTo(
        thetaOffset.dx - thickness / 2,
        thetaOffset.dy - thickness / 2,
        innerThetaOffset.dx,
        innerThetaOffset.dy,
        1,
      )
      ..arcTo(innerRect, _getRads(angle - 90), -_getRads(angle), false);
    // ..lineTo(center.dx, center.dy);
    canvas.drawPath(path, Paint()..color = Colors.redAccent);

    print('Distance = ${Offset(thetaOffset.dx, thetaOffset.dy).distance}');

    // canvas.drawCircle(Offset(thetaOffset.dx, thetaOffset.dy), thickness / 2,
    //     Paint()..color = Colors.yellow);
    //
    // canvas.drawCircle(Offset(center.dx, center.dy - radius), thickness / 2,
    //     Paint()..color = Colors.yellow);

    Offset getOffsetForSecondTheta(double theta) {
      return center +
          Offset(radius * math.cos(theta), -radius * math.sin(theta));
    }

    final Offset secondThetaOffset = getOffsetForSecondTheta(secondTheta);
    print(secondThetaOffset);

    final path2 = Path()
          ..moveTo(center.dx, center.dy - radius)
          // ..arcToPoint(
          //   thetaOffset,
          //   radius: Radius.elliptical(5, radius),
          //   clockwise: true,
          //   // rotation: _getRads(70),
          // )
          ..conicTo(
            secondThetaOffset.dx,
            secondThetaOffset.dy,
            thetaOffset.dx,
            thetaOffset.dy,
            0.1,
          )
        // ..quadraticBezierTo(
        //   secondThetaOffset.dx,
        //   secondThetaOffset.dy,
        //   thetaOffset.dx,
        //   thetaOffset.dy,
        // )
        // ..cubicTo(
        //   secondThetaOffset.dx + thickness * 0.7,
        //   secondThetaOffset.dy - thickness * 2.2,
        //   secondThetaOffset.dx + thickness / 1.3,
        //   secondThetaOffset.dy + thickness * 2.2,
        //   thetaOffset.dx,
        //   thetaOffset.dy,
        // )
        // ..arcToPoint(arcEnd)
        // ..lineTo(center.dx - radius, center.dy - radius)
        /*..arcToPoint(
        innerThetaOffset,
        radius: Radius.circular(thickness / 2 - 20),
      )
      ..arcTo(innerRect, _getRads(angle - 90), -_getRads(angle), false)*/
        ;

    canvas.drawPath(
        path2, Paint()..color = Colors.greenAccent.withOpacity(0.5));
  }

  @override
  bool shouldRepaint(_ClocksPainter oldDelegate) {
    return angle != oldDelegate.angle;
  }

  @override
  bool shouldRebuildSemantics(_ClocksPainter oldDelegate) {
//TODO Implement shouldRebuildSemantics
    return true;
  }
}
