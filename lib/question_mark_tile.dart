import 'package:flutter/material.dart';

class QuestionMarkTile extends StatelessWidget {
  const QuestionMarkTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.purple,
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.question_mark,
          size: 50,
          color: Colors.white,
        ),
      );
  }
}