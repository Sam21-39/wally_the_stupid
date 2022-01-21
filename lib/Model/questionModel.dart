import 'package:flutter/material.dart';

class Questions {
  final String? prompt;
  final String? answer;
  final List? options;
  final int? score;

  const Questions({this.prompt, this.answer, this.options, this.score});
}
