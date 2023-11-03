import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ReimbursementRequestViewPage extends StatefulWidget {
  const ReimbursementRequestViewPage({super.key});

  @override
  State<ReimbursementRequestViewPage> createState() => _ReimbursementRequestViewPageState();
}

class _ReimbursementRequestViewPageState extends State<ReimbursementRequestViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Pengajuan Pembayaran',
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