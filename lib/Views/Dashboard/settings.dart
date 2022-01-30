import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wally_the_stupid/Auth/auth.dart';
import 'package:wally_the_stupid/Database/staticData.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Authentication/login.dart';
import 'package:wally_the_stupid/Views/Dashboard/about.dart';

class SettingsPage extends StatefulWidget {
  final PackageInfo? deviceInfo;
  const SettingsPage({
    Key? key,
    this.deviceInfo,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'App Version: ${widget.deviceInfo?.version}',
              style: UI.appText,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Divider(
              color: UI.appIconColor,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            GestureDetector(
              onTap: () => Get.to(
                () => AboutPage(
                  packageInfo: widget.deviceInfo,
                ),
              ),
              child: Text(
                'About App',
                style: UI.appText,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Divider(
              color: UI.appIconColor,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            GestureDetector(
              onTap: launchURL,
              child: Text(
                'Privacy Policy',
                style: UI.appText,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Divider(
              color: UI.appIconColor,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            GestureDetector(
              onTap: launchContactURL,
              child: Text(
                'Contact Us',
                style: UI.appText,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Divider(
              color: UI.appIconColor,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            GestureDetector(
              onTap: onPressed,
              child: Text(
                'Sign Out',
                style: UI.appText,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Divider(
              color: UI.appIconColor,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  void launchURL() async {
    if (!await launch(StaticData.privacyURL))
      print('Could not launch ${StaticData.privacyURL}');
  }

  void launchContactURL() async {
    if (!await launch(StaticData.emailLaunchUri.toString()))
      print('Could not launch ${StaticData.emailLaunchUri.toString()}');
  }

  void onPressed() async {
    final auth = Auth.instance;
    auth.signOut();
    final sp = await SharedPreferences.getInstance();
    sp.setBool('isLogged', false);
    Get.offAll(
      LoginPage(),
      predicate: (route) => false,
    );
  }
}
