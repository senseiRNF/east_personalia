import 'dart:convert';

import 'package:east_personalia/miscellaneous/custom_app_styles/custom_input_decoration.dart';
import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_dialog/dialog_functions.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/services/local_services/local_json/local_sign_in_info_json.dart';
import 'package:east_personalia/services/local_services/local_json/local_user_json.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_functions.dart';
import 'package:east_personalia/services/local_services/local_sessions/local_session_keys.dart';
import 'package:east_personalia/view_pages/help_view_page.dart';
import 'package:east_personalia/view_pages/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignInViewPage extends StatefulWidget {
  const SignInViewPage({super.key});

  @override
  State<SignInViewPage> createState() => _SignInViewPageState();
}

class _SignInViewPageState extends State<SignInViewPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool obscurePassword = true;

  Future _signInSystem() async {
    await LocalSessionFunctions(context: context).readListKey(LocalSessionKeys.userList).then((result) async {
      if(result != null) {
        List<LocalUserJson> userList = [];

        for(int i = 0; i < result.length; i++) {
          userList.add(LocalUserJson.fromJson(jsonDecode(result[i])));
        }

        if(_username.text != '' && _password.text != '') {
          bool isAllowSignIn = false;
          LocalUserJson? user;

          for(int i = 0; i < userList.length; i++) {
            if(_username.text == userList[i].email && _password.text == userList[i].password) {
              isAllowSignIn = true;
              user = userList[i];

              break;
            }
          }

          if(isAllowSignIn == true && user != null) {
            await LocalSessionFunctions(context: context).writeKey(
              'sign_in_info',
              jsonEncode(
                LocalSignInInfoJson(
                  userData: jsonEncode(user.toJson()),
                  token: '${DateFormat('yyyyMMddHHmm').format(DateTime.now())}-${user.userId}',
                  tokenValidUntil: DateFormat('yyyy-MM-dd').format(
                    DateTime.now().add(
                      const Duration(days: 3),
                    ),
                  ),
                ).toJson(),
              ),
            ).then((_) {
              ReplaceTo(
                context: context,
                target: const HomeViewPage(),
              ).go();
            });
          } else {
            OkDialog(
              context: context,
              content: 'Username & Password tidak terdaftar, pastikan Username & Password telah terisi dengan benar, lalu coba lagi',
              headIcon: false,
            ).show();
          }
        } else {
          OkDialog(
            context: context,
            content: 'Username & Password tidak boleh kosong, pastikan Username & Password telah terisi, lalu coba lagi',
            headIcon: false,
          ).show();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: InkWell(
                    onTap: () => MoveTo(
                      context: context, target: const HelpViewPage(),
                    ).go(),
                    customBorder: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.help_outline,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5.0,
            ),
            Text(
              'EAST PERSONALIA',
              style: CustomTextStyle.title(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              'Selamat Datang',
              style: CustomTextStyle.title(),
              textAlign: TextAlign.center,
            ),
            Text(
              'Silahkan masuk untuk melanjutkan',
              style: CustomTextStyle.content(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: _username,
              decoration: CustomInputDecoration.borderedTextField('Username'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _password,
              decoration: CustomInputDecoration.borderedTextField('Password').copyWith(
                suffixIcon: InkWell(
                  onTap: () => setState(() {
                    obscurePassword = !obscurePassword;
                  }),
                  customBorder: const CircleBorder(),
                  child: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: obscurePassword,
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () => _signInSystem(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Sign In',
                  style: CustomTextStyle.title().copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}