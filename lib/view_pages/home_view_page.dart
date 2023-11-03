import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_dialog/dialog_functions.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/services/local_services/local_json/local_sign_in_info_json.dart';
import 'package:east_personalia/services/local_services/local_json/local_user_json.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_functions.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_keys.dart';
import 'package:east_personalia/view_pages/employee_menu_page/employee_absence_view_page.dart';
import 'package:east_personalia/view_pages/employee_menu_page/employee_reimbursement_view_page.dart';
import 'package:east_personalia/view_pages/help_view_page.dart';
import 'package:east_personalia/view_pages/management_page/absence_view_page.dart';
import 'package:east_personalia/view_pages/management_page/master_data_view_page.dart';
import 'package:east_personalia/view_pages/management_page/reimbursement_view_page.dart';
import 'package:east_personalia/view_pages/profile_view_page.dart';
import 'package:east_personalia/view_pages/splash_view_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  State<HomeViewPage> createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  LocalSignInInfoJson? signInInfoJson;
  LocalUserJson? userJson;

  List<Map<String, Map<IconData, Function>>> homeMenuList = [];

  List<Map<String, Map<IconData, Function>>> drawerMenuList = [
    {
      'Pusat Bantuan': {
        Icons.help_outline: (BuildContext context) => MoveTo(context: context, target: const HelpViewPage()).go(),
      },
    },
  ];

  @override
  void initState() {
    super.initState();

    _onInitHomeViewPage();
  }

  Future _onInitHomeViewPage() async {
    await LocalSessionFunctions(context: context).readKey(LocalSessionKeys.signInInfo).then((signInInfo) async {
      if(signInInfo != null) {
        setState(() {
          signInInfoJson = LocalSignInInfoJson.fromJson(jsonDecode(signInInfo));
        });
      }

      if(signInInfoJson != null && signInInfoJson!.userData != null && signInInfoJson!.token != null && signInInfoJson!.tokenValidUntil != null) {
        DateTime now = DateTime.now();
        DateTime tokenValidity = DateTime.parse(signInInfoJson!.tokenValidUntil!);

        if(now.isBefore(tokenValidity)) {
          setState(() {
            userJson = LocalUserJson.fromJson(jsonDecode(signInInfoJson!.userData!));

            if(userJson != null && userJson!.role != null) {
              switch(userJson!.role!) {
                case 'admin':
                  homeMenuList = [
                    {
                      'Master Data' : {
                        Icons.group: (BuildContext context) => MoveTo(context: context, target: const MasterDataViewPage()).go(),
                      },
                    },
                    {
                      'Absensi' : {
                        Icons.access_time: (BuildContext context) => MoveTo(context: context, target: const AbsenceViewPage()).go(),
                      },
                    },
                    {
                      'Pembayaran' : {
                        Icons.credit_card: (BuildContext context) => MoveTo(context: context, target: const ReimbursementViewPage()).go(),
                      },
                    },
                  ];
                  break;
                case 'management':
                  homeMenuList = [
                    {
                      'Master Data' : {
                        Icons.group: (BuildContext context) => MoveTo(context: context, target: const MasterDataViewPage()).go(),
                      },
                    },
                    {
                      'Absensi' : {
                        Icons.access_time: (BuildContext context) => MoveTo(context: context, target: const AbsenceViewPage()).go(),
                      },
                    },
                    {
                      'Pembayaran' : {
                        Icons.credit_card: (BuildContext context) => MoveTo(context: context, target: const ReimbursementViewPage()).go(),
                      },
                    },
                  ];
                  break;
                case 'employee':
                  homeMenuList = [
                    {
                      'Absensi' : {
                        Icons.access_time: (BuildContext context) => MoveTo(context: context, target: const EmployeeAbsenceViewPage()).go(),
                      },
                    },
                    {
                      'Pembayaran' : {
                        Icons.credit_card: (BuildContext context) => MoveTo(context: context, target: const EmployeeReimbursementViewPage()).go(),
                      },
                    },
                  ];
                  break;
                default:
                  LocalSessionFunctions(context: context).removeKey(LocalSessionKeys.signInInfo).then((removed) {
                    if(removed == true) {
                      OkDialog(
                        context: context,
                        content: 'Akun ini tidak terdaftar pada sistem, silahkan coba lagi menggunakan akun lain',
                        headIcon: false,
                        okPressed: () => RedirectTo(context: context, target: const SplashViewPage()).go(),
                      ).show();
                    }
                  });
              }
            }
          });
        } else {
          await LocalSessionFunctions(context: context).removeKey(LocalSessionKeys.signInInfo).then((removed) {
            if(removed == true) {
              OkDialog(
                context: context,
                content: 'Sesi akun telah berakhir, Anda akan diarahkan ke halaman masuk',
                headIcon: false,
                okPressed: () => RedirectTo(context: context, target: const SplashViewPage()).go(),
              ).show();
            }
          });
        }
      }
    });
  }

  Future _signOutSystem() async {
    await OptionDialog(
      context: context,
      content: 'Keluar dari sesi aplikasi saat ini, Anda yakin?',
      yesPressed: () async => await LocalSessionFunctions(context: context).removeKey(LocalSessionKeys.signInInfo).then((removed) {
        if(removed == true) {
          RedirectTo(context: context, target: const SplashViewPage()).go();
        }
      }),
    ).show();
  }

  Widget _homeDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.1,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 6,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => MoveTo(
                    context: context,
                    target: const ProfileViewPage(),
                  ).go(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: userJson != null && userJson!.profilePictURL != null ? userJson!.profilePictURL! : '',
                          placeholder: (BuildContext loading, _) {
                            return const SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: Padding(
                                padding: EdgeInsets.all(30.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          imageBuilder: (BuildContext imgContext, ImageProvider imgProvider) {
                            return Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imgProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          errorWidget: (BuildContext errContext, _, __) {
                            return const SizedBox(
                              width: 80.0,
                              height: 80.0,
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 60.0,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                userJson != null && userJson!.email != null ? userJson!.email! : 'Unknown Email',
                                style: CustomTextStyle.content().copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                userJson != null && userJson!.username != null ? userJson!.username! : 'Unknown Username',
                                style: CustomTextStyle.content().copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Icon(
                          Icons.navigate_next,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: drawerMenuList.length,
                separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.black54,
                      thickness: 1.0,
                      height: 0.0,
                    ),
                  );
                },
                itemBuilder: (BuildContext menuListContext, int menuListIndex) {
                  return InkWell(
                    onTap: () => drawerMenuList[menuListIndex].values.first.values.first(context),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Icon(
                            drawerMenuList[menuListIndex].values.first.keys.first,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              drawerMenuList[menuListIndex].keys.first,
                              style: CustomTextStyle.content(),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Icon(
                            Icons.navigate_next,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () => _signOutSystem(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Keluar dari Sesi',
                      style: CustomTextStyle.content().copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Beta (v1.0.0)',
                style: CustomTextStyle.comment(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'EAST PERSONALIA',
                        style: CustomTextStyle.title(),
                      ),
                    ],
                  ),
                  Builder(
                      builder: (BuildContext drawerContext) {
                        return InkWell(
                          onTap: () => Scaffold.of(drawerContext).openDrawer(),
                          customBorder: const CircleBorder(),
                          child: Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.menu,
                                size: 30.0,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                          style: CustomTextStyle.comment().copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Selamat Datang,',
                          style: CustomTextStyle.comment(),
                        ),
                        Text(
                          userJson != null && userJson!.username != null ? userJson!.username! : 'Unknown User',
                          style: CustomTextStyle.title(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black54,
                    thickness: 1.5,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemCount: homeMenuList.length,
                    itemBuilder: (BuildContext menuListContext, int menuListIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () => homeMenuList[menuListIndex].values.first.values.first(context),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(
                                homeMenuList[menuListIndex].values.first.keys.first,
                                color: Colors.white,
                                size: 50.0,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                homeMenuList[menuListIndex].keys.first,
                                style: CustomTextStyle.content().copyWith(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: _homeDrawer(),
    );
  }
}