import 'package:blnk_task/models/address/area.dart';
import 'package:blnk_task/models/address/governorate.dart';
import 'package:blnk_task/providers/governorate_provider.dart';
import 'package:blnk_task/providers/user_provider.dart';
import 'package:blnk_task/util/app_constants.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:blnk_task/util/routes.dart';
import 'package:blnk_task/views/components/custom_button.dart';
import 'package:blnk_task/views/components/main_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 120, left: 65, right: 65),
        child: CustomButton(
          onTap: () {
            Provider.of<UserProvider>(context, listen: false).clean();
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.personalInfoScreen,
              (Route<dynamic> route) => false,
            );
          },
          child: Text(
            "Register another user",
            style: AppTheme.activeProgress,
          ),
        ),
      ),
      body: PopScope(
        canPop: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 115,
              width: 115,
              margin: const EdgeInsets.only(top: 80),
              child: SvgPicture.asset(
                AppConstants.registered,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "Registration Complete",
                style: AppTheme.bold24Black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35, left: 25, right: 25),
              child: Text(
                "Congratulations! You have successfully completed the registration process. Your profile is now set up, and now you can start exploring all  features and benefits we offer",
                style: AppTheme.normalText,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
