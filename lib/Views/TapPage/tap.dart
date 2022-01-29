import 'package:flutter/material.dart';
import 'package:wally_the_stupid/Model/challenge.dart';
import 'package:wally_the_stupid/UI/ui.dart';

class TapPage extends StatefulWidget {
  final Challenge? challenge;
  const TapPage({
    Key? key,
    this.challenge,
  }) : super(key: key);

  @override
  _TapPageState createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  // int no = 5;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Text(
              widget.challenge?.prompt ?? 'Challenge',
              style: UI.appText.copyWith(
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Text(
              widget.challenge?.start.toString() ?? '0',
              style: UI.appText.copyWith(
                fontSize: 64.0,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
