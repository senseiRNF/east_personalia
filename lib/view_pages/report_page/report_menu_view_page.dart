import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ReportMenuViewPage extends StatefulWidget {
  const ReportMenuViewPage({super.key});

  @override
  State<ReportMenuViewPage> createState() => _ReportMenuViewPageState();
}

class _ReportMenuViewPageState extends State<ReportMenuViewPage> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomAppBar(
              title: 'Menu Laporan',
            ),
          ],
        ),
      ),
    );
  }
}