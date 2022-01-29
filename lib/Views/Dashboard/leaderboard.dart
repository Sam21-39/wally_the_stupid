import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wally_the_stupid/UI/ui.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.02,
        ),
        Container(
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
            color: UI.appErrorColor,
          ),
          child: Text(
            'LeaderBoard',
            style: UI.appText.copyWith(
              color: Colors.white,
              decoration: TextDecoration.underline,
              fontSize: 24.0,
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Leaderboard')
                .orderBy('time')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data.docs;
                final leaderList = [];
                data.forEach((e) {
                  leaderList.add(e);
                });

                return ListView.builder(
                  itemCount: leaderList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 6.0,
                        borderOnForeground: true,
                        color: UI.appErrorColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${(index + 1).toString()}.',
                                style: UI.appText,
                              ),
                              Container(
                                // color: Colors.amber,
                                width: size.width * 0.4,
                                child: FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('User')
                                        .doc(leaderList[index].id)
                                        .get(),
                                    builder: (context, snaps) {
                                      if (snaps.hasData) {
                                        final data = snaps.data;

                                        return Text(
                                          (data
                                              as DocumentSnapshot<Map>)['name'],
                                          style: UI.appText.copyWith(
                                            color: data['name'] ==
                                                    FirebaseAuth
                                                        .instance
                                                        .currentUser
                                                        ?.displayName
                                                ? UI.appHighLightColor
                                                : Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              UI.appBackDarkColor,
                                            ),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                              Text(
                                '${leaderList[index]['time'] == 9999999 ? 'infinite' : leaderList[index]['time']} sec',
                                style: UI.appText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    UI.appBackDarkColor,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
