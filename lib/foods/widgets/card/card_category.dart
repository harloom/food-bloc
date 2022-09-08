import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool? isSelected;
  const CardCategory({
    Key? key,
    required this.label,
    required this.onTap,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isSelected == true ? Colors.amber : Theme.of(context).cardColor,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Center(
                child: Text(
              StringUtils.capitalize(label),
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold),
            ))),
      ),
    );
  }
}
