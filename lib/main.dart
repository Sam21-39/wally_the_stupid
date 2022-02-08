import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wally_the_stupid/Database/staticData.dart';
import 'package:wally_the_stupid/Services/local_notification.dart';
import 'package:wally_the_stupid/UI/ui.dart';
// import 'package:wally_the_stupid/Views/Authentication/login.dart';
import 'package:wally_the_stupid/Views/Dashboard/dashbaord.dart';
import 'package:wally_the_stupid/Views/Guide/guide.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  await LocalNotification.instance.initialize();
  // await PlatformViewsService.synchronizeToNativeViewHierarchy(false);
  tz.initializeTimeZones();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: StaticData.appName,
      theme: appLightTheme(),
      darkTheme: appDarkTheme(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: Splash(),
    );
  }

  appLightTheme() => ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: UI.appBackColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  appDarkTheme() => ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: UI.appBackDarkColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}

class Splash extends StatefulWidget {
  Splash({
    Key? key,
  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var opacity = 0.0.obs;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: 700),
    ).then(
      (value) => opacity.value = 1.0,
    );
    Future.delayed(
      Duration(seconds: 6),
    ).then((value) async {
      final sp = await SharedPreferences.getInstance();

      if (sp.getBool('isLogged') == null || sp.getBool('isLogged') == false) {
        Get.off(() => GuidePage());
      } else if (sp.getBool('isLogged') == true) {
        Get.off(() => DashBoardPage());
      }
      //else {
      //   Get.off(() => LoginPage());
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => AnimatedOpacity(
                duration: Duration(
                  milliseconds: 1200,
                ),
                opacity: opacity.value,
                child: Image.asset(
                  'assets/images/wally.png',
                  height: size.height * 0.16,
                ),
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'The Stupid',
                  textStyle: UI.appText.copyWith(
                    fontSize: 36,
                  ),
                  speed: const Duration(milliseconds: 300),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 600),
            ),
          ],
        ),
      ),
    );
  }
}
