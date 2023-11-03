import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:east_personalia/miscellaneous/custom_widgets/custom_app_bar.dart';
import 'package:east_personalia/view_pages/management_page/master_data_page/master_company_view_page.dart';
import 'package:east_personalia/view_pages/management_page/master_data_page/master_user_view_page.dart';
import 'package:flutter/material.dart';

class MasterDataViewPage extends StatefulWidget {
  const MasterDataViewPage({super.key});

  @override
  State<MasterDataViewPage> createState() => _MasterDataViewPageState();
}

class _MasterDataViewPageState extends State<MasterDataViewPage> {
  List<Map<String, Function>> masterDataMenuList = [
    {
      'Master User': (BuildContext context) => MoveTo(context: context, target: const MasterUserViewPage()).go(),
    },
    {
      'Master Perusahaan': (BuildContext context) => MoveTo(context: context, target: const MasterCompanyViewPage()).go(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppBar(
              title: 'Master Data',
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(10.0),
                itemCount: masterDataMenuList.length,
                separatorBuilder: (BuildContext separatorContext, int separatorIndex) {
                  return const SizedBox(
                    height: 5.0,
                  );
                },
                itemBuilder: (BuildContext menuListContext, int menuListIndex) {
                  return ElevatedButton(
                    onPressed: () => masterDataMenuList[menuListIndex].values.first(context),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              masterDataMenuList[menuListIndex].keys.first,
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