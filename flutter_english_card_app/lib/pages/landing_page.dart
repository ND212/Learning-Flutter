import 'package:flutter/material.dart';
import 'package:flutter_english_card_app/pages/home_page.dart';
import 'package:flutter_english_card_app/values/app_assets.dart';
import 'package:flutter_english_card_app/values/app_colors.dart';
import 'package:flutter_english_card_app/values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Welcome to',
                  style: AppStyles.h3,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'English',
                    style: AppStyles.h2.copyWith(
                        color: AppColors.blackGrey,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      'Quotes"',
                      style: AppStyles.h4.copyWith(height: 0.5),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 85),
                child: RawMaterialButton(
                    fillColor: AppColors.lightBlue,
                    shape: const CircleBorder(),
                    child: Image.asset(AppAssets.leftArrow),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
