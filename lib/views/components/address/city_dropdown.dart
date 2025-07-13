import 'package:blnk_task/models/address/governorate.dart';
import 'package:blnk_task/providers/governorate_provider.dart';
import 'package:blnk_task/util/app_colors.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:flutter/material.dart';

class CityDropdownWidget extends StatelessWidget {
  const CityDropdownWidget({super.key, required this.provider});
  final GovernorateProvider provider;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.only(right: 24),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.textFieldBorderColor,
          ),
          child: DropdownButtonFormField<Governorate>(
            decoration: InputDecoration(
              labelText: 'City',
              labelStyle: AppTheme.textFieldTitle,
              hintStyle: AppTheme.textFieldTitle,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      6.0), // Rounded corners for the border
                  borderSide: const BorderSide(
                    color: AppColors.textFieldBorderColor, // Grey border color
                    width: 1,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      6.0), // Rounded corners for the border
                  borderSide: const BorderSide(
                    color: AppColors.textFieldBorderColor, // Grey border color
                    width: 1,
                  )),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      6.0), // Rounded corners for the border
                  borderSide: const BorderSide(
                    color: Colors.red, // Grey border color
                    width: 1.0,
                  )),
            ),
            value: provider.selectedGovernorate,
            items: provider.governorates.map((gov) {
              return DropdownMenuItem<Governorate>(
                value: gov,
                child: SizedBox(
                  width: 100,
                  child: Text(
                    gov.nameEn,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.textFieldTitle,
                  ),
                ),
              );
            }).toList(),
            onChanged: (Governorate? newValue) {
              provider.setSelectedGovernorate(newValue);
            },
            isExpanded: true,
            hint: const Text('Choose a Governorate'),
          ),
        ),
      ),
    );
  }
}
