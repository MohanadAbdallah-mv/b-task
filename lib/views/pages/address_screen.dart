import 'package:blnk_task/providers/governorate_provider.dart';
import 'package:blnk_task/providers/user_provider.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:blnk_task/util/navigator_helper.dart';
import 'package:blnk_task/util/routes.dart';
import 'package:blnk_task/util/validator.dart';
import 'package:blnk_task/views/components/address/area_dropdown.dart';
import 'package:blnk_task/views/components/custom_button.dart';
import 'package:blnk_task/views/components/custom_textfield.dart';
import 'package:blnk_task/views/components/main_appBar.dart';
import 'package:blnk_task/views/components/progress_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/address/city_dropdown.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

late TextEditingController _apartmentController;
late TextEditingController _floorController;
late TextEditingController _buildingController;
late TextEditingController _streetNameController;
late TextEditingController _landMarkController;

late FocusNode floorFocusNode;
late FocusNode buildingFocusNode;
late FocusNode streetNameFocusNode;
late FocusNode landMarkFocusNode;

final formKey = GlobalKey<FormState>();
bool isActive = false;

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    super.initState();

    ///Text Controllers
    _apartmentController = TextEditingController();
    _floorController = TextEditingController();
    _buildingController = TextEditingController();
    _streetNameController = TextEditingController();
    _landMarkController = TextEditingController();

    ///Focus Nodes
    floorFocusNode = FocusNode();
    buildingFocusNode = FocusNode();
    streetNameFocusNode = FocusNode();
    landMarkFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GovernorateProvider>(context, listen: false).loadLocations();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _apartmentController.dispose();
    _floorController.dispose();
    _buildingController.dispose();
    _streetNameController.dispose();
    _landMarkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    GovernorateProvider governorateProvider =
        Provider.of<GovernorateProvider>(context);
    return Scaffold(
      appBar: const MainAppBar(
        isBack: true,
        title: "Create Account",
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 120, left: 65, right: 65),
        child: CustomButton(
          isActive: isActive,
          onTap: () {
            bool? valid = formKey.currentState?.validate();

            if (valid != null && valid == true) {
              userProvider.setAddress(
                _apartmentController.text,
                _floorController.text,
                _buildingController.text,
                _streetNameController.text,
                governorateProvider.selectedArea!.nameEn,
                governorateProvider.selectedGovernorate!.nameEn,
                _landMarkController.text,
              );
              PlatformNavigator.pushNamed(context, Routes.cameraScreen);
            } else {
              setState(() {
                isActive = false;
              });
            }
          },
          child: Text(
            "Next",
            style: AppTheme.activeProgress,
          ),
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
                index: 1,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 24),
                    child: CustomTextField(
                      labelText: 'Apartment',
                      validator: (value) {
                        return Validator.validateEmpty(
                            value ?? "", 'Apartment');
                      },
                      controller: _apartmentController,
                      onDone: () {
                        FocusScope.of(context).requestFocus(
                          floorFocusNode,
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: CustomTextField(
                      labelText: 'Floor',
                      validator: (value) {
                        return Validator.validateEmpty(value ?? "", 'Floor');
                      },
                      controller: _floorController,
                      focusNode: floorFocusNode,
                      onDone: () {
                        FocusScope.of(context).requestFocus(
                          buildingFocusNode,
                        );
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 24),
                    child: CustomTextField(
                      labelText: 'Building',
                      validator: (value) {
                        return Validator.validateEmpty(value ?? "", 'Building');
                      },
                      controller: _buildingController,
                      focusNode: buildingFocusNode,
                      onDone: () {
                        FocusScope.of(context).requestFocus(
                          streetNameFocusNode,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: CustomTextField(
                labelText: 'Street Name',
                validator: (value) {
                  return Validator.validateEmpty(value ?? "", 'Street Name');
                },
                controller: _streetNameController,
                focusNode: streetNameFocusNode,
                onDone: () {
                  FocusScope.of(context).requestFocus(
                    landMarkFocusNode,
                  );
                },
              ),
            ),
            Row(
              // mainAxisSize: MainAxisSize.max,
              children: [
                AreaDropdownWidget(
                  provider: governorateProvider,
                ),
                CityDropdownWidget(
                  provider: governorateProvider,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: CustomTextField(
                labelText: 'Land Mark',
                validator: (value) {
                  return Validator.validateEmpty(value ?? "", 'Land Mark');
                },
                controller: _landMarkController,
                focusNode: landMarkFocusNode,
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
