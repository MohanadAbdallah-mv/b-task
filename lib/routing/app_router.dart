import 'package:blnk_task/util/routes.dart';
import 'package:blnk_task/views/pages/address_screen.dart';
import 'package:blnk_task/views/pages/camera/back_camera_screen.dart';
import 'package:blnk_task/views/pages/camera/front_camera_screen.dart';
import 'package:blnk_task/views/pages/camera/photo_preview_screen.dart';
import 'package:blnk_task/views/pages/confirm_screen.dart';
import 'package:blnk_task/views/pages/personal_info.dart';
import 'package:blnk_task/views/pages/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../views/pages/splash_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    PageRoute<T> buildPlatformPageRoute<T extends Object?>(
        WidgetBuilder builder, RouteSettings settings) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return CupertinoPageRoute<T>(builder: builder, settings: settings);
      } else {
        return MaterialPageRoute<T>(builder: builder, settings: settings);
      }
    }

    switch (settings.name) {
      case Routes.splashScreen:
        return buildPlatformPageRoute(
            (context) => const SplashScreen(), settings);

      case Routes.personalInfoScreen:
        return buildPlatformPageRoute(
            (context) => const PersonalInfoScreen(), settings);
      case Routes.addressScreen:
        return buildPlatformPageRoute(
            (context) => const AddressScreen(), settings);
      case Routes.frontCameraScreen:
        return buildPlatformPageRoute(
            (context) => const FrontCameraScreen(), settings);
      case Routes.backCameraScreen:
        return buildPlatformPageRoute(
            (context) => const BackCameraScreen(), settings);
      case Routes.photoPreviewScreen:
        return buildPlatformPageRoute(
            (context) => const PhotoPreviewScreen(), settings);

      case Routes.confirmScreen:
        return buildPlatformPageRoute(
            (context) => const ConfirmScreen(), settings);
      case Routes.registerScreen:
        return buildPlatformPageRoute(
            (context) => const RegisterScreen(), settings);

      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
