import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Authentication/login.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  var no = 5.obs;
  double boxSize = 100;
  var elevation = 2.obs;
  var duration = 500;
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      Duration(milliseconds: duration),
      ((timer) {
        if (timer.tick % 2 == 0) {
          elevation.value -= 10;
        } else {
          elevation.value += 10;
        }
      }),
    );
  }

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
              'Let\'s try to make the no. to 0 by tapping the screen',
              style: UI.appText.copyWith(
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Obx(
              () => Text(
                no.value.toString(),
                style: UI.appText.copyWith(
                  fontSize: 64.0,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Obx(
              () => GestureDetector(
                onTap: no.value <= 5 ? () => no.value += 1 : null,
                onDoubleTap: () {
                  if (no.value >= 2) {
                    no.value -= 2;
                  }
                },
                child: AnimatedContainer(
                  curve: Curves.bounceInOut,
                  duration: Duration(
                    milliseconds: duration,
                  ),
                  height: boxSize,
                  width: boxSize,
                  child: Card(
                    color: UI.appButtonColor,
                    borderOnForeground: true,
                    elevation: elevation.value.toDouble(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
