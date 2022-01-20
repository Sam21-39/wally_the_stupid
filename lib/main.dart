import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Authentication/login.dart';

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
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 6),
    ).then(
      (value) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      ),
    );
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
                  speed: const Duration(milliseconds: 400),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 800),
            ),
          ],
        ),
      ),
    );
  }
}
