import 'package:flutter/material.dart';
import 'package:wally_the_stupid/Model/questionModel.dart';
import 'package:wally_the_stupid/UI/ui.dart';

class QnAPage extends StatefulWidget {
  final Questions? questions;
  const QnAPage({
    Key? key,
    this.questions,
  }) : super(key: key);

  @override
  _QnAPageState createState() => _QnAPageState();
}

class _QnAPageState extends State<QnAPage> {
  int isRight = -1;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Card(
        borderOnForeground: true,
        color: UI.appHighLightColor,
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Q: ${widget.questions?.prompt}',
                style: UI.appText,
                softWrap: true,
              ),
              Divider(
                color: UI.appHighLightColor,
                thickness: 2.0,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.questions?.options?.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: isDone
                      ? null
                      : () {
                          setState(() {
                            (widget.questions?.options as List)[index] ==
                                    (widget.questions?.answer as String)
                                ? isRight = index
                                : isRight = -1;
                            isDone = true;
                          });
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: isRight == index ? UI.appButtonColor : null,
                      child: Text(
                        '${index + 1}. ${(widget.questions?.options as List)[index]}',
                        style: UI.appText.copyWith(
                          color: isDone ? UI.appBackDarkColor : Colors.white,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
