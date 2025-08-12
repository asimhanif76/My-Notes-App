import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget? widget;
  final Color color;
  final VoidCallback onTap;

  MyButton({
    super.key,
    required this.widget,
    this.color = Colors.black,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(width * 0.05),
        child: Ink(
          height: width * 0.14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(width * 0.05),
          ),
          child: Center(
            child: widget
          ),
        ),
      ),
    );
  }
}
