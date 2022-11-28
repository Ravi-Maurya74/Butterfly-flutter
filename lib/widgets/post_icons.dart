import 'package:flutter/material.dart';

class PostIcon extends StatelessWidget {
  PostIcon({required this.iconData, required this.onClick, super.key});
  VoidCallback onClick;
  IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        child: Icon(
          iconData,
          size: 30,
        ),
        onTap: () {
          onClick();
        },
      ),
    );
  }
}
