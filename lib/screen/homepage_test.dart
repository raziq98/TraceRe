import 'dart:async';
import 'package:flutter/material.dart';


class WorkTimer extends StatefulWidget {
  const WorkTimer({super.key});

  @override
  _WorkTimerState createState() => _WorkTimerState();
}

class _WorkTimerState extends State<WorkTimer> {
  final StreamController<DateTime> _timerController = StreamController<DateTime>();

  DateTime? lastClockInTime;
  DateTime? lastBreakTime;
  DateTime totalWorkTime = DateTime(0, 0, 0, 0, 0, 0);
  DateTime totalRestTime = DateTime(0, 0, 0, 0, 0, 0);

  @override
  void dispose() {
    _timerController.close();
    super.dispose();
  }

  void _startTimer() {
    final now = DateTime.now();
    if (lastClockInTime != null) {
      if (lastBreakTime == null) {
        totalWorkTime = totalWorkTime.add(now.difference(lastClockInTime!));
      } else {
        totalRestTime = totalRestTime.add(now.difference(lastBreakTime!));
      }
    }
    lastClockInTime = now;
    _timerController.add(now);
  }

  void _takeBreak() {
    final now = DateTime.now();
    lastBreakTime = now;
    _timerController.add(now);
  }

  void _continueWork() {
    final now = DateTime.now();
    lastBreakTime = null;
    lastClockInTime = now;
    _timerController.add(now);
  }

  void _clockOut() {
    final now = DateTime.now();
    if (lastClockInTime != null && lastBreakTime == null) {
      totalWorkTime = totalWorkTime.add(now.difference(lastClockInTime!));
    } else if (lastBreakTime != null) {
      totalRestTime = totalRestTime.add(now.difference(lastBreakTime!));
    }
    lastClockInTime = null;
    lastBreakTime = null;
    _timerController.add(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<DateTime>(
              stream: _timerController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final currentDateTime = snapshot.data!;
                  Duration workTime = currentDateTime.difference(lastClockInTime ?? currentDateTime);

                  final restTime = currentDateTime.difference(lastBreakTime ?? currentDateTime);

                  return Column(
                    children: [
                      Text('Total Work Time: ${_formatDuration(workTime)}'),
                      Text('Total Rest Time: ${_formatDuration(restTime)}'),
                      Text('Current Time: ${_formatTime(currentDateTime)}'),
                    ],
                  );
                } else {
                  return const Text('Loading...');
                }
              },
            ),
            ElevatedButton(
              onPressed: _startTimer,
              child: const Text('Clock-In'),
            ),
            ElevatedButton(
              onPressed: _takeBreak,
              child: const Text('Take a Break'),
            ),
            ElevatedButton(
              onPressed: _continueWork,
              child: const Text('Continue Work'),
            ),
            ElevatedButton(
              onPressed: _clockOut,
              child: const Text('Clock-Out'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  String _formatTime(DateTime dateTime) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    final seconds = dateTime.second.toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}
