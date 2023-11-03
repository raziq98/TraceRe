import 'package:flutter/material.dart' hide Intent;
import 'package:tracere/screen/homepage.dart';
import 'package:tracere/screen/homepage_test.dart';
import 'package:tracere/utilities/theme.dart';

//import 'package:receive_intent/receive_intent.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //scaffoldBackgroundColor: const Color.fromARGB(0, 255, 255, 255),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple[100],
        ),
      ),
      home: const HomePage(),
    );
  }
}

class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  //Intent? _initialIntent;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // final receivedIntent = await ReceiveIntent.getInitialIntent();
    // ReceiveIntent.receivedIntentStream();

    if (!mounted) return;

    // setState(() {
    //   _initialIntent = receivedIntent;
    // });
  }

  // Widget _buildFromIntent(String label, Intent? intent) {
  //   return Center(
  //     child: Column(
  //       children: [
  //         Text(label),
  //         Text(
  //             "fromPackage: ${intent?.fromPackageName}\nfromSignatures: ${intent?.fromSignatures}"),
  //         Text(
  //             'action: ${intent?.action}\ndata: ${intent?.data}\ncategories: ${intent?.categories}'),
  //         Text("extras: ${intent?.extra}")
  //       ],
  //     ),
  //   );
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TraceRe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to TraceRe',
                style: ThemeConstant.blackTextBold26,
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 55,
                width: 250,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(5.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve:
                                Curves.easeInOut, // Add your desired curve here
                          );
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(curvedAnimation),
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const WorkTimer(), //AuthPage(), //HomePage
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Register to your account',
                      style: ThemeConstant.blackTextBold18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
