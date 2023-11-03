import 'dart:convert';

import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_id_generator/custom_id_generator.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_rounded_card.dart';
import 'package:east_personalia/services/local_services/local_json/local_company_json.dart';
import 'package:east_personalia/services/local_services/local_json/local_user_json.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_functions.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FormCompanyViewPage extends StatefulWidget {
  final LocalCompanyJson? companyJson;

  const FormCompanyViewPage({
    super.key,
    this.companyJson,
  });

  @override
  State<FormCompanyViewPage> createState() => _FormCompanyViewPageState();
}

class _FormCompanyViewPageState extends State<FormCompanyViewPage> {
  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _idNumberTEC = TextEditingController();
  final TextEditingController _typeTEC = TextEditingController();
  final TextEditingController _doeTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _addressTEC = TextEditingController();
  final TextEditingController _regionTEC = TextEditingController();
  final TextEditingController _picTEC = TextEditingController();

  List<LocalUserJson> userList = [];

  List<String> typeList = [
    'Produksi',
    'Jasa',
    'Perdagangan',
    'Pertambangan',
    'Pariwisata',
    'Teknologi',
    'Keuangan',
    'Agribisnis',
  ];

  DateTime? _doeSelected;

  @override
  void initState() {
    super.initState();

    _onInitFormCompanyViewPage();
  }

  Future _onInitFormCompanyViewPage() async {
    if(widget.companyJson != null) {
      setState(() {
        _nameTEC.text = widget.companyJson!.companyName ?? '';
        _idNumberTEC.text = widget.companyJson!.companyIdentityNumber ?? '';
        _typeTEC.text = widget.companyJson!.companyType ?? '';
        _doeTEC.text = widget.companyJson!.dateOfEstablishment ?? '';
        _phoneTEC.text = widget.companyJson!.companyPhone ?? '';
        _emailTEC.text = widget.companyJson!.companyEmail ?? '';
        _addressTEC.text = widget.companyJson!.companyAddress ?? '';
        _regionTEC.text = widget.companyJson!.companyRegion ?? '';
        _picTEC.text = widget.companyJson!.companyPIC ?? '';

        _doeSelected = widget.companyJson!.dateOfEstablishment != null
            ? DateTime.parse(widget.companyJson!.dateOfEstablishment!) : null;
      });
    }

    await LocalSessionFunctions(context: context).readListKey(LocalSessionKeys.userList).then((result) {
      List<LocalUserJson> tempUserList = [];

      if(result != null) {
        for(int i = 0; i < result.length; i++) {
          tempUserList.add(LocalUserJson.fromJson(jsonDecode(result[i])));
        }
      }

      setState(() {
        userList = tempUserList;
      });
    });
  }

  Future _showDOEPicker() async {
    await showDatePicker(
      context: context,
      initialDate: _doeSelected ?? DateTime.now(),
      firstDate: DateTime(1923),
      lastDate: DateTime(2073),
    ).then((dateResult) {
      if(dateResult != null) {
        setState(() {
          _doeSelected = dateResult;
          _doeTEC.text = DateFormat('yyyy-MM-dd').format(dateResult);
        });
      }
    });
  }

