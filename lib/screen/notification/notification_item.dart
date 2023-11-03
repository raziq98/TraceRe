import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracere/model/notification_model.dart';

import '../../model/mockdata/mockUser.dart';
import '../../model/user.dart';
import '../../utilities/theme.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem(
      {super.key, required this.notification, this.isSender});
  final MyNotification notification;
  final bool? isSender;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  late MyNotification _item;
  bool allowEditSuggest = false;
  bool allowEditDesc = false;
  bool isSender = false;
  bool isPending = false;

  final TextEditingController suggestController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final _formkeySuggest = GlobalKey<FormState>();
  final _formkeyDesc = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _item = widget.notification;
    setState(() {
      isSender = widget.isSender ?? false;
    });
  }

  String formatDate(DateTime temp) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(temp);
    return formattedDate;
  }

  Text setStatus(int status) {
    String setStatusName;
    Color colors;
    if (status == 1) {
      setStatusName = 'PENDING';
      colors = ThemeConstant.trcLightPurple;
      if (isSender) {
        setState(() {
          allowEditDesc = true;
          allowEditSuggest = false;
          isPending = false;
        });
      } else {
        setState(() {
          allowEditSuggest = true;
          allowEditDesc = false;
          isPending = true;
        });
      }
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

  String convertToUser(String user) {
    //String formattedDate = DateFormat('yyyy-MM-dd').format(temp);
    List<User> temp =
        MockUser.users.where((item) => item.id.toString() == user).toList();
    String currentUser = '';
    if (user == currentUser) {}
    return temp[0].name ?? '';
  }

  Future<void> _updateSuggestion() async {
    String temp = '';
    if (suggestController.text == '') {
      temp = _item.suggestion ?? '';
    } else {
      temp = suggestController.text;
    }
    var data = {
      "id": _item.id,
      "description": _item.description,
      "suggestion": temp,
      "approver": _item.sendTo,
    };
    if (_formkeySuggest.currentState!.validate()) {}
  }

  Future<void> _updateDescription() async {
    String temp = '';
    if (descController.text == '') {
      temp = _item.description ?? '';
    } else {
      temp = descController.text;
    }
    var data = {
      "id": _item.id,
      "description": temp,
      "suggestion": _item.suggestion,
      "approver": _item.sendTo,
    };
    if (_formkeyDesc.currentState!.validate()) {}
  }

  Future<void> _approve(bool isApprove) async {
    String temp = '';
    if (suggestController.text == '') {
      temp = _item.suggestion ?? '';
    } else {
      temp = suggestController.text;
    }

    var data = {
      "id": _item.id,
      "description": _item.description,
      "suggestion": temp,
      "approver": _item.sendTo,
    };

    if (isApprove) {
      //send API Approve
    } else {
      //send API reject
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            isSender ? 'Sent Email' : 'Recieved Email',
            style: ThemeConstant.blackTextBold18,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            padding: const EdgeInsets.only(left: 25, right: 25),
            //decoration: BoxDecoration(
            //    shape: BoxShape.rectangle,
            //    border: Border.all(
            //      color: ThemeConstant.trcBlue,
            //      width: 1.5
            //    )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Request for : ${_item.requestType ?? ''}',
                  style: ThemeConstant.blackTextBold18,
                ),
                const SizedBox(
                  height: 5,
                ),
                if (_item.requestedDateFrom != null)
                  rowtextbuilder(
                      'Request from :', formatDate(_item.requestedDateFrom!)),
                if (_item.requestedDateTo != null)
                  rowtextbuilder(
                      'Request ends on :', formatDate(_item.requestedDateTo!)),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Status : ',
                      style: ThemeConstant.blackText18,
                    ),
                    setStatus(_item.statusId!),
                    const SizedBox(
                      width: 10,
                    ),
                    if (isPending)
                      Tooltip(
                        message: 'Approve',
                        child: IconButton(
                          onPressed: () {
                            _approve(true);
                          },
                          icon: const Icon(
                            Icons.check_circle_outline,
                            color: ThemeConstant.trcGreen,
                          ),
                        ),
                      ),
                    if (isPending)
                      Tooltip(
                          message: 'Cancel',
                          child: IconButton(
                            onPressed: () {
                              _approve(false);
                            },
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: ThemeConstant.trcRed,
                            ),
                          )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 5.5,
                  color: ThemeConstant.trcGrey,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 15,
                ),
                rowtextbuilder(
                  'Requested By :',
                  convertToUser(_item.sender ?? ''),
                ),
                const SizedBox(
                  height: 5,
                ),
                rowtextbuilder('Sent To :', _item.sendTo ?? ''),
                const SizedBox(
                  height: 5,
                ),
                rowtextbuilder(
                  'Sent at :',
                  formatDate(_item.createdDate!),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 5.5,
                  color: ThemeConstant.trcGrey,
                ),
                const SizedBox(
                  height: 5,
                ),
                decsriptionField(),
                const SizedBox(
                  height: 10,
                ),
                suggestionField(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: isSender
            ? Padding(
                padding: const EdgeInsets.only(left: 19, right: 19, bottom: 15),
                child: Card(
                  elevation: 25,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateBorderSide.resolveWith((states) {
                        double borderWidth =
                            2.0; // Adjust the border width as needed
                        return BorderSide(
                          color: const Color.fromARGB(255, 103, 58, 183),
                          width: borderWidth,
                        );
                      }),
                    ),
                    onPressed: () {
                      _updateDescription();
                    },
                    child: const SizedBox(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : allowEditSuggest
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 19, right: 19, bottom: 15),
                    child: Card(
                      elevation: 25,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          side: MaterialStateBorderSide.resolveWith((states) {
                            double borderWidth =
                                2.0; // Adjust the border width as needed
                            return BorderSide(
                              color: const Color.fromARGB(255, 103, 58, 183),
                              width: borderWidth,
                            );
                          }),
                        ),
                        onPressed: () {
                          _updateSuggestion();
                        },
                        child: const SizedBox(
                          width: 200,
                          height: 50,
                          child: Center(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : null);
  }

  Form decsriptionField() {
    return Form(
      key: _formkeyDesc,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description :',
            style: ThemeConstant.blackText16,
          ),
          const SizedBox(
            height: 10,
          ),
          !allowEditDesc
              ? Text(
                  _item.description ?? 'No Description',
                  style: ThemeConstant.blackText16,
                )
              : TextFormField(
                  controller: descController,
                  style: ThemeConstant.blackTextBold18,
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                    label: Text(
                      'Add Description',
                      style: ThemeConstant.blackText18,
                      textAlign: TextAlign.start,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: ThemeConstant.trcGreen, width: 3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: ThemeConstant.trcBlue, width: 3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Form suggestionField() {
    return Form(
      key: _formkeySuggest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suggestion :',
            style: ThemeConstant.blackText16,
          ),
          const SizedBox(
            height: 10,
          ),
          !allowEditSuggest
              ? Text(
                  _item.suggestion ?? 'No Suggestion',
                  style: ThemeConstant.blackText16,
                )
              : TextFormField(
                  controller: suggestController,
                  style: ThemeConstant.blackTextBold18,
                  minLines: 5,
                  maxLines: null,
                  decoration: InputDecoration(
                    label: Text(
                      'Add suggestion',
                      style: ThemeConstant.blackText18,
                      textAlign: TextAlign.start,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: ThemeConstant.trcGreen, width: 3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: ThemeConstant.trcBlue, width: 3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Row rowtextbuilder(String one, String two) {
    return Row(
      children: [
        Text(
          one,
          style: ThemeConstant.blackText18,
        ),
        Text(
          two,
          style: ThemeConstant.blackTextBold18,
        ),
      ],
    );
  }
}
