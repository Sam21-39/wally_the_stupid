import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wally_the_stupid/Auth/auth.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Authentication/login.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: bottomBar(),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: showContent(),
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
        return Container(
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                final auth = Auth.instance;
                auth.signOut();
                final sp = await SharedPreferences.getInstance();
                sp.setBool('isLogged', false);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text('Sign Out'),
            ),
          ),
        );
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
