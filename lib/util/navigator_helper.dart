import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformNavigator {
  static Future<T?> push<T extends Object?>(
      BuildContext context, Widget screen) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
    } else {
      return Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => screen,
        ),
      );
    }
  }

  static Future<T?> pushNamed<T extends Object?>(
      BuildContext context, String screenName,
      {Map<String, dynamic>? options}) {
    return Navigator.pushNamed(context, screenName, arguments: options);
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context);
  }
}
