import 'dart:convert';

import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_id_generator/custom_id_generator.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_rounded_card.dart';
import 'package:east_personalia/services/local_services/local_json/local_company_json.dart';
import 'package:east_personalia/services/local_services/local_json/local_sign_in_info_json.dart';
import 'package:east_personalia/services/local_services/local_json/local_user_json.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_functions.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormUserViewPage extends StatefulWidget {
  final LocalUserJson? userJson;

  const FormUserViewPage({
    super.key,
    this.userJson,
  });

  @override
  State<FormUserViewPage> createState() => _FormUserViewPageState();
}

class _FormUserViewPageState extends State<FormUserViewPage> {
  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _idNumberTEC = TextEditingController();
  final TextEditingController _pobTEC = TextEditingController();
  final TextEditingController _dobTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _addressTEC = TextEditingController();
  final TextEditingController _emergencyNumberTEC = TextEditingController();
  final TextEditingController _npwpTEC = TextEditingController();
  final TextEditingController _companyTEC = TextEditingController();
  final TextEditingController _levelTEC = TextEditingController();

  List<LocalCompanyJson> companyList = [];

  String? _genderSelected;
  String? _roleSelected;

  DateTime? _dobSelected;

  @override
  void initState() {
    super.initState();

    _onInitFormUserViewPage();
  }

  Future _onInitFormUserViewPage() async {
    if(widget.userJson != null) {
      setState(() {
        _nameTEC.text = widget.userJson!.username ?? '';
        _idNumberTEC.text = widget.userJson!.identityNumber ?? '';
        _pobTEC.text = widget.userJson!.placeOfBirth ?? '';
        _dobTEC.text = widget.userJson!.dateOfBirth ?? '';
        _phoneTEC.text = widget.userJson!.phone ?? '';
        _emailTEC.text = widget.userJson!.email ?? '';
        _addressTEC.text = widget.userJson!.address ?? '';
        _emergencyNumberTEC.text = widget.userJson!.emergencyNumber ?? '';
        _npwpTEC.text = widget.userJson!.npwp ?? '';
        _companyTEC.text = widget.userJson!.company ?? '';
        _levelTEC.text = widget.userJson!.level ?? '';

        _genderSelected = widget.userJson!.gender;
        _roleSelected = widget.userJson!.role;

        _dobSelected = widget.userJson!.dateOfBirth != null
            ? DateTime.parse(widget.userJson!.dateOfBirth!) : null;
      });
    }

    await LocalSessionFunctions(context: context).readListKey(LocalSessionKeys.companyList).then((result) {
      List<LocalCompanyJson> tempCompanyList = [];

      if(result != null) {
        for(int i = 0; i < result.length; i++) {
          tempCompanyList.add(LocalCompanyJson.fromJson(jsonDecode(result[i])));
        }
      }

      setState(() {
        companyList = tempCompanyList;
      });
    });
  }

  Future _showDOBPicker() async {
    await showDatePicker(
      context: context,
      initialDate: _dobSelected ?? DateTime.now(),
      firstDate: DateTime(1923),
      lastDate: DateTime(2073),
    ).then((dateResult) {
      if(dateResult != null) {
        setState(() {
          _dobSelected = dateResult;
          _dobTEC.text = DateFormat('yyyy-MM-dd').format(dateResult);
        });
      }
    });
  }

