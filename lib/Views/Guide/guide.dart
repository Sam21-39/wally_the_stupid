import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wally_the_stupid/UI/ui.dart';
import 'package:wally_the_stupid/Views/Authentication/login.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  int no = 5;

  @override
  void initState() {
    // ...
    FeatureDiscovery.clearPreferences(
      context,
      const <String>{
        // Feature ids for every feature that you want to showcase in order.
        'single_tap_id',
        'double_tap_id',
        'good_luck_id',
      },
    );
    SchedulerBinding.instance?.addPostFrameCallback((Duration duration) {
      FeatureDiscovery.discoverFeatures(
        context,
        const <String>{
          // Feature ids for every feature that you want to showcase in order.
          'single_tap_id',
          'double_tap_id',
          'good_luck_id',
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onDoubleTap: () => setState(() => no > 0 ? no -= 2 : null),
      onTap: () => setState(() => no > 0 ? no += 1 : null),
      child: Scaffold(
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
              Text(
                no.toString(),
                style: UI.appText.copyWith(
                  fontSize: 64.0,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DescribedFeatureOverlay(
                    featureId: 'single_tap_id',
                    title: Text('Single Tap'),
                    description: Text('Tap once to increase th no. by 1'),
                    backgroundColor: UI.appErrorColor,
                    targetColor: Colors.white,
                    textColor: Colors.white,
                    contentLocation: ContentLocation.below,
                    pulseDuration: Duration(seconds: 1),
                    tapTarget: GestureDetector(
                      onTap: () async {
                        setState(() => no += 1);
                        await FeatureDiscovery.completeCurrentStep(context);
                      },
                    ),
                    child: Container(),
                  ),
                  DescribedFeatureOverlay(
                    featureId: 'double_tap_id',
                    title: Text('Double Tap'),
                    description: Text('Tap Twice to decrease the no. by 2'),
                    backgroundColor: UI.appHighLightColor,
                    targetColor: Colors.white,
                    textColor: Colors.white,
                    contentLocation: ContentLocation.below,
                    pulseDuration: Duration(milliseconds: 300),
                    tapTarget: GestureDetector(
                      onDoubleTap: () async {
                        setState(() => no -= 2);
                        if (no == 0) {
                          await FeatureDiscovery.completeCurrentStep(context);
                        }
                      },
                    ),
                    child: Container(),
                  ),
                  DescribedFeatureOverlay(
                    featureId: 'good_luck_id',
                    title: Text('Good Luck'),
                    description: Text(
                        'Sign In \nand \ncomplete more challenges like this'),
                    backgroundColor: UI.appButtonColor,
                    targetColor: Colors.white,
                    textColor: Colors.white,
                    contentLocation: ContentLocation.below,
                    pulseDuration: Duration(seconds: 700),
                    overflowMode: OverflowMode.clipContent,
                    tapTarget: GestureDetector(
                      onTap: () async {
                        await FeatureDiscovery.completeCurrentStep(context);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    ),
                    child: Container(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
