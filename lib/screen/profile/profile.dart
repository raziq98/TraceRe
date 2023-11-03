import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tracere/utilities/theme.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User _currentUser;
  bool _isEdit = false;
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _departmentIdController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  File? _profilePicture;

  @override
  void initState() {
    //TODO get list of department
    //TODO get list of country
    //TODO get user's data


    super.initState();
    _currentUser = User(
      id: 41,
      name: 'Hanabi Brown',
      userCode: 'EB004',
      address: '234 Maple Lane',
      postalCode: '98765',
      country: 'Australia',
      photo: 'assets/images/picture-png.png',
      phone: '******',
      email: 'emily@example.com',
      password: 'pass987',
      roleId: 1,
      branchCode: 'BR004',
      departmentId: 1,
      isAvailable: true,
      isOffDay: true,
    );

    //TODO abolish this:
    isLoading = true;
  }

  

  Future<File?> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<File?> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  void _selectFromGallery() async {
    File? image = await _getImageFromGallery();
    if (image != null) {
      setState(() {
        _profilePicture = image;
      });
    }
  }

  void _captureFromCamera() async {
    File? image = await _getImageFromCamera();
    if (image != null) {
      setState(() {
        _profilePicture = image;
      });
    }
  }

  Future<void> _showImagePicker(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.photo_library,color: ThemeConstant.trcGreen,),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  _selectFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt,color: ThemeConstant.trcGreen,),
                title: const Text('Take a Photo'),
                onTap: () {
                  _captureFromCamera();
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveData() async {
    if (_formkey.currentState!.validate()) {
      //! ALL PASSED value check
      //TODO submit photo also
      _nameController;
      _phoneController;
      _emailController;
      _birthdayController;
      _addressController;
      _postalCodeController;
      _departmentIdController;
      _countryController;
      setState(() {
        _isEdit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(
          'Profile',
          style: ThemeConstant.blackTextBold18,
        ),),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height + height - (height * 0.6),
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              pictureSection(context),
              detailSection(),
              const SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: _isEdit ? 'Save' : 'Edit',
        onPressed: () {
          if (!_isEdit) {
            setState(() {
              _isEdit = true;
            });
          } else {
            setState(() {
              _isEdit = false;
            });
            _saveData();
          }
        },
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: ThemeConstant.trcBlack,
            width: 1,
          ),
        ),
        backgroundColor:
            _isEdit ? ThemeConstant.trcGreen : ThemeConstant.trcPink,
        child: Icon(
          _isEdit ? Icons.save_alt_outlined : Icons.edit,
          color: ThemeConstant.trcBlack,
        ),
      ),
    );
  }

  Padding detailSection() {
    return Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailField(_currentUser.userCode ?? '', 'User Code',
                        false, TextEditingController(), false),
                    const SizedBox(
                      height: 15,
                    ),
                    detailField(_currentUser.name ?? '', 'Name', _isEdit,
                        _nameController, true),
                    const SizedBox(
                      height: 15,
                    ),
                    detailField(_currentUser.phone ?? '', 'Phone Number',
                        _isEdit, _phoneController, true),
                    const SizedBox(
                      height: 15,
                    ),
                    detailField(_currentUser.email ?? '', 'Email', _isEdit,
                        _emailController, true),
                    const SizedBox(
                      height: 15,
                    ),
                    detailField(_currentUser.dateOfBirth ?? '',
                        'Date of Birth', true, _birthdayController, _isEdit),
                    const SizedBox(
                      height: 15,
                    ),
                    detailField(_currentUser.address ?? '', 'Address',
                        _isEdit, _addressController, true),
                    const SizedBox(
                      height: 15,
                    ),
                    detailField(_currentUser.postalCode ?? '', 'Postal Code',
                        _isEdit, _postalCodeController, true),
                    const SizedBox(
                      height: 15,
                    ),
                    detailField(_currentUser.departmentId.toString(),
                        'Department', _isEdit, _departmentIdController, true),
                    const SizedBox(
                      height: 15,
                    ),
                    detailField(_currentUser.country ?? '', 'Country',
                        _isEdit, _countryController, true),
                  ],
                ),
              ),
            );
  }

  Column pictureSection(BuildContext context) {
    return Column(
              children: [
                SizedBox(
                  height: 160,
                  width: 160,
                  child: Card(
                    elevation: 12,
                    child: _isEdit
                        ? Stack(
                            children: [
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    _showImagePicker(context);
                                  },
                                  child: Container(
                                    height: 160,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ThemeConstant.trcLightPurple,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: _profilePicture != null
                                        ? _profilePicture is File
                                            ? Image.file(_profilePicture as File)
                                            : Image.asset(
                                                _profilePicture as String)
                                        : Image.asset(_currentUser.photo!),
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ThemeConstant.trcGreen),
                                    child: Center(
                                      child: IconButton(
                                          tooltip: 'Upload Photo',
                                          onPressed: () {
                                            _showImagePicker(context);
                                          },
                                          icon: const Center(
                                            child: Icon(
                                              Icons.upload_outlined,
                                              size: 30,
                                              color: ThemeConstant.trcBlack,
                                            ),
                                          )),
                                    ),
                                  ))
                            ],
                          )
                        : Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ThemeConstant.trcLightPurple, width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset(_currentUser.photo!),
                          ),
                  ),
                ),
              ],
            );
  }

  TextFormField detailField(String text, String texthint, bool? isEdit,
      TextEditingController? controller, bool isEditable) {
    controller!.text = text;
    return TextFormField(
      controller: controller,
      style: ThemeConstant.blackTextBold18,
      enabled: isEdit == true
          ? isEditable
              ? true
              : false
          : false,
      autofocus: true,
      decoration: InputDecoration(
        label: Text(
          texthint,
          style: ThemeConstant.blackTextBold18,
        ),
        fillColor: const Color.fromARGB(255, 111, 26, 214),
        disabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: ThemeConstant.trcLightPurple, width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color:isEdit==true?ThemeConstant.trcGreen: ThemeConstant.trcLightPurple, width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeConstant.trcGreen, width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      readOnly: isEdit == false ? true : false,
    );
  }
}
