import 'package:flutter/material.dart';
import 'package:flutter_english_card_app/values/app_assets.dart';
import 'package:flutter_english_card_app/values/app_colors.dart';
import 'package:flutter_english_card_app/values/app_styles.dart';
import 'package:flutter_english_card_app/values/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences pref;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    pref = await SharedPreferences.getInstance();
    int value = pref.getInt(ShareKey.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        leading: InkWell(
          onTap: (() async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.setInt(ShareKey.counter, sliderValue.toInt());
            Navigator.pop(context);
          }),
          child: Image.asset(AppAssets.leftArrow),
        ),
        title: Text(
          'Your control',
          style:
              AppStyles.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            Text(
              'How much a number word at once?',
              style: AppStyles.h4
                  .copyWith(fontSize: 18, color: AppColors.lightGrey),
            ),
            const Spacer(),
            Text(
              '${sliderValue.toInt()}',
              style: AppStyles.h1.copyWith(
                  fontSize: 150,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Slider(
                activeColor: AppColors.primaryColor,
                inactiveColor: AppColors.primaryColor,
                thumbColor: Colors.white,
                value: sliderValue,
                min: 5,
                max: 100,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                }),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Slide to set',
                style: AppStyles.h5.copyWith(color: AppColors.textColor),
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
