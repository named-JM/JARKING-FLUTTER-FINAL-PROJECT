import 'dart:math';

import 'package:final_project_for_flutter_by_jarling/categories/games/WORDLE%20GAME/utils/list_words.dart';

class WordleGame {
  //setting the game variables
  int rowId = 0;
  int letterId = 0;
  static String game_message = "";
  static String game_guess = "";
  static List<String> word_list = WordList.word_list;
  static bool gameOver = false;

  //setting the game row
  static List<Letter> wordleRow = List.generate(
    5,
    (index) => Letter("", 0),
  );

  //Setting the gameBoard
  List<List<Letter>> wordleBoard = List.generate(
      5,
      (index) => List.generate(
            5,
            (index) => Letter("", 0),
          ));

  //Setting the Game Functon
  void passTry() {
    rowId++;
    letterId = 0;
  }

//will generate in the start of the game will random choose the word of list to guess!
  static void initGame() {
    final random = new Random();
    int index = random.nextInt(word_list.length);
    game_guess = word_list[index].toUpperCase();
  }

  //Setting the game insertion
  void insertWord(index, word) {
    wordleBoard[rowId][index] = word;
  }

  //checking word
  bool checkWordExist(String word) {
    return word_list.contains(word);
  }

//resets/restart the game once done guessing in 5 words.
  void reset() {
    rowId = 0;
    letterId = 0;
    wordleBoard =
        List.generate(5, (index) => List.generate(5, (index) => Letter("", 0)));
    return initGame();
  }
}

//this is the letter and the index
class Letter {
  String? letter;
  int code = 0;

  Letter(this.letter, this.code);
}
