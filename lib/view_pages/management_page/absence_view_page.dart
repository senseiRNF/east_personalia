import 'package:east_personalia/miscellaneous/custom_app_styles/custom_date_format.dart';
import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_rounded_card.dart';
import 'package:east_personalia/view_pages/management_page/absence_page/absence_approval_view_page.dart';
import 'package:east_personalia/view_pages/management_page/absence_page/absence_request_view_page.dart';
import 'package:east_personalia/view_pages/management_page/absence_page/employee_absence_recap_view_page.dart';
import 'package:east_personalia/view_pages/management_page/absence_page/personal_absence_recap_view_page.dart';
import 'package:flutter/material.dart';

class AbsenceViewPage extends StatefulWidget {
  const AbsenceViewPage({super.key});

  @override
  State<AbsenceViewPage> createState() => _AbsenceViewPageState();
}

class _AbsenceViewPageState extends State<AbsenceViewPage> {
  String dummyCheckIn = '07:45';
  String dummyCheckOut = '17:15';

  int dummyLeaveBalance = 10;

  List<Map<String, Function>> absenceMenuList = [
    {
      'Pengajuan Absensi': (BuildContext context) => MoveTo(context: context, target: const AbsenceRequestViewPage()).go(),
    },
    {
      'Persetujuan Absensi': (BuildContext context) => MoveTo(context: context, target: const AbsenceApprovalViewPage()).go(),
    },
    {
      'Rekap Absensi Pribadi': (BuildContext context) => MoveTo(context: context, target: const PersonalAbsenceRecapViewPage()).go(),
    },
    {
      'Rekap Absensi Karyawan': (BuildContext context) => MoveTo(context: context, target: const EmployeeAbsenceRecapViewPage()).go(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Absensi',
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: [
                  CustomRoundedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Absensi Hari Ini',
                          style: CustomTextStyle.title(),
                        ),
                        Text(
                          "(${CustomDateFormatter(data: DateTime.now(), usingDay: true).shortDMY()})",
                          style: CustomTextStyle.comment(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Absen Masuk',
                                    style: CustomTextStyle.content(),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    dummyCheckIn,
                                    style: CustomTextStyle.title().copyWith(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Absen Pulang',
                                    style: CustomTextStyle.content(),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    dummyCheckOut,
                                    style: CustomTextStyle.title().copyWith(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomRoundedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Sisa Cuti',
                          style: CustomTextStyle.title(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Cuti Tahunan',
                          style: CustomTextStyle.content(),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          '$dummyLeaveBalance Hari',
                          style: CustomTextStyle.title().copyWith(
                            fontSize: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: absenceMenuList.length,
                    separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                      return const SizedBox(
                        height: 5.0,
                      );
                    },
                    itemBuilder: (BuildContext menuListContext, int menuListIndex) {
                      return ElevatedButton(
                        onPressed: () => absenceMenuList[menuListIndex].values.first(context),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  absenceMenuList[menuListIndex].keys.first,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}