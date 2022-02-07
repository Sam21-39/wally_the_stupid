import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataHandler {
  DataHandler._();

  static final DataHandler dataInstance = DataHandler._();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future _createUser() async {
    try {
      await firestore.collection('User').doc(auth.currentUser?.uid).set({
        'name': auth.currentUser?.displayName,
        'email': auth.currentUser?.email,
        'image': auth.currentUser?.photoURL,
        'achivement': [],
        'isActive': true,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future _createLeaderBoard() async {
    try {
      await firestore.collection('Leaderboard').doc(auth.currentUser?.uid).set({
        'time': 9999999,
        'isActive': true,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future initiateUserCreation() async {
    await _createUser();
    await _createLeaderBoard();
  }

  Future addAnswer(
    num time,
    String qid, {
    bool merge = false,
  }) async {
    try {
      final List resultList = await _getAllAnswers();
      if (resultList.any((element) => element['qid'] == qid)) {
        final index = resultList.indexWhere((element) => element['qid'] == qid);
        resultList.removeAt(index);
        resultList.insert(
          index,
          {
            'time': time,
            'qid': qid,
          },
        );
      } else {
        resultList.add(
          {
            'time': time,
            'qid': qid,
          },
        );
      }
      await firestore.collection('Answers').doc(auth.currentUser?.uid).set(
        {
          'challenges': resultList,
        },
        SetOptions(merge: merge),
      );
      return 'done';
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future _getAllAnswers() async {
    try {
      final result = await firestore
          .collection('Answers')
          .doc(auth.currentUser?.uid)
          .get();

      final resultList = (result.data() as Map)['challenges'];
      return resultList;
    } catch (e) {
      return null;
    }
  }

  Future getBestTime() async {
    try {
      final result = await firestore
          .collection('Answers')
          .doc(auth.currentUser?.uid)
          .get();

      final resultList = (result.data() as Map)['challenges'];
      var time = 9999999;
      for (var item in resultList) {
        if (item['time'] < time) time = item['time'];
      }
      return time;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future _getBestTimeinLeaderboard() async {
    try {
      final data = await firestore
          .collection("Leaderboard")
          .doc(auth.currentUser?.uid)
          .get();

      final lead = data.data();

      final time = (lead as Map)['time'];
      return time;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future updateLeaderBoard() async {
    try {
      final timeFromAns = await getBestTime();
      final timeFromLead = await _getBestTimeinLeaderboard();

      if (timeFromLead > timeFromAns) {
        await firestore
            .collection('Leaderboard')
            .doc(auth.currentUser?.uid)
            .update({
          'time': timeFromAns,
          'isActive': true,
          'timestamp': Timestamp.now(),
        });
      } else if (timeFromAns > timeFromLead) {
        await firestore
            .collection('Leaderboard')
            .doc(auth.currentUser?.uid)
            .update({
          'time': timeFromLead,
          'isActive': true,
          'timestamp': Timestamp.now(),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future clearLeaderboard() async {
    try {
      await firestore.collection('Leaderboard').get().then(
            (value) => value.docs.forEach((element) {
              element.reference.update({
                'time': 9999999,
                'isActive': true,
                'timestamp': Timestamp.now(),
              });
            }),
          );
    } catch (e) {
      print(e.toString());
    }
  }
}
