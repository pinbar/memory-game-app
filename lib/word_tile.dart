import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'flip_animation.dart';
import 'game_manager.dart';
import 'word.dart';

class WordTile extends StatelessWidget {
  final int index;
  final Word word;

  const WordTile({
    required this.index,
    required this.word,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameManager>(
      builder: (_, gm, __) => GestureDetector(
        key: const Key('wordTile'),
        onTap: () {
          gm.wordTileTapped(word.word);
        },
        child: FlipAnimation(
          animate: doAnimate(gm, word.word),
          reverse: doReverse(gm, word.word),
          animationCompleted: (completed) {
            gm.checkMatch(word.word);
          },
          word: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: gm.matchedWords.contains(word.word) ? Colors.lightGreen : Colors.purpleAccent.shade200,
            ),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: FittedBox(
              child: Transform(
                transform: Matrix4.rotationY(pi),
                alignment: Alignment.center,
                child: Text(
                  word.word,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  doAnimate(GameManager gm, String tappedWord) {
    if (gm.matchedWords.contains(tappedWord)) {
      return false;
    }

    Map<String, bool> currentGridMap = gm.gridWordsMap;
    if (tappedWord == gm.currentword &&
        currentGridMap.containsKey(tappedWord) &&
        currentGridMap[tappedWord] == true) {
      return true;
    }
    return false;
  }

  doReverse(GameManager gm, String tappedWord) {
    if (gm.matchedWords.contains(tappedWord)) {
      return false;
    }

    Map<String, bool> currentGridMap = gm.gridWordsMap;
    if (!currentGridMap.containsKey(tappedWord)) {
      return true;
    }
    if (currentGridMap[tappedWord] == false) {
      return true;
    }
    return false;
  }
}