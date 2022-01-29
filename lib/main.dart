import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Authentication/login.dart';
import 'package:wally_the_stupid/Views/Dashboard/dashbaord.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:wally_the_stupid/Views/Guide/guide.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  MobileAds.instance.initialize();
  platformServiceManger();
  runApp(MyApp());
}

void platformServiceManger() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final isAndroidOld = (androidInfo.version.sdkInt ?? 0) < 29; //Android 10
// final useHybridComposition = anroidInfo.remoteConfig.getBool(
//   isAndroidOld
//       ? RemoteConfigKey.useHybridCompositionOlderOS
//       : RemoteConfigKey.useHybridCompositionNewerOS,
// );
    if (isAndroidOld) {
      await PlatformViewsService.synchronizeToNativeViewHierarchy(false);
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FeatureDiscovery(
      child: GetMaterialApp(
        title: 'Wally - The Stupid',
        theme: appLightTheme(),
        darkTheme: appDarkTheme(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: Splash(),
      ),
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
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 6),
    ).then((value) async {
      final sp = await SharedPreferences.getInstance();

      if (sp.getBool('isLogged') == null) {
        Get.off(() => GuidePage());
      } else if (sp.getBool('isLogged') == true) {
        Get.off(() => DashBoardPage());
      } else {
        Get.off(() => LoginPage());
      }
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
            Image.asset(
              'assets/images/wally.png',
              height: size.height * 0.16,
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
