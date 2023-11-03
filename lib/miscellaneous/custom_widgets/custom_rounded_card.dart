import 'package:flutter/material.dart';

class CustomRoundedCard extends StatelessWidget {
  final Widget child;
  final Color? cardColor;
  final Function? onPressed;
  final Function? onLongPressed;

  const CustomRoundedCard({
    super.key,
    required this.child,
    this.cardColor,
    this.onPressed,
    this.onLongPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: cardColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        onTap: () => onPressed != null ? onPressed!() : null,
        onLongPress: () => onLongPressed != null ? onLongPressed!() : null,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: child,
        ),
      ),
    );
  }
}