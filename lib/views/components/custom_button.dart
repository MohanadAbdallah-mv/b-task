import 'package:blnk_task/util/app_colors.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key, this.isActive = true, required this.child, this.onTap});
  final VoidCallback? onTap;
  final Widget child;
  final bool isActive;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isActive ? widget.onTap : null,
      child: Container(
        width: 261,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.activeButtonColor
                : AppColors.inactiveButtonColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
                // blurStyle: BlurStyle.outer,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: widget.child,
      ),
    );
  }
}
