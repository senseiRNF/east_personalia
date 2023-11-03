import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ReimbursementApprovalViewPage extends StatefulWidget {
  const ReimbursementApprovalViewPage({super.key});

  @override
  State<ReimbursementApprovalViewPage> createState() => _ReimbursementApprovalViewPageState();
}

class _ReimbursementApprovalViewPageState extends State<ReimbursementApprovalViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Persetujuan Pembayaran',
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