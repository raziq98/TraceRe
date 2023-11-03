import 'package:flutter/material.dart';

import '../../utilities/theme.dart';

class Compose extends StatefulWidget {
  const Compose({super.key});

  @override
  State<Compose> createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _sendTo = TextEditingController();
  final TextEditingController _details = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _subject.dispose();
    _details.dispose();
    _sendTo.dispose();
  }

  void submit() {
    if (_formkey.currentState!.validate()) {
      var data = {
        'send_to': _sendTo.text,
        'subject': _subject.text,
        'details': _details.text,
      };
    }
  }

  SizedBox textField(String texthint, bool? isEdit,
      TextEditingController? controller, double height) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        style: ThemeConstant.blackTextBold18,
        enabled: isEdit == true ? true : false,
        autofocus: true,
        minLines: 10,
        maxLines: null,
        decoration: InputDecoration(
          labelStyle: const TextStyle(),
          label: Text(
            texthint,
            style: ThemeConstant.blackTextBold18,
            textAlign: TextAlign.start,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ThemeConstant.trcGreen, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ThemeConstant.trcBlue, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        readOnly: isEdit == false ? true : false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COMPOSE',
          textAlign: TextAlign.justify,
          textWidthBasis: TextWidthBasis.longestLine,
          style: ThemeConstant.blackTextBold18,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 100,
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  textField('Send To', true, _sendTo, 60),
                  const SizedBox(
                    height: 15,
                  ),
                  textField('Subject ', true, _subject, 60),
                  const SizedBox(
                    height: 15,
                  ),
                  textField('Details', true, _details, 400),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 19,right: 19,bottom: 15),
        child: Card(
          elevation: 25,
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateBorderSide.resolveWith((states) {
                double borderWidth = 2.0; // Adjust the border width as needed
                return BorderSide(
                  color: const Color.fromARGB(255, 103, 58, 183),
                  width: borderWidth,
                );
              }),
            ),
            onPressed: () {},
            child: const SizedBox(
              width: 200,
              height: 50,
              child: Center(
                child: Text(
                  'Send',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
