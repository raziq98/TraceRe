import 'dart:math';
import 'package:flutter/material.dart';

class ProgressRingItem {
  final Color color;
  final double completedPercentage;

  ProgressRingItem({required this.color, required this.completedPercentage});
}

class ProgressRings1 extends CustomPainter {
  final Animation<double> animation;
  final double circleWidth;
  final List<Color>? gradient;
  final double gradientStartAngle;
  final double gradientEndAngle;
  final double progressStartAngle;
  final double lengthToRemove;
  final List<ProgressRingItem> sections;

  ProgressRings1({
    required this.animation,
    required this.circleWidth,
    this.gradient,
    this.gradientStartAngle = 3 * pi / 2,
    this.gradientEndAngle = 4 * pi / 2,
    this.progressStartAngle = 0,
    this.lengthToRemove = 0,
    required this.sections,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    double progressStartAngles=progressStartAngle;
    double completedPercentage = animation.value;

    double progressEndAngle = progressStartAngles;

    for (var section in sections) {
      double arcAngle = 2 * pi * section.completedPercentage;
      progressEndAngle += arcAngle;
      Rect boundingSquare = Rect.fromCircle(center: center, radius: radius);

      Paint paint = getPaint(
        section.color,
        startAngle: progressStartAngles,
        endAngle: progressEndAngle,
      );

      canvas.drawArc(
        boundingSquare,
        progressStartAngles,
        arcAngle,
        false,
        paint,
      );

      progressStartAngles += arcAngle;
    }
  }

  Paint getPaint(Color color, {double startAngle = 0.0, double endAngle = pi * 2}) {
    final Gradient gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: endAngle,
      colors: [color, color], // Use a single color for each section
    );

    return Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..shader = gradient.createShader(Rect.zero);
  }

  @override
  bool shouldRepaint(CustomPainter painter) => true;
}



// import 'dart:math';
// import 'package:flutter/material.dart';


// class ProgressRings1 extends CustomPainter {
//   final Animation<double> animation;
//   //final num? completedPercentage;
//   final double circleWidth;
//   final List<Color>? gradient;
//   final double gradientStartAngle;
//   final double gradientEndAngle;
//   final double progressStartAngle;
//   final double lengthToRemove;
//   //final List<ProgressRingItems> sections;

//   ProgressRings1( {
//     //required this.sections,
//     //this.completedPercentage,
//     required this.animation,
//     required this.circleWidth,
//     this.gradient,
//     this.gradientStartAngle = 3 * pi / 2,
//     this.gradientEndAngle = 4 * pi / 2,
//     this.progressStartAngle = 0,
//     this.lengthToRemove = 0,
//   }) : super(repaint: animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     Offset center = Offset(size.width / 2, size.height / 2);
//     double radius = min(size.width / 2, size.height / 2);

//     double completedPercentage = animation.value;//

//     double arcAngle = 2 * pi * completedPercentage;//
//     double progressEndAngle = progressStartAngle + arcAngle - lengthToRemove;

//     Rect boundingSquare = Rect.fromCircle(center: center, radius: radius);

//     Paint getPaint(List<Color> colors,
//         {double startAngle = 0.0, double endAngle = pi * 2}) {
//       final Gradient gradient = SweepGradient(
//         startAngle: startAngle,
//         endAngle: endAngle,
//         colors: colors,
//       );
//       //final Color color = sections[0].colors!;

//       return Paint()
//         ..strokeCap = StrokeCap.round
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = circleWidth
//         ..shader = gradient.createShader(boundingSquare);
//         //..color=color;
//     }

//     canvas.drawArc(
//       boundingSquare,
//       progressStartAngle,
//       progressEndAngle - progressStartAngle,
//       false,
//       getPaint(
//         gradient!,
//         startAngle: gradientStartAngle,
//         endAngle: gradientEndAngle,
//       ),
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter painter) => true;
// }
