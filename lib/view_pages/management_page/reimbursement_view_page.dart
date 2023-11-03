import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_rounded_card.dart';
import 'package:east_personalia/view_pages/management_page/reimbursement_page/reimbursement_approval_view_page.dart';
import 'package:east_personalia/view_pages/management_page/reimbursement_page/reimbursement_request_view_page.dart';
import 'package:flutter/material.dart';

class ReimbursementViewPage extends StatefulWidget {
  const ReimbursementViewPage({super.key});

  @override
  State<ReimbursementViewPage> createState() => _ReimbursementViewPageState();
}

class _ReimbursementViewPageState extends State<ReimbursementViewPage> {
  String? dummyTotalReimbursement = 'Rp. 5.000.000,-';

  int dummyPendingReimbursement = 5;
  int dummyAcceptedReimbursement = 2;
  int dummyRejectedReimburesment = 4;

  List<Map<String, Function>> reimbursementMenuList = [
    {
      'Pengajuan Pembayaran': (BuildContext context) => MoveTo(context: context, target: const ReimbursementRequestViewPage()).go(),
    },
    {
      'Persetujuan Pembayaran': (BuildContext context) => MoveTo(context: context, target: const ReimbursementApprovalViewPage()).go(),
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
              title: 'Pembayaran',
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                children: [
                  CustomRoundedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Rekap Pembayaran Bulan Ini',
                          style: CustomTextStyle.title(),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Menunggu Persetujuan',
                          style: CustomTextStyle.content(),
                        ),
                        Text(
                          '$dummyPendingReimbursement Pembayaran',
                          style: CustomTextStyle.content().copyWith(
                            fontSize: 24.0,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Telah Disetujui',
                          style: CustomTextStyle.content(),
                        ),
                        Text(
                          '$dummyAcceptedReimbursement Pembayaran',
                          style: CustomTextStyle.content().copyWith(
                            fontSize: 24.0,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Ditolak',
                          style: CustomTextStyle.content(),
                        ),
                        Text(
                          '$dummyRejectedReimburesment Pembayaran',
                          style: CustomTextStyle.content().copyWith(
                            fontSize: 24.0,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Total Pembayaran',
                          style: CustomTextStyle.content(),
                        ),
                        Text(
                          '$dummyTotalReimbursement',
                          style: CustomTextStyle.content().copyWith(
                            fontSize: 24.0,
                          ),
                          textAlign: TextAlign.end,
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
                    itemCount: reimbursementMenuList.length,
                    separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                      return const SizedBox(
                        height: 5.0,
                      );
                    },
                    itemBuilder: (BuildContext menuListContext, int menuListIndex) {
                      return ElevatedButton(
                        onPressed: () => reimbursementMenuList[menuListIndex].values.first(context),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  reimbursementMenuList[menuListIndex].keys.first,
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