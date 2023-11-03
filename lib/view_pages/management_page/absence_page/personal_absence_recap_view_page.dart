import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PersonalAbsenceRecapViewPage extends StatefulWidget {
  const PersonalAbsenceRecapViewPage({super.key});

  @override
  State<PersonalAbsenceRecapViewPage> createState() => _PersonalAbsenceRecapViewPageState();
}

class _PersonalAbsenceRecapViewPageState extends State<PersonalAbsenceRecapViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Rekap Absensi Pribadi',
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