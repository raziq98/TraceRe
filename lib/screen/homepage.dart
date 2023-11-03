import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:tracere/utilities/theme.dart';
import '../components/multiple_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<DateTime> _clockStreamController =
      StreamController<DateTime>();
  bool _isClockIn = false;
  bool _isBreak = false;
  DateTime? stopsAt;
  String timerStopAt = '';
  late Timer _timer;
  DateTime? _startWork;
  DateTime? _workUntil;
  //TODO : get user's total work hour
  //TODo : save the totalWorkHour's differences in hive or NoSQL , resumeTimer & _clockOut access it , and only destroy from clockOut but initialize in initstate
  //TODO : get breakTime from db
  //TODO : get isClockIn , isBreakTime , clockIn time , start_break ,

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateClock);
  }

  void _updateClock(Timer timer) {
    _clockStreamController.add(DateTime.now());
  }

  @override
  void dispose() {
    _timer.cancel();
    _clockStreamController.close();
    super.dispose();
  }

  void _pauseTimer(DateTime current) {
    String temp =
        '${current.hour.toString().padLeft(2, '0')}:${current.minute.toString().padLeft(2, '0')}:${current.second.toString().padLeft(2, '0')}';
    setState(() {
      _isBreak = true;
      timerStopAt = temp;
      stopsAt = current;
    });
  }

  void _resumeTimer(DateTime current) {
    setState(() {
      _isBreak = false;
    });
  }

  void _clockInTimer(DateTime current) {
    Duration amountOfWork = const Duration(hours: 8);
    setState(() {
      _isClockIn = true;
      _startWork = current;
      _workUntil = current.add(amountOfWork);
    });
  }

  void _clockOutTimer(DateTime current) {
    setState(() {
      _isClockIn = false;
    });
    _timer.cancel();
    _clockStreamController.close();
  }

  String totalWorkHour(DateTime current) {
    String temp;
    if (_workUntil == null) {
      temp = '';
    } else {
      Duration difference;
      if (_isBreak) {
        //difference=_workUntil!.difference(stopsAt!); //TODO something here is unadjust or the pause isnot actually stops
        difference = stopsAt!.difference(current);
      } else {
        difference = _workUntil!.difference(current);
      }
      temp =
          '${difference.inHours.toString().padLeft(2, '0')}:${(difference.inMinutes % 60).toString().padLeft(2, '0')}:${(difference.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    if (!_isClockIn) temp = '';
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                      size: 30,
                    ),
                    title: Text(
                      'Welcome back! Mr. Smith',
                      style: ThemeConstant.blackTextBold26,
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                  Center(
                    child: StreamBuilder<DateTime>(
                        stream: _clockStreamController.stream,
                        initialData: DateTime.now(),
                        builder: (context, snapshot) {
                          final currentTime = snapshot.data!;
                          return Column(
                            children: [
                              Text(
                                totalWorkHour(currentTime),
                                style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(_isClockIn
                                  ? _isBreak
                                      ? 'Your remaining work hour : $timerStopAt'
                                      : 'Hi there printTimer'
                                  : 'Hi there you'),
                              const SizedBox(
                                height: 50,
                              ),
                              Center(child: clockInButton(currentTime))
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: const LinearFlowWidget(
          enableHomepage: false,
        ),
      ),
    );
  }

  Column clockInButton(DateTime currentTime) {
    return Column(
      children: [
        _isClockIn
            ? _isBreak
                ? Card(
                    elevation: 25,
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFFFC052))),
                      onPressed: () {
                        _resumeTimer(currentTime);
                      },
                      child: const SizedBox(
                        width: 200,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Continue to work',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                : Card(
                    elevation: 25,
                    child: FilledButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF00A5BA))),
                      onPressed: () {
                        _pauseTimer(currentTime);
                      },
                      child: const SizedBox(
                        width: 200,
                        height: 50,
                        child: Center(
                          child: Text(
                            'Take a break',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
            : Card(
                elevation: 25,
                child: FilledButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 231, 182, 21))),
                  onPressed: () {
                    _clockInTimer(currentTime);
                  },
                  child: const SizedBox(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Clock-In',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        if (_isBreak != true)
          Card(
            elevation: 25,
            child: FilledButton(
              onPressed: () {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.confirm,
                  title: "Are you sure you want to clock-out?",
                  onConfirmBtnTap: () {
                    _clockOutTimer(currentTime);
                    //Navigator.pop(context);
                  },
                  //onCancelBtnTap: () => Navigator.pop(context),
                );
              },
              child: const SizedBox(
                width: 200,
                height: 50,
                child: Center(
                  child: Text(
                    'Clock-Out',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
