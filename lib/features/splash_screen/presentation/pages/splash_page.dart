import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ontime/core/style/app_colors.dart';
import 'package:ontime/generated/assets.gen.dart';

import '../controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Assets.images.logo.image(width: 800, height: 800)],
        ),
      ),
    );
  }
}
