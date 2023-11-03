import 'dart:convert';

import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_rounded_card.dart';
import 'package:east_personalia/services/local_services/local_json/local_user_json.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_functions.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_keys.dart';
import 'package:east_personalia/view_pages/management_page/master_data_page/form_page/form_user_view_page.dart';
import 'package:flutter/material.dart';

class MasterUserViewPage extends StatefulWidget {
  const MasterUserViewPage({super.key});

  @override
  State<MasterUserViewPage> createState() => _MasterUserViewPageState();
}

class _MasterUserViewPageState extends State<MasterUserViewPage> {
  List<LocalUserJson> userList = [];

  @override
  void initState() {
    super.initState();

    _onInitMasterUserViewPage();
  }

  Future _onInitMasterUserViewPage() async {
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

  Future _removeUser(String userId) async {
    await LocalSessionFunctions(context: context).readListKey(LocalSessionKeys.userList).then((result) async {
      List<String> tempUserList = [];

      if(result != null) {
        for(int i = 0; i < result.length; i++) {
          if(LocalUserJson.fromJson(jsonDecode(result[i])).userId != userId) {
            tempUserList.add(result[i]);
          }
        }
      }

      await LocalSessionFunctions(context: context).writeListKey(
        LocalSessionKeys.userList,
        tempUserList,
      ).then((_) => _onInitMasterUserViewPage());
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
              title: 'Master User',
            ),
            Expanded(
              child: userList.isNotEmpty ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ElevatedButton(
                      onPressed: () => MoveTo(
                        context: context,
                        target: const FormUserViewPage(),
                        callback: (_) => _onInitMasterUserViewPage(),
                      ).go(),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Tambah Akun User',
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
                      itemCount: userList.length,
                      itemBuilder: (BuildContext userListContext, int userListIndex) {
                        return CustomRoundedCard(
                          onPressed: () => MoveTo(
                            context: context,
                            target: FormUserViewPage(
                              userJson: userList[userListIndex],
                            ),
                          ),
                          onLongPressed: () => userList[userListIndex].userId != null
                              ? _removeUser(userList[userListIndex].userId!) : null,
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
                    ),
                  ),
                ],
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => MoveTo(
                          context: context,
                          target: const FormUserViewPage(),
                          callback: (_) => _onInitMasterUserViewPage(),
                        ).go(),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Tambah Akun User',
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