import 'package:blnk_task/util/app_colors.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class ProgressStepper extends StatelessWidget {
  const ProgressStepper({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
        activeStep: index,
        lineStyle: const LineStyle(
          lineLength: 87,
          lineType: LineType.normal,
          lineThickness: 2,
          defaultLineColor: AppColors.inactiveProgressIndicatorColor,
          unreachedLineColor: AppColors.inactiveProgressIndicatorColor,
          finishedLineColor: AppColors.activeProgressIndicatorColor,
        ),
        defaultStepBorderType: BorderType.normal,
        unreachedStepBorderType: BorderType.normal,
        activeStepBackgroundColor: AppColors.activeProgressIndicatorColor,
        activeStepBorderColor: AppColors.activeProgressIndicatorColor,
        finishedStepBackgroundColor: AppColors.activeProgressIndicatorColor,
        unreachedStepBackgroundColor: Colors.white,
        unreachedStepBorderColor: AppColors.inactiveProgressIndicatorColor,
        finishedStepBorderColor: AppColors.activeProgressIndicatorColor,
        internalPadding: 0,
        showLoadingAnimation: false,
        stepRadius: 15, //15
        showStepBorder: true,
        enableStepTapping: false,
        steps: [
          EasyStep(
            customStep: Text(
              "1",
              style: index >= 0
                  ? AppTheme.activeProgress
                  : AppTheme.inactiveProgress,
            ),
          ),
          EasyStep(
            customStep: Text(
              "2",
              style: index >= 1
                  ? AppTheme.activeProgress
                  : AppTheme.inactiveProgress,
            ),
          ),
          EasyStep(
            customStep: Text(
              "3",
              style: index >= 2
                  ? AppTheme.activeProgress
                  : AppTheme.inactiveProgress,
            ),
          )
        ]);
  }
}
