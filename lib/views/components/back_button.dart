import 'package:blnk_task/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: SvgPicture.asset(
        fit: BoxFit.scaleDown,
        AppConstants.backButton,
        matchTextDirection: true,
      ),
    );
  }
}
