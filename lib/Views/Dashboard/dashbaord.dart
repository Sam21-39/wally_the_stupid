import 'package:flutter/material.dart';
import 'package:wally_the_stupid/Auth/auth.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Authentication/login.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          SizedBox(
            width: size.width * 0.8,
            child: MaterialButton(
              onPressed: () async {
                final auth = Auth.instance;
                auth.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (route) => false,
                );
              },
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sign In with Google',
                style: UI.appText.copyWith(fontSize: 24.0),
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
    );
  }
}
