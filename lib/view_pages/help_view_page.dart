import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HelpViewPage extends StatefulWidget {
  const HelpViewPage({super.key});

  @override
  State<HelpViewPage> createState() => _HelpViewPageState();
}

class _HelpViewPageState extends State<HelpViewPage> {
  List<Map<String, Function>> helpMenuList = [
    {
      'Pertanyaan yang paling sering ditanyakan (FAQ)': () {},
    },
    {
      'Hubungi pengembang aplikasi': () {},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Pusat Bantuan',
            ),
            Expanded(
              child: ListView.separated(
                itemCount: helpMenuList.length,
                separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.black54,
                      thickness: 1.0,
                      height: 0.0,
                    ),
                  );
                },
                itemBuilder: (BuildContext menuListContext, int menuListIndex) {
                  return InkWell(
                    onTap: () => helpMenuList[menuListIndex].values.first(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              helpMenuList[menuListIndex].keys.first,
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
            ),
          ],
        ),
      ),
    );
  }
}