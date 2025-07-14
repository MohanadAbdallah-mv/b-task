import 'dart:developer';
import 'dart:io';

import 'package:blnk_task/models/user.dart';
import 'package:blnk_task/providers/google_provider.dart';
import 'package:blnk_task/providers/user_provider.dart';
import 'package:blnk_task/util/app_constants.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:blnk_task/util/navigator_helper.dart';
import 'package:blnk_task/util/routes.dart';
import 'package:blnk_task/views/components/custom_button.dart';
import 'package:blnk_task/views/components/custom_textfield.dart';
import 'package:blnk_task/views/components/main_appBar.dart';
import 'package:blnk_task/views/components/progress_stepper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    User user = Provider.of<UserProvider>(context, listen: false).currentUser!;
    return Scaffold(
      appBar: const MainAppBar(
        isBack: true,
        title: "Create Account",
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 70,
            width: double.maxFinite,
            child: const ProgressStepper(
              index: 2,
            ),
          ),

          ///FullName
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppConstants.fullName),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "FULL NAME",
                      style: AppTheme.viewTextFieldTitle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  labelText: '',
                  maxLines: 1,
                  initialValue: "${user.firstName} ${user.lastName}",
                  enabled: false,
                  confirmUI: true,
                  onDone: () {},
                ),
              ],
            ),
          ),

          ///phone numbers
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppConstants.phone),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "PHONE NUMBERS",
                      style: AppTheme.viewTextFieldTitle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  labelText: '',
                  maxLines: 1,
                  initialValue: user.mobileNumber,
                  enabled: false,
                  confirmUI: true,
                  onDone: () {},
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  labelText: '',
                  maxLines: 1,
                  initialValue: user.landLine,
                  enabled: false,
                  confirmUI: true,
                  onDone: () {},
                )
              ],
            ),
          ),

          ///Email Address
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppConstants.email),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "EMAIL ADDRESS",
                      style: AppTheme.viewTextFieldTitle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  labelText: '',
                  maxLines: 1,
                  initialValue: user.email,
                  enabled: false,
                  confirmUI: true,
                  onDone: () {},
                ),
              ],
            ),
          ),

          ///Home Address
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppConstants.address),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "HOME ADDRESS",
                      style: AppTheme.viewTextFieldTitle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  labelText: '',
                  maxLines: 2,
                  initialValue: user.address?.fullAddressString,
                  enabled: false,
                  confirmUI: true,
                  onDone: () {},
                ),
              ],
            ),
          ),

          ///National id
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppConstants.id),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "NATIONAL ID",
                      style: AppTheme.viewTextFieldTitle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  labelText: '',
                  maxLines: 1,
                  initialValue: "Front id",
                  enabled: false,
                  isID: true,
                  confirmUI: true,
                  onDone: null,
                  onTap: () async {
                    log("message");
                    try {
                      BotToast.showLoading();
                      log(user.frontIDURL.toString());
                      final doc =
                          await PDFDocument.fromFile(File(user.frontIDURL!));
                      BotToast.closeAllLoading();
                      PlatformNavigator.pushNamed(
                          context, Routes.photoPreviewScreen,
                          options: {"doc": doc});
                    } catch (e) {
                      log(e.toString());
                      BotToast.closeAllLoading();
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  labelText: '',
                  maxLines: 1,
                  initialValue: "Back id",
                  enabled: false,
                  isID: true,
                  confirmUI: true,
                  onTap: () async {
                    log("message");
                    try {
                      BotToast.showLoading();
                      log(user.backIDURL.toString());
                      final doc =
                          await PDFDocument.fromFile(File(user.backIDURL!));
                      BotToast.closeAllLoading();
                      PlatformNavigator.pushNamed(
                          context, Routes.photoPreviewScreen,
                          options: {"doc": doc});
                    } catch (e) {
                      log(e.toString());
                      BotToast.closeAllLoading();
                    }
                  },
                  onDone: () {},
                )
              ],
            ),
          ),

          ///submit button
          Padding(
            padding: const EdgeInsets.only(bottom: 50, left: 65, right: 65),
            child: CustomButton(
              onTap: () async {
                //todo uncomment this after adding the google service credentials
                // await Provider.of<GoogleProvider>(context, listen: false)
                //     .submitDataToGoogle(user);
                PlatformNavigator.pushNamed(context, Routes.registerScreen);
              },
              child: Text(
                "Submit",
                style: AppTheme.activeProgress,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
