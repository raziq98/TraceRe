import 'package:flutter/material.dart';
import 'package:tracere/model/user.dart';
import '../utilities/theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late User _currentUser;
  User me = User(
    id: 41,
    name: 'Hanabi Brown',
    userCode: 'EB004',
    address: '234 Maple Lane',
    postalCode: '98765',
    country: 'Australia',
    photo: 'profile4.jpg',
    phone: '******',
    email: 'emily@example.com',
    password: 'pass987',
    roleId: 1,
    branchCode: 'BR004',
    departmentId: 1,
    isAvailable: true,
    isOffDay: true,
  );
  @override
  void initState() {
    super.initState();
    _currentUser = widget.user ?? me;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: ThemeConstant.blackTextBold18,
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
