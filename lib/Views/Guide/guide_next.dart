import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wally_the_stupid/Views/Authentication/login.dart';

import '../../UI/ui.dart';

class GuideNext extends StatefulWidget {
  const GuideNext({Key? key}) : super(key: key);

  @override
  _GuideNextState createState() => _GuideNextState();
}

class _GuideNextState extends State<GuideNext> {
  var left = 'D'.codeUnitAt(0).obs;
  var rest = 'ALLY';
  var concat = ''.obs;
  var time = 0.obs;
  var isDone = false.obs;

  double boxSize = 100;
  int duration = 500;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 800)).then(
      (value) => Timer.periodic(
        Duration(milliseconds: 1000),
        (timer) {
          concat.value = String.fromCharCode(left.value) + rest;

          if (concat != 'WALLY') time.value += 1;
        },
      ),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Text(
                'Let\'s try to make the word \"WALLY\" by tapping the screen',
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
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      String.fromCharCode(left.value),
                      style: UI.appText.copyWith(
                        fontSize: 64.0,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      rest,
                      style: UI.appText.copyWith(
                        fontSize: 64.0,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Obx(
                () => Text(
                  '${time.value} sec',
                  style: UI.appText.copyWith(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Obx(
                () => concat.value == 'WALLY'
                    ? Text(
                        'Nice! you took ${time.value} seconds',
                        style: UI.appText.copyWith(
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        'Change the leftmost \"D\" to \"W\" by Double/Single Tapping',
                        style: UI.appText.copyWith(
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Obx(
                () => concat.value == "WALLY"
                    ? MaterialButton(
                        disabledColor: UI.appButtonColor.withOpacity(0.45),
                        minWidth: size.width * 0.8,
                        onPressed: () => Get.off(
                          () => LoginPage(),
                          popGesture: false,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Done',
                            style: UI.appText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        animationDuration: Duration(milliseconds: 700),
                        color: UI.appButtonColor,
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (left.value == 90) {
                            left.value = 65;
                          } else {
                            left.value += 1;
                          }
                        },
                        onDoubleTap: () {
                          if (left.value == 66) {
                            left.value = 90;
                          } else if (left.value == 65) {
                            left.value = 89;
                          } else {
                            left.value -= 2;
                          }
                        },
                        child: Container(
                          height: boxSize,
                          width: boxSize,
                          child: Card(
                            color: UI.appButtonColor,
                            borderOnForeground: true,
                            elevation: 10,
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
      ),
    );
  }
}
