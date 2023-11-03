import 'package:cached_network_image/cached_network_image.dart';
import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_rounded_card.dart';
import 'package:flutter/material.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({super.key});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {

  @override
  void initState() {
    super.initState();

    _onInitProfileViewPage();
  }
  
  Future _onInitProfileViewPage() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Profile',
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: '',
                          placeholder: (BuildContext loading, _) {
                            return const SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: Padding(
                                padding: EdgeInsets.all(30.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          imageBuilder: (BuildContext imgContext, ImageProvider imgProvider) {
                            return Container(
                              width: 180.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imgProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          errorWidget: (BuildContext errContext, _, __) {
                            return const SizedBox(
                              width: 150.0,
                              height: 150.0,
                              child: Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 60.0,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  CustomRoundedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Email:',
                          style: CustomTextStyle.comment(),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'email',
                          style: CustomTextStyle.title().copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomRoundedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Nama:',
                          style: CustomTextStyle.comment(),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'username',
                          style: CustomTextStyle.title().copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomRoundedCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Role:',
                          style: CustomTextStyle.comment(),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'role',
                          style: CustomTextStyle.title().copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
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