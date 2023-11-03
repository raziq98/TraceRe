import 'package:flutter/material.dart';
import 'package:tracere/model/holiday.dart';
import 'package:tracere/utilities/theme.dart';
import 'package:intl/intl.dart';  // Import the intl package


class AnimatedItemList extends StatelessWidget {
  final Holiday item;
  final Animation<double> animations;
  final VoidCallback? onTap;
  const AnimatedItemList(
      {super.key, required this.item, required this.animations, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(sizeFactor: animations, child: buildItem());
  }

  String formatStart(DateTime temp){
    String formattedDate = DateFormat('yyyy-MM-dd').format(temp);
    return formattedDate;
  }

  String formatEnd(DateTime temp){
    String formattedDate = DateFormat('yyyy-MM-dd').format(temp);
    return formattedDate;
  }

  Widget buildItem() {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ThemeConstant.trcPink),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            //leading: const SizedBox(width: 1,),
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                item.name ?? '',
                style: ThemeConstant.blackTextBold16,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        formatStart(item.startFrom! ),
                        style: ThemeConstant.blackText16,
                      ),
                      Text(' - ${formatEnd(item.endAt!)}', style: ThemeConstant.blackText16),
                    ],
                  ),
                  Text('Days : ${item.dayAmount}',
                      style: ThemeConstant.blackText16),
                ],
              ),
            ),
            trailing: IconButton(
              onPressed: onTap,
              icon: const Icon(
                Icons.delete,
                color: ThemeConstant.trcLightPurple,size: 35,
              ),
            ),
          )),
    );
  }
}
