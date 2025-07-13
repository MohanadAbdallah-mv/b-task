import 'package:blnk_task/models/address/area.dart';
import 'package:blnk_task/providers/governorate_provider.dart';
import 'package:blnk_task/util/app_colors.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:flutter/material.dart';

class AreaDropdownWidget extends StatelessWidget {
  const AreaDropdownWidget({super.key, required this.provider});
  final GovernorateProvider provider;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.only(left: 24, right: 10),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.textFieldBorderColor,
          ),
          child: DropdownButtonFormField<Area>(
            decoration: InputDecoration(
              labelText: 'Area',
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
            // Set the value to the currently selected area from the provider
            value: provider.selectedArea,
            items: provider.filteredAreas.map((area) {
              return DropdownMenuItem<Area>(
                value: area,
                child: SizedBox(
                  width: 100,
                  child: Text(
                    area.nameEn,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.normalText
                        .copyWith(color: AppColors.appBarTitleColor),
                  ),
                ),
              );
            }).toList(),

            onChanged: provider.filteredAreas.isEmpty
                ? null // Disable if no filtered areas
                : (Area? newValue) {
                    provider.setSelectedArea(newValue);
                  },
            hint: Text(
              'Choose an Area',
              style: AppTheme.textFieldTitle,
            ),
            isExpanded: true,

            // alignment: ,
            // padding: ,
            //
          ),
        ),
      ),
    );
  }
}
