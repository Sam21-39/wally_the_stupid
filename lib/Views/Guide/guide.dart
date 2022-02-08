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
  var time = 0.obs;
  var isSingleTapped = false.obs;
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
          if (no.value > 0) time.value += 1;
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
                () => isSingleTapped.value
                    ? isDone.value
                        ? Text(
                            'Nice! you took ${time.value} seconds',
                            style: UI.appText.copyWith(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'Double Tap the green button untill the no. becomes zero (0)',
                            style: UI.appText.copyWith(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          )
                    : Text(
                        'Single Tap the green button',
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
                () => isDone.value
                    ? MaterialButton(
                        disabledColor: UI.appButtonColor.withOpacity(0.45),
                        minWidth: size.width * 0.8,
                        onPressed: () => Get,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Next',
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
                        onTap: isSingleTapped.value
                            ? null
                            : () {
                                no.value += 1;
                                isSingleTapped.value = true;
                              },
                        onDoubleTap: isSingleTapped.value
                            ? () {
                                if (no.value >= 2) {
                                  no.value -= 2;
                                  if (no.value == 0) isDone.value = true;
                                }
                              }
                            : null,
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
