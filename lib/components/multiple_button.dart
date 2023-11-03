import 'package:flutter/material.dart';

import '../dashboard/dashboard.dart';
import '../model/mockdata/mockNotification.dart';
import '../model/notification_model.dart';
import '../screen/homepage.dart';
import '../screen/notification/notification_screen.dart';
import '../screen/profile/profile.dart';
import '../screen/settings/settings.dart';
import '../utilities/theme.dart';

class LinearFlowWidget extends StatefulWidget {
  const LinearFlowWidget({
    super.key,
    required this.enableHomepage,
  });
  final bool enableHomepage;

  @override
  State<LinearFlowWidget> createState() => _LinearFlowWidgetState();
}

class _LinearFlowWidgetState extends State<LinearFlowWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<IconData> iconButtons = [];
  List<String> tooltipList = [];
  final bool _hasAuthority = true;
  List<Widget> widgetList = [];
  List<MyNotification> _currentNoti = [];
  String notiAmount = '0';

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    List<IconData> tempIcon = [
      Icons.menu_outlined,
      Icons.home_outlined,
      Icons.mail_outline,
      Icons.person_2_outlined,
      Icons.dark_mode_outlined,
      Icons.home_max_outlined,
      Icons.settings_outlined,
    ];
    List<Widget> tempNavigate = [
      Container(),
      const HomePage(),
      const NotificationsScreen(),
      const Profile(),
      Container(),
      const Dashboard(),
      const Settings(),
    ];
    List<String> tempText = [
      'Menu',
      'Home',
      'Notification',
      'Profile',
      'Dark Mode',
      'Dashboard',
      'Settings',
    ];
    iconButtons =
        _hasAuthority ? tempIcon : tempIcon.sublist(0, tempIcon.length - 2);
    tooltipList =
        _hasAuthority ? tempText : tempText.sublist(0, tempText.length - 2);
    widgetList = _hasAuthority
        ? tempNavigate
        : tempNavigate.sublist(0, tempNavigate.length - 2);

    if (widget.enableHomepage == false) {
      iconButtons.removeAt(1);
      tooltipList.removeAt(1);
      widgetList.removeAt(1);
    }

    _currentNoti = MockNotification.notifications;
    setState(() {
      notiAmount = _currentNoti.length.toString();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void navigateToNext(int index) {
    List<Widget> temp = widgetList;
    try {
      if (temp[index] == Container()) {
      } else {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
                temp[index],
          ),
        );
      }
    } catch (e) {
      // TODO
      debugPrint('error here');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(
        controller: _animationController,
      ),
      children: iconButtons.map<Widget>((iconButton) {
        return buildItem(iconButton, iconButtons.indexOf(iconButton));
      }).toList(),
    );
  }

  String _getNotiCount(String notiAmount) {
    String count = notiAmount;
    return count;
  }

  Widget buildItem(IconData icondata, int index) {
    bool isNotification = tooltipList[index] == 'Notification';
    bool isDarkModeButton = tooltipList[index] == 'Dark Mode';
    return Card(
      elevation: 5,
      color: ThemeConstant.trcWhite,
      shape: const CircleBorder(),
      child: IconButton(
        iconSize: ThemeConstant.iconSize2,
        highlightColor: Colors.orangeAccent,
        splashRadius: 15,
        onPressed: () {
          if (index == 0) {
            if (_animationController.status == AnimationStatus.completed) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          } else if (isDarkModeButton) {
            //TODO apply dark mode
            //TODO set dark mode in hive and access it
            if (_animationController.status == AnimationStatus.completed) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          } else {
            navigateToNext(index);
          }
        },
        tooltip: tooltipList[index],
        icon: isNotification
            ? Badge(
                label: Text(_getNotiCount(notiAmount),
                    style: const TextStyle(color: Colors.white)),
                backgroundColor: Colors.red,
                child: Icon(
                  icondata,
                  color: Colors.deepPurple,
                ),
              )
            : Icon(
                icondata,
                color: Colors.deepPurple,
              ),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;
  FlowMenuDelegate({
    required this.controller,
  }) : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - 57;
    final yStart = size.height - 58;

    for (int i = context.childCount - 1; i >= 0; i--) {
      const margin = 8;
      final childSize = context.getChildSize(i)!.width;
      final dx = (childSize + margin) * i;
      //for vertical icon display (on y axis)
      final x = xStart;
      final y =
          yStart - dx * controller.value; //controller value is between 0 to 1

      /* fpr horizontal icon display (on x axis)
      final x = xStart - dx;
      final y = yStart;
      */

      context.paintChild(
        i, //index
        transform:
            Matrix4.translationValues(x, y, 0), //translationValues(x,y,0)
      );
    }

    /* alternative for 1 by 1
    context.paintChild(
      0, //index  of icon
      transform: Matrix4.translationValues(50,100,0), //translationValues(x,y,0)
    )
    context.paintChild(
      1, //index of icon
      transform: Matrix4.translationValues(150,200,0), //translationValues(x,y,0)
    )
    context.paintChild(
      2, //index
      transform: Matrix4.translationValues(50,300,0), //translationValues(x,y,0)
    )
    */
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    //throw UnimplementedError();
    return false;
  }
}
