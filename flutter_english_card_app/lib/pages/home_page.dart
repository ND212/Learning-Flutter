// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_english_card_app/models/english_today.dart';
import 'package:flutter_english_card_app/packages/quote/quote.dart';
import 'package:flutter_english_card_app/pages/all_words_page.dart';
import 'package:flutter_english_card_app/pages/control_page.dart';
import 'package:flutter_english_card_app/values/app_assets.dart';
import 'package:flutter_english_card_app/values/app_colors.dart';
import 'package:flutter_english_card_app/values/app_styles.dart';
import 'package:flutter_english_card_app/values/share_keys.dart';
import 'package:flutter_english_card_app/widget/app_button.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../packages/quote/qoute_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;

  List<Englishtoday> words = [];

  String quote = Quotes().getRandom().content!;

  //ham lay random
  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }

    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishtoday() async {
    List<String> newList = [];
    // print('before');
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print('after');
    int _len = pref.getInt(ShareKey.counter) ?? 5;
    List<int> rans = fixedListRandom(len: _len, max: nouns.length);
    for (var element in rans) {
      newList.add(nouns[element]);
    }

    setState(() {
      words = newList.map((e) => getQuotes(e)).toList();
    });

    // print('data');
  }

  Englishtoday getQuotes(String noun) {
    Quote? quote = Quotes().getByWord(noun);
    return Englishtoday(noun: noun, quote: quote?.content, id: quote?.id);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishtoday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        leading: InkWell(
          onTap: (() {
            _scaffoldKey.currentState?.openDrawer();
          }),
          child: Image.asset(AppAssets.menu),
        ),
        title: Text(
          'English today',
          style:
              AppStyles.h3.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: size.height * 0.1,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                '“$quote”',
                style: AppStyles.h5
                    .copyWith(fontSize: 12, color: AppColors.textColor),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              height: size.height * 65 / 100,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length > 5 ? 6 : words.length,
                  itemBuilder: (context, index) {
                    String firstLetter =
                        words[index].noun != null ? words[index].noun! : '';
                    firstLetter = firstLetter.substring(0, 1);

                    String rightLetter =
                        words[index].noun != null ? words[index].noun! : '';
                    rightLetter = rightLetter.substring(1, rightLetter.length);

                    String quoteDefault =
                        'Think of all the beauty still left around you and be happy.';

                    String quote = words[index].quote ?? quoteDefault;

                    return Padding(
                      padding: const EdgeInsets.all(6),
                      child: Material(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.primaryColor,
                        elevation: 4,
                        child: InkWell(
                          onDoubleTap: () {
                            setState(() {
                              words[index].isFavorite =
                                  !words[index].isFavorite;
                            });
                          },
                          splashColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                              padding: const EdgeInsets.all(18),
                              child: _currentIndex >= 5
                                  ? buildShowmore()
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LikeButton(
                                          onTap: (isLiked) async {
                                            setState(() {
                                              words[index].isFavorite =
                                                  !words[index].isFavorite;
                                            });
                                            return words[index].isFavorite;
                                          },
                                          isLiked: words[index].isFavorite,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          size: 42,
                                          circleColor: CircleColor(
                                              start: Color(0xff00ddff),
                                              end: Color(0xff0099cc)),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Color(0xff33b5e5),
                                            dotSecondaryColor:
                                                Color(0xff0099cc),
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            // return Icon(
                                            //   Icons.favorite,
                                            //   color: isLiked
                                            //       ? Colors.deepPurpleAccent
                                            //       : Colors.grey,
                                            //   size: 42,
                                            // );
                                            return ImageIcon(
                                              AssetImage(AppAssets.heart),
                                              color: isLiked
                                                  ? Colors.orange
                                                  : Colors.grey,
                                              size: 42,
                                            );
                                          },
                                        ),
                                        // Container(
                                        //   child: Image.asset(AppAssets.heart,
                                        //       color: words[index].isFavorite
                                        //           ? Colors.orange
                                        //           : Colors.white),
                                        //   alignment: Alignment.centerRight,
                                        // ),
                                        RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          text: TextSpan(
                                              text: firstLetter.toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 92,
                                                  fontFamily: FontFamily.sen,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    BoxShadow(
                                                        color: Colors.black38,
                                                        offset: Offset(3, 6),
                                                        blurRadius: 6)
                                                  ]),
                                              children: [
                                                TextSpan(
                                                  text: rightLetter,
                                                  style: TextStyle(
                                                      fontSize: 64,
                                                      fontFamily:
                                                          FontFamily.sen,
                                                      shadows: [BoxShadow()]),
                                                )
                                              ]),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 24),
                                            child: AutoSizeText(
                                              '"$quote"',
                                              overflow: TextOverflow.ellipsis,
                                              maxFontSize: 26,
                                              style: AppStyles.h3.copyWith(
                                                letterSpacing: 1.8,
                                                color: AppColors.textColor,
                                              ),
                                            ))
                                      ],
                                    )),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              height: 12,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return buildIndicator(index == _currentIndex, size);
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          setState(() {
            getEnglishtoday();
          });
        },
        child: Image.asset(AppAssets.exchange),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 34, left: 24),
                child: Text(
                  'Your mind',
                  style: AppStyles.h3.copyWith(color: AppColors.textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(
                    label: 'Favorites',
                    onTap: () {
                      // print('Favorites');
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(
                    label: 'Your control',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ControlPage()));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: Duration(microseconds: 300),
      curve: Curves.easeIn,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 12,
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColors.lightBlue : AppColors.lightGrey,
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ],
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }

  Widget buildShowmore() {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: (() {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => AllwordsPage(wordsList: words)));
      }),
      child: Container(
        color: AppColors.primaryColor,
        alignment: Alignment.center,
        child: Text(
          'Show more...',
          style: AppStyles.h3.copyWith(shadows: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(3, 6),
              blurRadius: 6,
            )
          ]),
        ),
      ),
    );
  }
}
