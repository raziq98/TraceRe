import 'package:flutter/material.dart';
import 'package:tracere/utilities/theme.dart';

class MiddleRing extends StatelessWidget {
  final num width;

  const MiddleRing({Key? key, required this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width *1,
      width: width *1,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          height: width * 0.3,
          width: width * 0.3,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              // Edge shadow
              BoxShadow(
                offset: Offset(-1.5, -1.5),
                color: ThemeConstant.trcGrey,
                spreadRadius: 2.0,
                // blurRadius: 0,
              ),

              // Circular shadow
              BoxShadow(
                offset: Offset(1.5, 1.5),
                color: Colors.white,
                spreadRadius: 2.0,
                blurRadius: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
