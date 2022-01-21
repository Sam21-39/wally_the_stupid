import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Dashboard/home.dart';
import 'package:wally_the_stupid/Views/Dashboard/leaderboard.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final user = FirebaseAuth.instance.currentUser;
  int score = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getScores();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/wally.png',
          height: 50.0,
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: bottomBar(),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Column(
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
                            CupertinoIcons.star_fill,
                            color: UI.appIconColor,
                          ),
                          Text(
                            score.toString(),
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
            Container(
              height: size.height * 0.58,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: showContent(),
            ),
          ],
        ),
      ),
    );
  }

  void getScores() async {
    final res = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .where('uid', isEqualTo: user?.uid)
        .get();
    final data = res.docs.first.data();

    // print(data['score']);

    score = data['score'];
    setState(() {});
  }

  showContent() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return Container();
      case 2:
        return LeaderboardPage();
      case 3:
        return Container();
      case 4:
        return Container();
    }
    return Container();
  }

  bottomBar() => SalomonBottomBar(
        currentIndex: _currentIndex,
        margin: const EdgeInsets.all(8.0),
        selectedColorOpacity: 0.15,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 300),
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text("Home"),
            selectedColor: UI.appButtonColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.book),
            title: Text("Questions"),
            selectedColor: UI.appHighLightColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.leaderboard_outlined),
            title: Text("Leaderboard"),
            selectedColor: UI.appErrorColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            title: Text("Achivemnets"),
            selectedColor: UI.appButtonColor.withBlue(190),
          ),
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: Text("Settings"),
            selectedColor: UI.appIconColor,
          ),
        ],
      );
}