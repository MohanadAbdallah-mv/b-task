import 'package:blnk_task/providers/user_provider.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:blnk_task/util/navigator_helper.dart';
import 'package:blnk_task/util/routes.dart';
import 'package:blnk_task/util/validator.dart';
import 'package:blnk_task/views/components/custom_button.dart';
import 'package:blnk_task/views/components/custom_textfield.dart';
import 'package:blnk_task/views/components/main_appBar.dart';
import 'package:blnk_task/views/components/progress_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _mobileNumberController;
  late final TextEditingController _landLineController;
  late final TextEditingController _emailController;

  late FocusNode lastNameFocusNode;
  late FocusNode mobileNumberFocusNode;
  late FocusNode landLineFocusNode;
  late FocusNode emailFocusNode;

  final formKey = GlobalKey<FormState>();
  bool isActive = false;
  @override
  void initState() {
    ///Text Controllers
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _landLineController = TextEditingController();
    _emailController = TextEditingController();

    ///Focus Nodes
    lastNameFocusNode = FocusNode();
    mobileNumberFocusNode = FocusNode();
    landLineFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    _landLineController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: const MainAppBar(
        title: "Create Account",
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 120, left: 65, right: 65),
        child: CustomButton(
          isActive: isActive,
          child: Text(
            "Next",
            style: AppTheme.activeProgress,
          ),
          onTap: () {
            bool? valid = formKey.currentState?.validate();

            if (valid != null && valid == true) {
              userProvider.setUser(
                _firstNameController.text,
                _lastNameController.text,
                _mobileNumberController.text,
                _landLineController.text,
                _emailController.text,
              );
              PlatformNavigator.pushNamed(context, Routes.addressScreen);
            } else {
              setState(() {
                isActive = false;
              });
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: CustomTextField(
                controller: _firstNameController,
                labelText: 'First Name',
                validator: (value) {
                  return Validator.validateEmpty(value ?? "", 'First Name');
                },
                onDone: () {
                  FocusScope.of(context).requestFocus(
                    lastNameFocusNode,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: CustomTextField(
                labelText: 'Last Name',
                validator: (value) {
                  return Validator.validateEmpty(value ?? "", 'Last Name');
                },
                controller: _lastNameController,
                focusNode: lastNameFocusNode,
                onDone: () {
                  FocusScope.of(context).requestFocus(
                    mobileNumberFocusNode,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: CustomTextField(
                labelText: 'Mobile Number',
                validator: (value) {
                  return Validator.validateEmpty(value ?? "", 'Mobile Number');
                },
                controller: _mobileNumberController,
                focusNode: mobileNumberFocusNode,
                keyboardType: TextInputType.phone,
                onDone: () {
                  FocusScope.of(context).requestFocus(
                    landLineFocusNode,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: CustomTextField(
                labelText: 'Landline',
                validator: (value) {
                  return Validator.validateEmpty(value ?? "", 'Landline');
                },
                controller: _landLineController,
                keyboardType: TextInputType.phone,
                focusNode: landLineFocusNode,
                onDone: () {
                  FocusScope.of(context).requestFocus(
                    emailFocusNode,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: CustomTextField(
                labelText: 'Email',
                validator: (value) {
                  return Validator.validateEmpty(value ?? "", 'Email');
                },
                controller: _emailController,
                focusNode: emailFocusNode,
                onDone: () {
                  bool? valid = formKey.currentState?.validate();
                  if (valid != null && valid == true) {
                    setState(() {
                      isActive = true;
                    });
                  } else {
                    setState(() {
                      isActive = false;
                    });
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
