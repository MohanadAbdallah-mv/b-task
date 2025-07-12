import 'package:blnk_task/util/app_theme.dart';
import 'package:blnk_task/util/navigator_helper.dart';
import 'package:blnk_task/util/routes.dart';
import 'package:blnk_task/views/components/custom_button.dart';
import 'package:blnk_task/views/components/custom_textfield.dart';
import 'package:blnk_task/views/components/main_appBar.dart';
import 'package:blnk_task/views/components/progress_stepper.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        isBack: true,
        title: "Create Account",
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 164, left: 65, right: 65),
        child: CustomButton(
          child: Text(
            "Next",
            style: AppTheme.activeProgress,
          ),
          onTap: () {
            PlatformNavigator.pushNamed(context, Routes.personalInfoScreen);
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
              index: 1,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 24),
                  child: const CustomTextField(
                    labelText: 'Appartment',
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: const CustomTextField(
                    labelText: 'Floor',
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(right: 24),
                  child: const CustomTextField(
                    labelText: 'Building',
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: const CustomTextField(
              labelText: 'Street Name',
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 24, right: 10),
                  child: const CustomTextField(
                    labelText: 'Area',
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(right: 24),
                  child: const CustomTextField(
                    labelText: 'City',
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
            child: const CustomTextField(
              labelText: 'Land Mark',
            ),
          ),
        ]),
      ),
    );
  }
}
