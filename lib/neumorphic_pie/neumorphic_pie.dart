
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tracere/neumorphic_pie/progress_rings.dart';
import 'middle_ring.dart';
//import 'package:neumorphism_web/neumorphic_pie/middle_ring.dart';
//import 'package:neumorphism_web/neumorphic_pie/progress_rings.dart';

class NeumorphicPie extends StatefulWidget {
  const NeumorphicPie({super.key});

  @override
  State<NeumorphicPie> createState() => _NeumorphicPieState();
}

class _NeumorphicPieState extends State<NeumorphicPie>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //late AnimationController _controller;
  //late Animation<double> _animation;
//
  //@override
  //void initState() {
  //  super.initState();
  //  // Create an animation controller
  //  _controller = AnimationController(
  //    vsync: this,
  //    duration: const Duration(seconds: 2), // Adjust the duration as needed
  //  );
  //  _animation = Tween<double>(
  //    begin: 0.0, // Adjust the initial value as needed
  //    end: 1.0, // Adjust the end value as needed
  //  ).animate(_controller);
//
  //  // Start the animation
  //  _controller.forward(from: 0); // Start from the beginning
//
  //  // Add a listener to the animation to trigger a rebuild when it changes
  //  _controller.addListener(() {
  //    setState(() {});
  //  });
//
  //  // Set up a listener to stop the animation when it reaches the completedPercentage
  //  _controller.addStatusListener((status) {
  //    if (status == AnimationStatus.forward && _controller.value == 1.0) {
  //      _controller.stop();
  //    }
  //  });
  //}
//
  //@override
  //void dispose() {
  //  _controller.dispose(); // Dispose the controller when done
  //  super.dispose();
  //}
//
  @override
  Widget build(BuildContext context) {
    // Outer white circle
    return Container(
      height: 290.0,
      width: 290.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white24,
      ),
      child: Center(
        // Container of the pie chart
        child: Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 20,
                blurRadius: 45,
                offset: const Offset(0, 7), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              const Center(child: MiddleRing(width: 300.0)),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                  angle: pi / 2.6 + (_controller.value * (pi * 2)),
                  child: CustomPaint(
                    painter: ProgressRings(
                      completedPercentage: 0.65,
                      circleWidth: 50.0,
                      gradient: greenGradient,
                      gradientStartAngle: 0.0,
                      gradientEndAngle: pi / 3,
                      progressStartAngle: 1.85,
                      lengthToRemove: 3,
                    ),
                    child: const Center(),
                  ),
                );
                },
              ),
              //AnimatedBuilder(
              //  animation: _animation,
              //  builder: (context, child) {
              //    return Transform.rotate(
              //    angle: pi / 2.6 + (_animation.value * (pi * 2)),
              //    child: CustomPaint(
              //    painter: ProgressRings(
              //      completedPercentage: 0.20,
              //      circleWidth: 50.0,
              //      gradient: turqoiseGradient,
              //      gradientStartAngle: 1.0,
              //        gradientEndAngle: pi ,
              //        progressStartAngle: 1.85,
              //        lengthToRemove: 3,
              //    ),
              //    child: const Center(),
              //  ),
              //  );
              //  },
              //),
              // Center(
              //   child: CustomPaint(
              //     size: const Size(200, 200),
              //     painter: ProgressRings1(
              //       sections: [
              //         ProgressRingItem(
              //             color: Colors.blue, completedPercentage: 0.25),
              //         ProgressRingItem(
              //             color: Colors.red, completedPercentage: 0.25),
              //         ProgressRingItem(
              //             color: Colors.green, completedPercentage: 0.25),
              //         ProgressRingItem(
              //             color: Colors.yellow, completedPercentage: 0.25)
              //       ],
              //       animation: _controller,
              //       circleWidth: 20.0,
              //       gradientStartAngle: 0.0,
              //       gradientEndAngle: pi / 2,
              //       progressStartAngle: 0,
              //       lengthToRemove: 0,
              //     ),
              //   ),
              // )
              //CustomPaint(
              //  size: const Size(200, 200),
              //  painter: ProgressRings1(
              //    animation: _controller,
              //    completedPercentage: 0.2,
              //    circleWidth: 45.0,
              //    gradient: greenGradient,
              //    gradientStartAngle: 0.0,
              //    gradientEndAngle: 30,
              //    progressStartAngle: 0,
              //    lengthToRemove: 0,
              //  ),
              //),
              //Transform.rotate(
              //  angle: pi / 2.6, //+ (_animation.value * (pi * 2)),
              //  child: CustomPaint(
              //    painter: ProgressRings(
              //      completedPercentage: 0.25,
              //      circleWidth: 50.0,
              //      gradient: greenGradient,
              //      gradientStartAngle: 0.0,
              //      gradientEndAngle: pi / 3,
              //      progressStartAngle: 1.85,
              //      //lengthToRemove: 3,
              //    ),
              //    child: const Center(),
              //  ),
              //),
              //Transform.rotate(
              //  angle: pi / 1.8,
              //  child: CustomPaint(
              //    painter: ProgressRings(
              //      completedPercentage: 0.20,
              //      circleWidth: 50.0,
              //      gradient: turqoiseGradient,
              //    ),
              //    child: const Center(),
              //  ),
              //),
              //Transform.rotate(
              //  angle: pi / 2.6,
              //  child: CustomPaint(
              //    painter: ProgressRings(
              //      completedPercentage: 0.35,
              //      circleWidth: 50.0,
              //      gradient: redGradient,
              //      gradientStartAngle: 0.0,
              //      gradientEndAngle: pi / 2,
              //      progressStartAngle: 1.85,
              //    ),
              //    child: const Center(),
              //  ),
              //),
              //Transform.rotate(
              //  angle: pi * 1.1,
              //  child: CustomPaint(
              //    painter: ProgressRings(
              //      completedPercentage: 0.24,
              //      circleWidth: 50.0,
              //      gradient: orangeGradient,
              //      gradientStartAngle: 0.0,
              //      gradientEndAngle: pi / 2,
              //      progressStartAngle: 1.85,
              //    ),
              //    child: const Center(),
              //  ),
              //),
            ],
          ),
        ),
      ),
    );
  }
}

const innerColor = Color.fromRGBO(233, 242, 249, 1);
const shadowColor = Color.fromRGBO(220, 227, 234, 1);

const greenGradient = [
  Color.fromRGBO(223, 250, 92, 1),
  Color.fromRGBO(129, 250, 112, 1)
];
const turqoiseGradient = [
  Color.fromRGBO(91, 253, 199, 1),
  Color.fromRGBO(129, 182, 205, 1)
];

const redGradient = [
  Color.fromRGBO(255, 93, 91, 1),
  Color.fromRGBO(254, 154, 92, 1),
];
const orangeGradient = [
  Color.fromRGBO(251, 173, 86, 1),
  Color.fromRGBO(253, 255, 93, 1),
];
