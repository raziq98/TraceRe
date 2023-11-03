import 'package:flutter/material.dart';
import 'package:tracere/model/mockdata/mockNotification.dart';
import 'package:tracere/screen/notification/compose.dart';
import 'package:tracere/screen/notification/delivered.dart';

import '../../components/notification_list_animation.dart';
import '../../model/notification_model.dart';
import '../../utilities/theme.dart';
import 'notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int? _currentUser;
  List<MyNotification> _currentNoti = [];
  final GlobalKey<AnimatedListState> listenkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadData() {
    setState(() {
      _currentUser = 123;
      _currentNoti = MockNotification.notifications;
    });
  }

  void _isOpened(int index) {
    setState(() {
      _currentNoti[index].isRead = true;
    });
  }

  void navigateToNext(int? index) {
    Widget temp;
    if(index==null){
      temp=const Delivered();
    }else{
      temp=NotificationItem(notification: _currentNoti[index]);
    }
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
            temp,
      ),
    );
  }

  void _compose() {
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
            const Compose(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[100],
          actions: [
            IconButton(onPressed: (){
              //navigate to previously sent email
              navigateToNext(null);
            }, icon: const Icon(Icons.upload_outlined,size: 27,))
          ],
          title: Text(
            'Notifications',
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
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return NotificationItemList(
                  item: _currentNoti[index],
                  animations: animation,
                  onTap: () => navigateToNext(index),
                );
              },
            ),
          ),
        ),
        floatingActionButton: InkWell(
          onTap: () => _compose(),
          child: Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: ThemeConstant.trcGreen,
            ),
            child: Center(
              child: Text(
                'COMPOSE',
                textAlign: TextAlign.justify,
                textWidthBasis: TextWidthBasis.longestLine,
                style: ThemeConstant.blackTextBold18,
              ),
            ),
          ),
        )
        //FloatingActionButton(
        //    backgroundColor: ThemeConstant.trcGreen,
        //    onPressed: () => _compose(),
        //    // ignore: sized_box_for_whitespace
        //    child: Container(
        //      width: 390,
        //      height: 120,
        //      child: Center(
        //        child: Text(
        //          'Compose',
        //          style: ThemeConstant.blackTextBold18,
        //        ),
        //      ),
        //    )),
        );
  }
}
