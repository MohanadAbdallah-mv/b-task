import 'dart:async';

import 'package:blnk_task/util/app_theme.dart';
import 'package:blnk_task/util/navigator_helper.dart';
import 'package:blnk_task/util/routes.dart';
import 'package:blnk_task/views/pages/personal_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      PlatformNavigator.pushNamed(context, Routes.personalInfoScreen);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // Added const for performance
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/png/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              left: 41,
              top: 231,
              bottom: 352,
              right: 41,
              child: Container(
                decoration: const BoxDecoration(
                  // Added const
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage("assets/png/logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 136.0,
              left: 145,
              child: Text(
                "Company Name © 2024",
                style: AppTheme.bold13Black,
                // textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
