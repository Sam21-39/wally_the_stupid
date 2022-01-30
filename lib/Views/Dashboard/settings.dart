import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wally_the_stupid/UI/ui.dart';
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
            Text(
              'Privacy Policy',
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
            Text(
              'Sign Out',
              style: UI.appText,
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
}


// onPressed: () async {
//                 final auth = Auth.instance;
//                 auth.signOut();
//                 final sp = await SharedPreferences.getInstance();
//                 sp.setBool('isLogged', false);
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(
//                     builder: (context) => LoginPage(),
//                   ),
//                 );
//               },
