import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_rounded_card.dart';
import 'package:east_personalia/view_pages/management_page/absence_page/form_page/form_absence_request_view_page.dart';
import 'package:flutter/material.dart';

class AbsenceRequestViewPage extends StatefulWidget {
  const AbsenceRequestViewPage({super.key});

  @override
  State<AbsenceRequestViewPage> createState() => _AbsenceRequestViewPageState();
}

class _AbsenceRequestViewPageState extends State<AbsenceRequestViewPage> {
  List absenceRequestList = [];

  Future _onInitAbsenceRequestViewPage() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Pengajuan Absensi',
            ),
            Expanded(
              child: absenceRequestList.isNotEmpty ?
              ListView.builder(
                itemCount: absenceRequestList.length,
                itemBuilder: (BuildContext userListContext, int userListIndex) {
                  return const CustomRoundedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

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
                    'Tidak Ada Data Pengajuan Absensi Tersimpan',
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
                          target: const FormAbsenceRequestViewPage(),
                          callback: (_) => _onInitAbsenceRequestViewPage(),
                        ).go(),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Tambah Pengajuan Absensi',
                            style: CustomTextStyle.content(),
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