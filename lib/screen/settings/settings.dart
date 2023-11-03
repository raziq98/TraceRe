import 'package:flutter/material.dart';
import 'package:tracere/screen/settings/set_holiday.dart';
import 'package:tracere/screen/settings/set_worktype.dart';
import 'package:tracere/screen/settings/update_employee.dart';
import 'package:tracere/utilities/theme.dart';

import 'company/company_profile.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //TODO get previous setting otherwise show default
  //TODO post for any changes
  bool _is8hr = true;
  bool _isRemoveData = false;
  bool _setMaxOffDay = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _customWorkHr = TextEditingController();
  final TextEditingController _setMaxOffday = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _customWorkHr.dispose();
    super.dispose();
  }

  Future<void> _updateEmployerSetting() async {
    if (_formkey.currentState!.validate()) {}
  }

  void navigateToNext(int index) {
    List<Widget> temp = [
      const SetHoliday(),
      const CompanyProfile(),
      const UpdateEmployee(),
      const SetWorkType(),
    ];
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - 100;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: ThemeConstant.blackTextBold18,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: SizedBox(
            height: height,
            width: width,
            child: ListView(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 15,
                ),
                ListTile(
                  title: Text(
                    'Set Holiday',
                    style: ThemeConstant.blackTextBold16,
                  ),
                  onTap: () {
                    navigateToNext(0);
                  },
                ),
                ListTile(
                  title: Text(
                    'Update Company Profile',
                    style: ThemeConstant.blackTextBold16,
                  ),
                  onTap: () {
                    navigateToNext(1);
                  },
                ),
                ListTile(
                  title: Text(
                    'Update Employee list',
                    style: ThemeConstant.blackTextBold16,
                  ),
                  onTap: () {
                    navigateToNext(2);
                  },
                ),
                ListTile(
                  title: Text(
                    'Update WOrk Type',
                    style: ThemeConstant.blackTextBold16,
                  ),
                  onTap: () {
                    navigateToNext(3);
                  },
                ),
                ListTile(
                  title: Text(
                    'Remove data from database after 90 days',
                    style: ThemeConstant.blackTextBold16,
                  ),
                  trailing: Switch(
                    value: _isRemoveData,
                    onChanged: ((value) {
                      setState(() {
                        _isRemoveData = value;
                      });
                    }),
                  ),
                ),
                
                ListTile(
                  title: Text(
                    'Set maximum day of Off-Day',
                    style: ThemeConstant.blackTextBold16,
                  ),
                  trailing: Switch(
                    value: _setMaxOffDay,
                    onChanged: ((value) {
                      setState(() {
                        _setMaxOffDay = value;
                      });
                    }),
                  ),
                  onTap: () {
                    setState(() {
                      _setMaxOffDay = !_setMaxOffDay;
                    });
                  },
                ),
                _setMaxOffDay
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ThemeConstant.trcPink,
                            ),
                            child: TextFormField(
                              controller: _setMaxOffday,
                              decoration: InputDecoration(
                                hintStyle: ThemeConstant.blackText14,
                                hintText: 'Enter maximum Off-Day',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                ListTile(
                  title: Text(
                    'Use Default work hour (8 Hour)',
                    style: ThemeConstant.blackTextBold16,
                  ),
                  trailing: Switch(
                    value: _is8hr,
                    onChanged: ((value) {
                      setState(() {
                        _is8hr = value;
                      });
                    }),
                  ),
                  onTap: () {
                    setState(() {
                      _is8hr = !_is8hr;
                    });
                  },
                ),
                _is8hr
                    ? const SizedBox()
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ThemeConstant.trcPink,
                            ),
                            child: TextFormField(
                              controller: _customWorkHr,
                              decoration: InputDecoration(
                                hintStyle: ThemeConstant.blackText14,
                                hintText: 'Enter desired work hour',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: (_customWorkHr.text != '' ||
              _setMaxOffDay ||
              _isRemoveData ||
              !_is8hr ||
              _setMaxOffday.text != '')
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 5800),
              curve: Curves.fastOutSlowIn,
              width: width,
              height: 90,
              child: Center(
                child: SizedBox(
                  width: 250,
                  height: 60,
                  child: Card(
                    elevation: 25,
                    child: OutlinedButton(
                      onPressed: () {
                        _updateEmployerSetting();
                      },
                      child: Center(
                        child: Text(
                          'Update',
                          style: ThemeConstant.blackTextBold18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
