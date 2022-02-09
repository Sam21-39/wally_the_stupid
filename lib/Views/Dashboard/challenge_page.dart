import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Model/challenge.dart';
import '../../UI/ui.dart';
import '../TapPage/tap.dart';

class ChallengePage extends StatefulWidget {
  final int category;
  const ChallengePage({
    Key? key,
    this.category = 1,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.06,
            ),
            SizedBox(
              height: size.height * 0.8,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('New_Challenges')
                    .where('isActive', isEqualTo: true)
                    .where(
                      'category',
                      isEqualTo: widget.category,
                    )
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data.docs;
                    //print(data[0]['prompt']);

                    final List<Challenge> dataList = [];
                    data.forEach((e) {
                      var challenge = Challenge();
                      challenge.qid = e.id;
                      challenge.prompt = e['prompt'];
                      challenge.answer = e['answer'];
                      challenge.isActive = e['isActive'];
                      challenge.start = e['start'];
                      challenge.category = e['category'];
                      dataList.add(challenge);
                    });
                    return ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => TapPage(
                                challenge: dataList[index],
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 2.5,
                                  color: Colors.black12,
                                  offset: Offset(0.9, 0.9),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                              color: UI.appButtonColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${index + 1}.',
                                  style: UI.appText,
                                ),
                                SizedBox(
                                  width: size.width * 0.6,
                                  child: Text(
                                    dataList[index].prompt!,
                                    style: UI.appText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
