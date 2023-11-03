import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_functions.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_keys.dart';
import 'package:east_personalia/view_pages/home_view_page.dart';
import 'package:east_personalia/view_pages/sign_in_view_page.dart';
import 'package:flutter/material.dart';

class SplashViewPage extends StatefulWidget {
  const SplashViewPage({super.key});

  @override
  State<SplashViewPage> createState() => _SplashViewPageState();
}

class _SplashViewPageState extends State<SplashViewPage> {

  @override
  void initState() {
    super.initState();

    _onInitSplashViewPage();
  }

  Future _onInitSplashViewPage() async {
    await LocalSessionFunctions(context: context).readKey(LocalSessionKeys.signInInfo).then((signInInfo) async {
      if(signInInfo != null) {
        await Future.delayed(
          const Duration(seconds: 3), () =>
            ReplaceTo(
              context: context, target: const HomeViewPage(),
            ).go(),
        );
      } else {
        await Future.delayed(
          const Duration(seconds: 3), () =>
            ReplaceTo(
              context: context, target: const SignInViewPage(),
            ).go(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'EAST PERSONALIA',
                    style: CustomTextStyle.title(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Beta (v1.0.0)',
                style: CustomTextStyle.comment(),
                textAlign: TextAlign.center,
              ),
            ),
            const LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}