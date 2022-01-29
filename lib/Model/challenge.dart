import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  String? prompt;
  num? start;
  num? answer;
  bool? isActive;
  Timestamp? timestamp;

  Challenge({
    this.prompt,
    this.start,
    this.answer,
    this.isActive,
    this.timestamp,
  });
}
