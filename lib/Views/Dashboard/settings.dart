import 'package:flutter/material.dart';
import 'package:wally_the_stupid/UI/ui.dart';

class SettingsPage extends StatefulWidget {
  final deviceInfo;
  const SettingsPage({
    Key? key,
    this.deviceInfo,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String deviceVersion = '1.0.0';

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
          children: [
            Text(
              deviceVersion,
              style: UI.appText,
            ),
            Divider(
              color: UI.appIconColor,
            ),
            Text(
              'About App',
              style: UI.appText,
            ),
            Divider(
              color: UI.appIconColor,
            ),
            Text(
              'Privacy Policy',
              style: UI.appText,
            ),
            Divider(
              color: UI.appIconColor,
            ),
            Text(
              'Sign Out',
              style: UI.appText,
            ),
            Divider(
              color: UI.appIconColor,
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
