import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wally_the_stupid/UI/ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wally - The Stupid',
      theme: appLightTheme(),
      darkTheme: appDarkTheme(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: Splash(),
    );
  }

  appLightTheme() => ThemeData(
        accentColor: UI.appBackDarkColor.withOpacity(0.75),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: UI.appBackColor,
        buttonColor: UI.appButtonColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  appDarkTheme() => ThemeData(
        accentColor: UI.appBackColor.withOpacity(0.75),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: UI.appBackDarkColor,
        buttonColor: UI.appButtonColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}

class Splash extends StatefulWidget {
  Splash({
    Key key,
  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SvgPicture.asset('assets/images/wally.svg'),
      ),
    );
  }
}
