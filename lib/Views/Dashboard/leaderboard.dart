import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Leaderboard').snapshots(),
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
              return Card(
                child: Text(leaderList[index]['score'].toString()),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
