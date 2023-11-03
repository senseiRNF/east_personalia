import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AbsenceApprovalViewPage extends StatefulWidget {
  const AbsenceApprovalViewPage({super.key});

  @override
  State<AbsenceApprovalViewPage> createState() => _AbsenceApprovalViewPageState();
}

class _AbsenceApprovalViewPageState extends State<AbsenceApprovalViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Persetujuan Absensi',
            ),
            Expanded(
              child: ListView(),
            ),
          ],
        ),
      ),
    );
  }
}