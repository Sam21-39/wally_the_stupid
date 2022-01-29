import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  String? qid;
  String? prompt;
  num? start;
  num? answer;
  bool? isActive;
  Timestamp? timestamp;

  Challenge({
    this.qid,
    this.prompt,
    this.start,
    this.answer,
    this.isActive,
    this.timestamp,
  });
}
