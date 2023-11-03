import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracere/model/mockdata/mockBranch.dart';
import 'package:tracere/model/mockdata/mockCompany.dart';
import '../../../model/branch.dart';
import '../../../model/company.dart';
import '../../../utilities/theme.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  late List<Company> _company;

  File? _profilePicture;
  bool _isEdit = false;
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  //Company
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _establishedDateController =
      TextEditingController();
  final TextEditingController _companyBioController = TextEditingController();
  // Branch
  late Company selectedCompany;
  late List<Branch> branchList;
  final TextEditingController _compayIdController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _serverController = TextEditingController();

  @override
  void initState() {
    // TODO: have to show warning to user to inform every employee once change branch code and domain
    // TODO branchCode is generated upon creation in branch model or db
    // TODO any changes on branch do on _updateCompanyBranch
    // TODO any changes on company do on _saveData

    super.initState();
    _company =
        MockCompany.companies.where((company) => company.id == 1).toList();
    if (_company.isNotEmpty) {
      selectedCompany = _company[0];
    }
    branchList = MockBranch.branches
        .where((branch) => branch.companyId == selectedCompany.id.toString())
        .toList();
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
                leading: const Icon(
                  Icons.photo_library,
                  color: ThemeConstant.trcGreen,
                ),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  _selectFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: ThemeConstant.trcGreen,
                ),
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
      _nameController.text;
      _phoneController.text;
      _emailController.text;
      _establishedDateController.text;
      setState(() {
        _isEdit = false;
      });
    }
  }

  Future<void> _updateCompanyBranch() async {
    try {
      _compayIdController.text;
      _addressController.text;
      _postalCodeController.text;
      _countryController.text;
      _domainController.text;
      _serverController.text;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> _updateBranch(BuildContext context, Branch? branch) async {
    bool isUpdate = branch != null;
    await showModalBottomSheet(
        context: context,
        elevation: 2,
        shape: const LinearBorder(),
        builder: (BuildContext context) {
          return SizedBox(
            height: 800,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    isUpdate
                        ? "Update the branch : ${branch.branchCode}"
                        : "Add new branch",
                    style: ThemeConstant.blackTextBold18,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  branchDetailField(branch?.companyId ?? '', 'Company Id', true,
                      _compayIdController, true),
                  const SizedBox(
                    height: 8,
                  ),
                  branchDetailField(branch?.address ?? '', 'Address', true,
                      _addressController, true),
                  const SizedBox(
                    height: 8,
                  ),
                  branchDetailField(branch?.postalCode ?? '', 'Postal Code',
                      true, _postalCodeController, true),
                  const SizedBox(
                    height: 8,
                  ),
                  branchDetailField(branch?.country ?? '', 'Country', true,
                      _countryController, true),
                  const SizedBox(
                    height: 8,
                  ),
                  branchDetailField(branch?.domain ?? '', 'Domain', true,
                      _domainController, true),
                  const SizedBox(
                    height: 8,
                  ),
                  branchDetailField(branch?.server ?? '', 'Server', true,
                      _serverController, true),
                  //const Spacer(),
                  const SizedBox(
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          isUpdate
                              ? CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.confirm,
                                  title:
                                      "Please inform the employee for any changes made",
                                  onConfirmBtnTap: () {
                                    _updateCompanyBranch();
                                    Navigator.pop(context);
                                  },
                                  onCancelBtnTap: () => Navigator.pop(context),
                                )
                              : {
                                  _updateCompanyBranch(),
                                  Navigator.pop(context),
                                };
                        },
                        child: Container(
                          width: 210,
                          height: 60,
                          decoration: BoxDecoration(
                            color: ThemeConstant.trcGreen,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                              child: Text(
                            isUpdate ? 'Update Branch' : 'Add Branch',
                            style: ThemeConstant.blackTextBold18,
                          )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
        },
        isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Company's Profile",
          style: ThemeConstant.blackTextBold18,
        ),
      ),
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
            const SizedBox(
              height: 15,
            ),
            detailField(selectedCompany.name ?? '', 'Company Name', _isEdit,
                _nameController, true),
            const SizedBox(
              height: 15,
            ),
            detailField(selectedCompany.phone ?? '', 'Phone Number', _isEdit,
                _phoneController, true),
            const SizedBox(
              height: 15,
            ),
            detailField(selectedCompany.email ?? '', 'Email', _isEdit,
                _emailController, true),
            const SizedBox(
              height: 15,
            ),
            detailField(
                selectedCompany.establishedDate ?? '',
                'Date of Establishment',
                true,
                _establishedDateController,
                _isEdit),
            const SizedBox(
              height: 15,
            ),
            detailField(selectedCompany.companyBio ?? '', "Company's Biography",
                _isEdit, _companyBioController, true),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  'Branch List',
                  style: ThemeConstant.blackTextBold18,
                ),
                const Spacer(),
                _isEdit
                    ? InkWell(
                        onTap: () {
                          _updateBranch(context, null);
                        },
                        child: Container(
                          width: 140,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ThemeConstant.trcGreen,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                              child: Text(
                            'Add New Branch',
                            style: ThemeConstant.blackTextBold14,
                          )),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: branchList.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 200,
                    height: 150,
                    padding: const EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ThemeConstant.trcGrey1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          branchList[index].branchCode ?? '',
                          style: ThemeConstant.blackTextBold18,
                        ),
                        Text(
                          branchList[index].address ?? '',
                          style: ThemeConstant.blackText14,
                        ),
                        Text(branchList[index].postalCode ?? '',
                            style: ThemeConstant.blackText14),
                        Text(branchList[index].country ?? '',
                            style: ThemeConstant.blackText14),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                _updateBranch(context, branchList[index]);
                              },
                              child: Container(
                                width: 140,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ThemeConstant.trcLightPurple,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                    child: Text(
                                  'Edit Branch',
                                  style: ThemeConstant.whiteTextBold14,
                                )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
                                    : Image.asset(_profilePicture as String)
                                : Image.asset(selectedCompany.photo!),
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
                    child: Image.asset(selectedCompany.photo!),
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
          borderSide: BorderSide(
              color: isEdit == true
                  ? ThemeConstant.trcGreen
                  : ThemeConstant.trcLightPurple,
              width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeConstant.trcBlue, width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      readOnly: isEdit == false ? true : false,
    );
  }

  SizedBox branchDetailField(String text, String texthint, bool? isEdit,
      TextEditingController? controller, bool isEditable) {
    controller!.text = text;
    return SizedBox(
      height: 60,
      child: TextFormField(
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
}
