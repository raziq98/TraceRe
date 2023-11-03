import 'package:flutter/material.dart';

import '../../components/notification_list_animation.dart';
import '../../model/mockdata/mockNotification.dart';
import '../../model/notification_model.dart';
import '../../utilities/theme.dart';
import 'notification_item.dart';

class Delivered extends StatefulWidget {
  const Delivered({super.key});

  @override
  State<Delivered> createState() => _DeliveredState();
}

class _DeliveredState extends State<Delivered> {
  List<MyNotification> _currentNoti = [];
  final GlobalKey<AnimatedListState> listenkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _currentNoti = MockNotification.notifications
          .where((element) => element.sender == '2')
          .toList();
    });
  }

  void navigateToNext(int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut, // Add your desired curve here
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
            NotificationItem(
          notification: _currentNoti[index],
          isSender: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivered',
          style: ThemeConstant.blackTextBold18,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height - 100,
          width: width,
          child: AnimatedList(
            key: listenkey,
            initialItemCount: _currentNoti.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return NotificationItemList(
                item: _currentNoti[index],
                animations: animation,
                onTap: () => navigateToNext(index),
              );
            },
          ),
        ),
      ),
    );
  }
}
