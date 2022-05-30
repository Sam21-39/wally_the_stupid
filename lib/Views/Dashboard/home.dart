import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wally_the_stupid/Ads/Adhelper.dart';
import 'package:wally_the_stupid/Database/dataHandler.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Dashboard/challenge_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerAd _bannerAd;

  var isBannerAdReady = false.obs;
  final user = FirebaseAuth.instance.currentUser;
  var time = 0.obs;
  // final db = DataHandler.dataInstance;
  @override
  void initState() {
    super.initState();

    getTimeFromLeaderBoard();
    //getTestData();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          isBannerAdReady.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          isBannerAdReady.value = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Column(
            children: [
              Divider(
                color: UI.appHighLightColor,
                thickness: 2.0,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: UI.appButtonColor,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 2,
                          offset: Offset(0.9, 0.1),
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          user?.displayName ?? '',
                          style: UI.appText.copyWith(fontSize: 22),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              CupertinoIcons.timer,
                              color: UI.appIconColor,
                            ),
                            Obx(
                              () => Text(
                                '$time sec',
                                style: UI.appText.copyWith(fontSize: 20),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 60.0,
                    backgroundColor: UI.appButtonColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        user?.photoURL ?? '',
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(UI.appHighLightColor),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Divider(
                color: UI.appHighLightColor,
                thickness: 2.0,
              ),
            ],
          ),
          Container(
            height: size.height * 0.58,
            // color: Colors.amber,

            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(
                      () => ChallengePage(
                        category: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/number.png'),
                        SizedBox(width: size.width * 0.02),
                        SizedBox(
                          width: size.width * 0.55,
                          child: Text(
                            'Numerical Challenges',
                            style: UI.appText,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(
                      () => ChallengePage(
                        category: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/alphabet.png'),
                        SizedBox(width: size.width * 0.02),
                        SizedBox(
                          width: size.width * 0.55,
                          child: Text(
                            'Alphabetical Challenges',
                            style: UI.appText,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => isBannerAdReady.value
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  getTimeFromLeaderBoard() async {
    final lead = await DataHandler.dataInstance.getBestTime();
    //print((lead as Map)['time']);
    if (lead != 9999999) time.value = lead;
  }

  // getTestData() async {
  //   final data = await db.getBestTime();
  //   print('test data --> $data');
  // }
}
