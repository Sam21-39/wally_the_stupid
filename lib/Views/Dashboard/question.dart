import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wally_the_stupid/Model/questionModel.dart';
import 'package:wally_the_stupid/Views/QnA/qna.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Questions').snapshots(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data.docs;
          final List<Questions> quesList = [];

          data.forEach((e) {
            final question = Questions(
              prompt: e['prompt'],
              answer: e['answer'],
              options: e['options'],
              score: e['score'],
            );

            quesList.add(question);
          });
          // print(quesList[0].prompt);
          return ListView.builder(
            itemCount: quesList.length,
            itemBuilder: (context, index) => QnAPage(
              questions: quesList[index],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
