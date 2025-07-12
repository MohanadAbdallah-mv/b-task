import 'package:flutter/material.dart';

import '../../util/app_theme.dart';
import 'back_button.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    required this.title,
    this.isBack = false,
    this.textStyle,
    this.actions,
    super.key,
  });

  final String title;
  final bool isBack;
  final TextStyle? textStyle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: isBack,
      elevation: 0,
      leading: isBack ? const PopButton() : null,
      actions: actions,
      title: Text(
        title,
        style: AppTheme.bold24Black,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
