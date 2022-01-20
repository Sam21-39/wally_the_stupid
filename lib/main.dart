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
    Key key,
  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: Image.asset(
          'assets/images/wally.png',
        ),
      ),
    );
  }
}
