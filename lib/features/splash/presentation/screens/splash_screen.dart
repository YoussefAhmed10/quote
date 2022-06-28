import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qoutes/config/routes/app_routes.dart';
import 'package:qoutes/core/utils/assets_manger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  _goNext() => Navigator.pushReplacementNamed(context, Routes.randomQuoteRoute);
  _startDelay() {
    timer = Timer(const Duration(seconds: 2), () => _goNext());
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImageAssets.quote),
      ),
    );
  }
}
