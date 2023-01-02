import 'package:flutter/material.dart';
import 'package:memory_game/audio_manager.dart';
import 'package:memory_game/word.dart';
import 'package:memory_game/word_data.dart';

class GameManager extends ChangeNotifier {
  static final List<Word> gridWords = WordData.wordList;

  String? currentword;
  Map<String, bool> gridWordsMap = {};
  List<String> pair = [];
  List<String> matchedWords = [];
  bool isGameOver = false;
  bool isNewGame = true;

  wordTileTapped(String tappedWord) {
    isNewGame = false;
    currentword = tappedWord;
    if (gridWordsMap.containsKey(tappedWord)) {
      gridWordsMap.update(tappedWord, (value) => !value);
    } else {
      gridWordsMap.putIfAbsent(tappedWord, () => true);
    }
    notifyListeners();
  }

  checkMatch(String tappedWord) async {
    //if reset game or reverse animation, dont proceed
    if (gridWordsMap.isEmpty ||
        (gridWordsMap.containsKey(tappedWord) &&
            gridWordsMap[tappedWord] == false)) {
      pair.remove(tappedWord);
      return;
    }

    if (pair.length < 2) {
      pair.add(tappedWord);
    }

    if (pair.length == 2) {
      bool matchFound = pair.first.substring(0, 1) == pair.last.substring(0, 1);
      if (matchFound) {
        await AudioManager.playAudio('match');
        matchedWords.addAll(pair);
        pair.clear();
      } else {
        await AudioManager.playAudio('nomatch');
        gridWordsMap.update(pair[0], (value) => false);
        gridWordsMap.update(pair[1], (value) => false);
        pair.clear();
      }
      if (matchedWords.length == 6) {
        isGameOver = true;
        await AudioManager.playAudio('fanfare');
      }
      notifyListeners();
    }
  }

  List<Word> get getGridWords {
    if (isNewGame) {
      gridWords.shuffle();
    }
    return gridWords;
  }

  resetWordGrid() {
    gridWordsMap.clear();
    pair.clear();
    matchedWords.clear();
    isGameOver = false;
    isNewGame = true;
    notifyListeners();
  }
}
