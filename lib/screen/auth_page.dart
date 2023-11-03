import 'package:flutter/material.dart';
import 'package:tracere/screen/homepage.dart';
import 'package:tracere/utilities/theme.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _branchCodeController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool emailError = false;
  bool passwordError = false;
  bool branchCodeError = false;
  bool domainError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _branchCodeController.dispose();
    _domainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 75;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration',
          style: ThemeConstant.blackTextBold18,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  emailField(),
                  const SizedBox(
                    height: 15,
                  ),
                  passwordField(),
                  const SizedBox(
                    height: 15,
                  ),
                  branchField(),
                  const SizedBox(
                    height: 15,
                  ),
                  domainField(),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 55,
                        width: 250,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(5.0),
                          ),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                emailError = false;
                                passwordError = false;
                                branchCodeError = false;
                                domainError = false;
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    final curvedAnimation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves
                                          .easeInOut, // Add your desired curve here
                                    );
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0.0),
                                        end: Offset.zero,
                                      ).animate(curvedAnimation),
                                      child: child,
                                    );
                                  },
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const HomePage(),
                                ),
                              );
                            }
                          },
                          child: Center(
                            child: Text(
                              'Register',
                              style: ThemeConstant.blackTextBold18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column emailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: ThemeConstant.blackTextBold18,
        ),
        SizedBox(
          height: emailError ? 85 : 65,
          child: Expanded(
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value == '') {
                  setState(() {
                    emailError = true;
                  });
                  return 'Email is reuired field';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Column branchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Branch Code',
          style: ThemeConstant.blackTextBold18,
        ),
        SizedBox(
          height: branchCodeError ? 85 : 65,
          child: Expanded(
            child: TextFormField(
              controller: _branchCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value == '') {
                  setState(() {
                    branchCodeError = true;
                  });
                  return 'Branch code is reuired field';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Column passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: ThemeConstant.blackTextBold18,
        ),
        SizedBox(
          height: passwordError ? 85 : 65,
          child: Expanded(
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value == '') {
                  setState(() {
                    passwordError = true;
                  });
                  return 'Password is reuired field';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Column domainField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Domain',
          style: ThemeConstant.blackTextBold18,
        ),
        SizedBox(
          height: domainError ? 85 : 65,
          child: Expanded(
            child: TextFormField(
              controller: _domainController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ThemeConstant.trcLightgrey,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value == '') {
                  setState(() {
                    domainError = true;
                  });
                  return 'Domain is reuired field';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
