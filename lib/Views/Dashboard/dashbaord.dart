import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wally_the_stupid/Database/dataHandler.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Dashboard/home.dart';
import 'package:wally_the_stupid/Views/Dashboard/leaderboard.dart';
import 'package:wally_the_stupid/Views/Dashboard/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _currentIndex = 0;
  final db = DataHandler.dataInstance;
  var packageInfo;

  @override
  void initState() {
    getDeviceInfo();
    db.updateLeaderBoard();
    super.initState();
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

  showContent() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return LeaderboardPage();
      case 2:
        return Container(
          child: Center(
            child: Icon(
              Icons.lock,
              color: UI.appHighLightColor.withOpacity(0.55),
              size: MediaQuery.of(context).size.width * 0.35,
            ),
          ),
        );
      case 3:
        return SettingsPage(
          deviceInfo: packageInfo,
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
            icon: Icon(Icons.leaderboard_outlined),
            title: Text("Leaderboard"),
            selectedColor: UI.appErrorColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            title: Text("Achivemnets"),
            selectedColor: UI.appHighLightColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: Text("Settings"),
            selectedColor: UI.appIconColor,
          ),
        ],
      );

  getDeviceInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }
}
