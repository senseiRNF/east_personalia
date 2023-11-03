import 'dart:convert';

import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_rounded_card.dart';
import 'package:east_personalia/services/local_services/local_json/local_company_json.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_functions.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_keys.dart';
import 'package:east_personalia/view_pages/management_page/master_data_page/form_page/form_company_view_page.dart';
import 'package:flutter/material.dart';

class MasterCompanyViewPage extends StatefulWidget {
  const MasterCompanyViewPage({super.key});

  @override
  State<MasterCompanyViewPage> createState() => _MasterCompanyViewPageState();
}

class _MasterCompanyViewPageState extends State<MasterCompanyViewPage> {
  List<LocalCompanyJson> companyList = [];

  @override
  void initState() {
    super.initState();

    _onInitMasterCompanyViewPage();
  }

  Future _onInitMasterCompanyViewPage() async {
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

  Future _removeCompany(String companyId) async {
    await LocalSessionFunctions(context: context).readListKey(LocalSessionKeys.companyList).then((result) async {
      List<String> tempCompanyList = [];

      if(result != null) {
        for(int i = 0; i < result.length; i++) {
          if(LocalCompanyJson.fromJson(jsonDecode(result[i])).companyId != companyId) {
            tempCompanyList.add(result[i]);
          }
        }
      }

      await LocalSessionFunctions(context: context).writeListKey(
        LocalSessionKeys.companyList,
        tempCompanyList,
      ).then((_) => _onInitMasterCompanyViewPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Master Perusahaan',
            ),
            Expanded(
              child: companyList.isNotEmpty ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: () => MoveTo(
                        context: context,
                        target: const FormCompanyViewPage(),
                        callback: (_) => _onInitMasterCompanyViewPage(),
                      ).go(),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Tambah Data Perusahaan',
                          style: CustomTextStyle.content().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: companyList.length,
                      itemBuilder: (BuildContext companyListContext, int companyListIndex) {
                        return CustomRoundedCard(
                          onPressed: () => MoveTo(
                            context: context,
                            target: FormCompanyViewPage(
                              companyJson: companyList[companyListIndex],
                            ),
                          ),
                          onLongPressed: () => companyList[companyListIndex].companyId != null
                              ? _removeCompany(companyList[companyListIndex].companyId!) : null,
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
                    ),
                  ),
                ],
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => MoveTo(
                          context: context,
                          target: const FormCompanyViewPage(),
                          callback: (_) => _onInitMasterCompanyViewPage(),
                        ).go(),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Tambah Data Perusahaan',
                            style: CustomTextStyle.content().copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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