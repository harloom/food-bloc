import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final Widget iconWidget;

  final VoidCallback onTap;
  const AppBarButton({
    Key? key,
    required this.iconWidget,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.4),
          ),
          child: iconWidget),
    );
  }
}
