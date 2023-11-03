import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class EmployeeAbsenceRecapViewPage extends StatefulWidget {
  const EmployeeAbsenceRecapViewPage({super.key});

  @override
  State<EmployeeAbsenceRecapViewPage> createState() => _EmployeeAbsenceRecapViewPageState();
}

class _EmployeeAbsenceRecapViewPageState extends State<EmployeeAbsenceRecapViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Rekap Absensi Karyawan',
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