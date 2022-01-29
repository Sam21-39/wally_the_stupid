import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wally_the_stupid/Ads/Adhelper.dart';
import 'package:wally_the_stupid/Model/challenge.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/TapPage/tap.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BannerAd _bannerAd;

  bool isBannerAdReady = false;
  final user = FirebaseAuth.instance.currentUser;
  num time = 0;
  // final db = DataHandler.dataInstance;
  @override
  void initState() {
    super.initState();

    getTimeFromLeaderBoard();
    // getTestData();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          isBannerAdReady = false;
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
        children: [
          Expanded(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    CupertinoIcons.timer,
                                    color: UI.appIconColor,
                                  ),
                                  Text(
                                    '$time sec',
                                    style: UI.appText.copyWith(fontSize: 20),
                                    softWrap: true,
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
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        UI.appHighLightColor),
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
                    Container(
                      // color: UI.appButtonColor.withOpacity(0.25),
                      height: size.height * 0.55,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Challenges')
                            .orderBy(
                              'timestamp',
                              descending: true,
                            )
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data.docs;
                            //print(data[0]['prompt']);

                            final List<Challenge> dataList = [];
                            data.forEach((e) {
                              if (e['isActive']) {
                                var challenge = Challenge();
                                challenge.qid = e.id;
                                challenge.prompt = e['prompt'];
                                challenge.answer = e['answer'];
                                challenge.isActive = e['isActive'];
                                challenge.start = e['start'];
                                challenge.timestamp = e['timestamp'];
                                dataList.add(challenge);
                              }
                            });
                            return ListView.builder(
                              itemCount: dataList.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => TapPage(
                                        challenge: dataList[index],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          spreadRadius: 2.5,
                                          color: Colors.black12,
                                          offset: Offset(0.9, 0.9),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: UI.appButtonColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '${index + 1}.',
                                          style: UI.appText,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.6,
                                          child: Text(
                                            dataList[index].prompt!,
                                            style: UI.appText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          isBannerAdReady
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  getTimeFromLeaderBoard() async {
    final data = await FirebaseFirestore.instance
        .collection("Leaderboard")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    final lead = (data.data() as Map)['time'];

    //print((lead as Map)['time']);
    if (lead != 9999999) time = lead;
    setState(() {});
  }

  // getTestData() async {
  //   final data = await db.getBestTime();
  //   print('test data --> $data');
  // }
}
