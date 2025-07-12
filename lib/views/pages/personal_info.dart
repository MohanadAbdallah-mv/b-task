import 'package:blnk_task/util/app_colors.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:blnk_task/util/navigator_helper.dart';
import 'package:blnk_task/util/routes.dart';
import 'package:blnk_task/views/components/custom_button.dart';
import 'package:blnk_task/views/components/custom_textfield.dart';
import 'package:blnk_task/views/components/main_appBar.dart';
import 'package:blnk_task/views/components/progress_stepper.dart';
import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: "Create Account",
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 70, left: 65, right: 65),
        child: CustomButton(
          child: Text(
            "Next",
            style: AppTheme.activeProgress,
          ),
          onTap: () {
            PlatformNavigator.pushNamed(context, Routes.addressScreen);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 70,
            width: double.maxFinite,
            child: const ProgressStepper(
              index: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "Welcome! Let's get started by gathering some basic information about you. Please fill out the following fields",
              style: AppTheme.normalText.copyWith(fontSize: 13),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: const CustomTextField(
              labelText: 'First Name',
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: const CustomTextField(
              labelText: 'Last Name',
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: const CustomTextField(
              labelText: 'Mobile Number',
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: const CustomTextField(
              labelText: 'Landline',
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: const CustomTextField(
              labelText: 'Email',
            ),
          ),
        ]),
      ),
    );
  }
}
