import 'package:flutter/material.dart';
import 'package:wally_the_stupid/UI/ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sign In With Google \nand \nJoin The Stupid Gang!!!',
              style: UI.appText.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
              textScaleFactor: 1.2,
              textAlign: TextAlign.center,
            ),
            Image.asset(
              'assets/images/wally.png',
              height: size.height * 0.16,
            ),
            SizedBox(
              width: size.width * 0.8,
              child: MaterialButton(
                onPressed: () {},
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      height: size.height * 0.05,
                    ),
                    Text(
                      'Sign In with Google',
                      style: UI.appText.copyWith(fontSize: 24.0),
                    ),
                  ],
                ),
                animationDuration: Duration(milliseconds: 700),
                color: UI.appButtonColor,
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
