import 'package:flutter/material.dart';
import 'package:flutter_english_card_app/models/english_today.dart';
import 'package:flutter_english_card_app/values/app_assets.dart';
import 'package:flutter_english_card_app/values/app_colors.dart';
import 'package:flutter_english_card_app/values/app_styles.dart';

class AllwordsPage extends StatelessWidget {
  final List<Englishtoday> wordsList;

  const AllwordsPage({Key? key, required this.wordsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondColor,
        appBar: AppBar(
          backgroundColor: AppColors.secondColor,
          elevation: 0,
          leading: InkWell(
            onTap: (() {
              Navigator.pop(context);
            }),
            child: Image.asset(AppAssets.leftArrow),
          ),
          title: Text(
            'English today',
            style:
                AppStyles.h3.copyWith(color: AppColors.textColor, fontSize: 36),
          ),
        ),
        body: ListView.builder(
            itemCount: wordsList.length,
            itemBuilder: ((context, index) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: (index % 2) == 0
                        ? AppColors.primaryColor
                        : AppColors.secondColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    wordsList[index].noun!,
                    style: index % 2 == 0
                        ? AppStyles.h4
                        : AppStyles.h4.copyWith(color: AppColors.textColor),
                  ),
                  subtitle: Text(wordsList[index].quote ??
                      'Think of all the beauty still left around you and be happy.'),
                  leading: Icon(
                    Icons.favorite,
                    color: wordsList[index].isFavorite
                        ? Colors.orange
                        : Colors.grey,
                  ),
                ),
              );
            })));
  }
}