  Future _submitForm() async {
    if(widget.userJson != null) {
      await LocalSessionFunctions(context: context).readKey(LocalSessionKeys.signInInfo).then((signInInfoResult) async {
        LocalSignInInfoJson? signInInfoJson;
        LocalUserJson? signInUserJson;

        if(signInInfoResult != null) {
          signInInfoJson = LocalSignInInfoJson.fromJson(jsonDecode(signInInfoResult));

          if(signInInfoJson.userData != null) {
            signInUserJson = LocalUserJson.fromJson(jsonDecode(signInInfoJson.userData!));
          }
        }

        await LocalSessionFunctions(context: context).readListKey(LocalSessionKeys.userList).then((userResult) async {
          if(userResult != null) {
            List<String> tempUserList = [];

            for(int i = 0; i < userResult.length; i++) {
              LocalUserJson savedUser = LocalUserJson.fromJson(jsonDecode(userResult[i]));

              if(widget.userJson!.userId != null && savedUser.userId != widget.userJson!.userId) {
                tempUserList.add(userResult[i]);
              }
            }

            LocalUserJson userJson = LocalUserJson(
              userId: widget.userJson!.userId,
              password: widget.userJson!.password,
              profilePictURL: '',
              username: _nameTEC.text,
              identityNumber: _idNumberTEC.text,
              placeOfBirth: _pobTEC.text,
              dateOfBirth: _dobSelected != null ? DateFormat('yyyy/MM/dd').format(_dobSelected!) : null,
              gender: _genderSelected,
              phone: _phoneTEC.text,
              email: _emailTEC.text,
              address: _addressTEC.text,
              emergencyNumber: _emergencyNumberTEC.text,
              npwp: _npwpTEC.text,
              company: _companyTEC.text,
              level: _levelTEC.text,
              role: _roleSelected,
            );

            String updatedUserJson = jsonEncode(userJson.toJson());

            tempUserList.add(updatedUserJson);

            if(signInUserJson != null && signInUserJson.userId == widget.userJson!.userId) {
              String updatedSignInInfoJson = jsonEncode(
                LocalSignInInfoJson(
                  userData: updatedUserJson,
                  token: signInInfoJson!.token,
                  tokenValidUntil: signInInfoJson.tokenValidUntil,
                ).toJson(),
              );

              await LocalSessionFunctions(context: context).writeKey(
                LocalSessionKeys.signInInfo,
                updatedSignInInfoJson,
              ).then((_) async {
                await LocalSessionFunctions(context: context).writeListKey(
                  LocalSessionKeys.userList,
                  tempUserList,
                ).then((result) {
                  if(result == true) {
                    CloseBack(context: context).go();
                  }
                });
              });
            } else {
              await LocalSessionFunctions(context: context).writeListKey(
                LocalSessionKeys.userList,
                tempUserList,
              ).then((result) {
                if(result == true) {
                  CloseBack(context: context).go();
                }
              });
            }
          }
        });
      });
    } else {
      await LocalSessionFunctions(context: context).readListKey(LocalSessionKeys.userList).then((userResult) async {
        List<String> tempUserList = userResult ?? [];

        String userId = CustomStringGenerator.generate(6);
        String password = CustomStringGenerator.generate(6);

        String userJson = jsonEncode(
          LocalUserJson(
            userId: userId,
            password: password,
            profilePictURL: '',
            username: _nameTEC.text,
            identityNumber: _idNumberTEC.text,
            placeOfBirth: _pobTEC.text,
            dateOfBirth: _dobSelected != null ? DateFormat('yyyy/MM/dd').format(_dobSelected!) : null,
            gender: _genderSelected,
            phone: _phoneTEC.text,
            email: _emailTEC.text,
            address: _addressTEC.text,
            emergencyNumber: _emergencyNumberTEC.text,
            npwp: _npwpTEC.text,
            company: _companyTEC.text,
            level: _levelTEC.text,
            role: _roleSelected,
          ).toJson(),
        );

        tempUserList.add(userJson);

        await LocalSessionFunctions(context: context).writeListKey(
          LocalSessionKeys.userList,
          tempUserList,
        ).then((result) {
          if(result == true) {
            CloseBack(context: context).go();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Form User',
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  IconButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(0.0),
                    iconSize: 80.0,
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _nameTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Nama',
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _idNumberTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Nomor Identitas (KTP/Paspor)',
                    ),
                    maxLength: 16,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _pobTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Tempat Lahir',
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () => _showDOBPicker(),
                    customBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: IgnorePointer(
                      child: TextField(
                        controller: _dobTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: 'Tanggal Lahir',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Jenis Kelamin',
                      style: CustomTextStyle.comment().copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          value: 'L',
                          groupValue: _genderSelected,
                          onChanged: (genderResult) {
                            if(_genderSelected != genderResult) {
                              setState(() {
                                _genderSelected = genderResult;
                              });
                            }
                          },
                          contentPadding: EdgeInsets.zero,
                          activeColor: Theme.of(context).primaryColorDark,
                          title: Text(
                            'Laki - laki',
                            style: CustomTextStyle.content(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: 'P',
                          groupValue: _genderSelected,
                          onChanged: (genderResult) {
                            if(_genderSelected != genderResult) {
                              setState(() {
                                _genderSelected = genderResult;
                              });
                            }
                          },
                          contentPadding: EdgeInsets.zero,
                          activeColor: Theme.of(context).primaryColorDark,
                          title: Text(
                            'Perempuan',
                            style: CustomTextStyle.content(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _phoneTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Nomor Telepon',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _emailTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: _addressTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Alamat',
                      alignLabelWithHint: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _emergencyNumberTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Nomor Darurat',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _npwpTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'NPWP',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () => MoveTo(
                      context: context,
                      target: ListOfCompaniesToSelect(
                        companyList: companyList,
                        onCompanySelect: (LocalCompanyJson? result) async {
                          if(result != null) {
                            setState(() {
                              _companyTEC.text = result.companyName ?? 'Unknown Company';
                            });
                          }
                        },
                      ),
                    ).go(),
                    customBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: IgnorePointer(
                      child: TextField(
                        controller: _companyTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: 'Perusahaan',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _levelTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Jabatan',
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Role Sistem',
                      style: CustomTextStyle.comment().copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      RadioListTile(
                        value: 'admin',
                        groupValue: _genderSelected,
                        onChanged: (genderResult) => setState(() {
                          _genderSelected = genderResult;
                        }),
                        contentPadding: EdgeInsets.zero,
                        activeColor: Theme.of(context).primaryColorDark,
                        title: Text(
                          'Administrator',
                          style: CustomTextStyle.content(),
                        ),
                      ),
                      RadioListTile(
                        value: 'management',
                        groupValue: _genderSelected,
                        onChanged: (genderResult) => setState(() {
                          _genderSelected = genderResult;
                        }),
                        contentPadding: EdgeInsets.zero,
                        activeColor: Theme.of(context).primaryColorDark,
                        title: Text(
                          'Management',
                          style: CustomTextStyle.content(),
                        ),
                      ),
                      RadioListTile(
                        value: 'employee',
                        groupValue: _genderSelected,
                        onChanged: (genderResult) => setState(() {
                          _genderSelected = genderResult;
                        }),
                        contentPadding: EdgeInsets.zero,
                        activeColor: Theme.of(context).primaryColorDark,
                        title: Text(
                          'Karyawan',
                          style: CustomTextStyle.content(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _submitForm(),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.userJson != null ? 'Perbarui Data' : 'Simpan Data',
                        style: CustomTextStyle.title().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListOfCompaniesToSelect extends StatelessWidget {
  final List<LocalCompanyJson> companyList;
  final Future Function(LocalCompanyJson?) onCompanySelect;

  const ListOfCompaniesToSelect({
    super.key,
    required this.companyList,
    required this.onCompanySelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Pilih Perusahaan',
            ),
            Expanded(
              child: companyList.isNotEmpty ?
              ListView.builder(
                itemCount: companyList.length,
                itemBuilder: (BuildContext companyListContext, int companyListIndex) {
                  return CustomRoundedCard(
                    onPressed: () =>
                        onCompanySelect(
                          companyList[companyListIndex],
                        ).then((_) =>
                            CloseBack(context: context).go(),
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          companyList[companyListIndex].companyIdentityNumber ?? 'Unknown Identity Number',
                          style: CustomTextStyle.comment(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          companyList[companyListIndex].companyName ?? 'Unknown Company',
                          style: CustomTextStyle.title(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          companyList[companyListIndex].companyRegion ?? 'Unknown Region',
                          style: CustomTextStyle.comment(),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  );
                },
              ) :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Tidak Ada Data Perusahaan Tersimpan',
                    style: CustomTextStyle.content(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}