  Future _submitForm() async {
    if(widget.companyJson != null) {
      await LocalSessionFunctions(context: context).readListKey(LocalSessionKeys.companyList).then((companyResult) async {
        if(companyResult != null) {
          List<String> tempCompanyList = [];

          for(int i = 0; i < companyResult.length; i++) {
            LocalCompanyJson savedCompany = LocalCompanyJson.fromJson(jsonDecode(companyResult[i]));

            if(widget.companyJson!.companyId != null && savedCompany.companyId != widget.companyJson!.companyId) {
              tempCompanyList.add(companyResult[i]);
            }
          }

          String companyJson = jsonEncode(
            LocalCompanyJson(
              companyId: widget.companyJson!.companyId,
              companyName: _nameTEC.text,
              companyIdentityNumber: _idNumberTEC.text,
              companyType: _typeTEC.text,
              dateOfEstablishment: _doeSelected != null ? DateFormat('yyyy/MM/dd').format(_doeSelected!) : null,
              companyPhone: _phoneTEC.text,
              companyEmail: _emailTEC.text,
              companyAddress: _addressTEC.text,
              companyRegion: _regionTEC.text,
              companyPIC: _picTEC.text,
            ).toJson(),
          );

          tempCompanyList.add(companyJson);

          await LocalSessionFunctions(context: context).writeListKey(
            LocalSessionKeys.companyList,
            tempCompanyList,
          ).then((result) {
            if(result == true) {
              CloseBack(context: context).go();
            }
          });
        }
      });
    } else {
      await LocalSessionFunctions(context: context).readListKey(LocalSessionKeys.companyList).then((companyResult) async {
        List<String> tempCompanyList = companyResult ?? [];

        String companyId = CustomStringGenerator.generate(6);

        String companyJson = jsonEncode(
          LocalCompanyJson(
            companyId: companyId,
            companyName: _nameTEC.text,
            companyIdentityNumber: _idNumberTEC.text,
            companyType: _typeTEC.text,
            dateOfEstablishment: _doeSelected != null ? DateFormat('yyyy/MM/dd').format(_doeSelected!) : null,
            companyPhone: _phoneTEC.text,
            companyEmail: _emailTEC.text,
            companyAddress: _addressTEC.text,
            companyRegion: _regionTEC.text,
            companyPIC: _picTEC.text,
          ).toJson(),
        );

        tempCompanyList.add(companyJson);

        await LocalSessionFunctions(context: context).writeListKey(
          LocalSessionKeys.companyList,
          tempCompanyList,
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
              title: 'Form Perusahaan',
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
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
                      labelText: 'Nomor Induk',
                    ),
                    maxLength: 16,
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
                      target: ListOfTypesToSelect(
                        typeList: typeList,
                        onTypeSelect: (String? result) async {
                          if(result != null) {
                            setState(() {
                              _typeTEC.text = result;
                            });
                          }
                        },
                      ),
                    ).go(),
                    child: IgnorePointer(
                      child: TextField(
                        controller: _typeTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: 'Jenis Usaha',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () => _showDOEPicker(),
                    customBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: IgnorePointer(
                      child: TextField(
                        controller: _doeTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: 'Tanggal Berdiri',
                        ),
                      ),
                    ),
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
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _regionTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Regional',
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: () => MoveTo(
                      context: context,
                      target: ListOfUsersToSelect(
                        userList: userList,
                        onUserSelect: (LocalUserJson? result) async {
                          if(result != null) {
                            setState(() {
                              _picTEC.text = result.username ?? 'Unknown User';
                            });
                          }
                        },
                      ),
                    ).go(),
                    child: IgnorePointer(
                      child: TextField(
                        controller: _picTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: 'PIC',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _submitForm(),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        widget.companyJson != null ? 'Perbarui Data' : 'Simpan Data',
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

class ListOfUsersToSelect extends StatelessWidget {
  final List<LocalUserJson> userList;
  final Future Function(LocalUserJson?) onUserSelect;

  const ListOfUsersToSelect({
    super.key,
    required this.userList,
    required this.onUserSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Pilih PIC',
            ),
            Expanded(
              child: userList.isNotEmpty ?
              ListView.builder(
                itemCount: userList.length,
                itemBuilder: (BuildContext userListContext, int userListIndex) {
                  return CustomRoundedCard(
                    onPressed: () =>
                        onUserSelect(
                          userList[userListIndex],
                        ).then((_) =>
                            CloseBack(context: context).go(),
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          userList[userListIndex].company ?? 'Unknown Company',
                          style: CustomTextStyle.comment(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          userList[userListIndex].username ?? 'Unknown User',
                          style: CustomTextStyle.title(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          userList[userListIndex].level ?? 'Unknown Level',
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
                    'Tidak Ada Data User Tersimpan',
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

class ListOfTypesToSelect extends StatelessWidget {
  final List<String> typeList;
  final Future Function(String?) onTypeSelect;

  const ListOfTypesToSelect({
    super.key,
    required this.typeList,
    required this.onTypeSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Pilih Jenis Usaha',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: typeList.length,
                itemBuilder: (BuildContext typeListContext, int typeListIndex) {
                  return CustomRoundedCard(
                    onPressed: () =>
                        onTypeSelect(
                          typeList[typeListIndex],
                        ).then((_) =>
                            CloseBack(context: context).go(),
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          typeList[typeListIndex],
                          style: CustomTextStyle.title(),
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
}