import 'package:flutter/material.dart';

import '../../utilities/theme.dart';
class SetWorkType extends StatefulWidget {
  const SetWorkType({super.key});

  @override
  State<SetWorkType> createState() => _SetWorkTypeState();
}

class _SetWorkTypeState extends State<SetWorkType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Work Type',
          style: ThemeConstant.blackTextBold18,
        ),
      ),
    );
  }
}