import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:neumorphism_web/neumorphic_pie/neumorphic_pie.dart';

import 'neumorphic_pie/neumorphic_pie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic Widgets',
      
      theme: ThemeData(
        //canvasColor: kBackgroundColour,
        scaffoldBackgroundColor: const Color.fromRGBO(231, 240, 247, 1),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.dmSans(
            textStyle: const TextStyle(
              fontSize: 43,
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(49, 68, 105, 1),
            ),
          ),
          headlineMedium: GoogleFonts.dmSans(
            textStyle: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(49, 68, 105, 1),
            ),
          ),
        ), //colorScheme: ColorScheme(background: Color.fromRGBO(231, 240, 247, 1)),
      ),
      home: Builder(
        builder: (BuildContext context) {
          final brightnessValue = MediaQuery.of(context).platformBrightness;
          bool isDark = brightnessValue == Brightness.dark;
          return const MyHomePage();//MyHomePage();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //backgroundColor: backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //BarDays(),
          SizedBox(height: 40),
          NeumorphicPie(),
        ],
      ),
    );
  }
}
//
//class BarDays extends StatelessWidget {
//  const BarDays({
//    Key? key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: <Widget>[
//        NeumorphicBar(
//          width: 200,
//          height: 400,
//          value: 0.5,
//          text: 'Mon',
//        ),
//        NeumorphicBar(
//          width: 200,
//          height: 400,
//          value: 0.9,
//          text: 'Tue',
//          color: Color.fromRGBO(0, 200, 156, 1),
//        ),
//        NeumorphicBar(
//          width: 200,
//          height: 400,
//          value: 0.7,
//          text: 'Wed',
//        ),
//        NeumorphicBar(
//          width: 200,
//          height: 400,
//          value: 1,
//          text: 'Thur',
//        ),
//      ],
//    );
//  }
//}
//