import 'package:flutter/material.dart';
import 'package:tracere/model/mockdata/mockUser.dart';
import 'package:tracere/model/notification_model.dart';
import 'package:tracere/utilities/theme.dart';
import 'package:intl/intl.dart';

import '../model/user.dart'; // Import the intl package

class NotificationItemList extends StatelessWidget {
  final MyNotification item;
  final Animation<double> animations;
  final VoidCallback? onTap;
  const NotificationItemList(
      {super.key, required this.item, required this.animations, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(sizeFactor: animations, child: buildItem());
  }

  String formatStart(DateTime temp) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(temp);
    return formattedDate;
  }

  Text setStatus(int status) {
    String setStatusName;
    Color colors;
    if (status == 1) {
      setStatusName = 'PENDING';
      colors = ThemeConstant.trcLightPurple;
    } else if (status == 2) {
      setStatusName = 'APPROVED';
      colors = ThemeConstant.trcGreen;
    } else if (status == 3) {
      setStatusName = 'REJECTED';
      colors = ThemeConstant.trcRed;
    } else {
      setStatusName = '';
      colors = Colors.transparent;
    }
    return Text(
      setStatusName,
      style:
          TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colors),
    );
  }

  String fromUser(String user) {
    //String formattedDate = DateFormat('yyyy-MM-dd').format(temp);
    List<User> temp =
        MockUser.users.where((item) => item.id.toString() == user).toList();
    String currentUser = '';
    if (user == currentUser) {}
    return temp[0].name ?? '';
  }

  String toUser(String user) {
    //String formattedDate = DateFormat('yyyy-MM-dd').format(temp);
    //List<User> temp=MockUser.users.map((e) => null);
    List<User> temp =
        MockUser.users.where((item) => item.id.toString() == user).toList();
    String currentUser = '';
    if (user == currentUser) {}
    return temp[0].name ?? '';
  }

  Widget buildItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ThemeConstant.trcPink),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    'Request for ${item.requestType}',
                    style: ThemeConstant.blackTextBold16,
                  ),
                  //Text(
                  //  ' @ ',
                  //  style: ThemeConstant.blackTextBold16,
                  //),
                  //Text(
                  //  setStatus(item.statusId!),
                  //  style: ThemeConstant.blackTextBold16,
                  //),
                ],
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.all(18.0),
              child: setStatus(item.statusId!),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From : ${fromUser(item.sender!)}',
                    style: ThemeConstant.blackText16,
                  ),
                  Text('To : ${item.sendTo!}',
                      style: ThemeConstant.blackText16),
                  Text('Sent at : ${formatStart(item.createdDate!)}',
                      style: ThemeConstant.blackText16),
                ],
              ),
            ),
            onTap: onTap,
          )),
    );
  }
}
