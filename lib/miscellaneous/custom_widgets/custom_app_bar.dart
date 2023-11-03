import 'package:east_personalia/miscellaneous/custom_app_styles/custom_text_style.dart';
import 'package:east_personalia/miscellaneous/custom_route/route_functions.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function? onBackPressed;
  final List<Widget>? action;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if(onBackPressed != null) {
                onBackPressed!();
              } else {
                CloseBack(context: context).go();
              }
            },
            customBorder: const CircleBorder(),
            child: const Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.arrow_back,
                  size: 30.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Text(
              title,
              style: CustomTextStyle.title(),
            ),
          ),
          action != null ?
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: action!,
          ) :
          const Material(),
        ],
      ),
    );
  }
}