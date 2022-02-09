import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wally_the_stupid/Database/dataHandler.dart';
import 'package:wally_the_stupid/Model/challenge.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Dashboard/dashbaord.dart';

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
  var no = 0.obs;
  var time = 0.obs;
  var boxSize = 100.0;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    no.value = widget.challenge?.start;
    Future.delayed(Duration(milliseconds: 800)).then(
      (value) => timer = Timer.periodic(
        Duration(milliseconds: 1000),
        (timer) {
          if (widget.challenge?.target != no.value) time.value += 1;
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
                height: size.height * 0.05,
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
                height: size.height * 0.05,
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
                height: size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  no.value += 1;
                },
                onDoubleTap: () {
                  no.value -= 2;
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
              SizedBox(height: size.height * 0.02),
              Obx(
                () => widget.challenge?.target == no.value
                    ? Text(
                        'Congrats! you\'ve completed in ${time.value} seconds',
                        style: UI.appText.copyWith(
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        'Single/Double Tap the green button to Increase/Decrease the value',
                        style: UI.appText.copyWith(
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Obx(
                () => MaterialButton(
                  disabledColor: UI.appButtonColor.withOpacity(0.45),
                  minWidth: size.width * 0.8,
                  onPressed: widget.challenge?.target == no.value
                      ? () async {
                          final db = DataHandler.dataInstance;
                          timer.cancel();
                          final result = await db.addAnswer(
                            time.value,
                            (widget.challenge?.qid as String),
                            merge: true,
                          );
                          if (result.contains('error') ||
                              result.contains('exeception') ||
                              result.contains('accessToken != null') ||
                              result.contains('idToken != null')) {
                            Fluttertoast.showToast(
                              msg: 'Some error occured. Try again later',
                            );
                          } else {
                            db.updateLeaderBoard();
                            Get.offAll(
                              () => DashBoardPage(),
                              predicate: (route) => false,
                            );
                          }
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Submit',
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
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
