import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  final String? prompt;
  final num? start;
  final num? answer;
  final bool? isActive;
  final Timestamp? timestamp;

  Challenge({
    this.prompt,
    this.start,
    this.answer,
    this.isActive,
    this.timestamp,
  });
}
