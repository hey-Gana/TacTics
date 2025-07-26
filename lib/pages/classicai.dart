import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/pages/rules.dart';

class Classicai extends StatefulWidget {
  const Classicai({Key? key}) : super(key: key);

  @override
  State<Classicai> createState() => _ClassicaiState();
}

class _ClassicaiState extends State<Classicai> {
  final int boardSize = 3;
  late List<String> displayXO;
  bool xTurn = true;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Classic Tic-Tac-Toe")),
        actions: [
          IconButton(
            onPressed: _showRules,
            icon: const Icon(Icons.model_training_rounded),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Turn: ${xTurn ? "X (You)" : "O (AI)"}',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Expanded(
                flex: 5,
                child: GridView.builder(
                  itemCount: boardSize * boardSize,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: boardSize,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap:
                          xTurn && displayXO[index] == ' '
                              ? () => _tapped(index)
                              : null,
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: const Color.fromARGB(255, 19, 26, 34),
                          ),
                          color: const Color.fromARGB(255, 37, 60, 99),
                        ),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: const TextStyle(
                              fontSize: 64,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 40.0,
                  width: 100.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: _resetGame,
                      child: const Icon(Icons.restart_alt_rounded),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100.0),
            ],
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    if (!xTurn || displayXO[index] != ' ') return;

    setState(() {
      displayXO[index] = 'X';
      xTurn = false;
    });

    final result = _checkGameOver();

    if (result == null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _computerMove();
      });
    }
  }

  void _computerMove() async {
    int bestScore = 1000;
    int bestMove = -1;

    for (int i = 0; i < displayXO.length; i++) {
      if (displayXO[i] == ' ') {
        displayXO[i] = 'O';
        int score = _minimax(displayXO, 0, true);
        displayXO[i] = ' ';
        if (score < bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    if (bestMove != -1) {
      setState(() {
        displayXO[bestMove] = 'O';
        xTurn = true;
      });
      _checkGameOver();
    }
  }

  // X tries to maximize, O tries to minimize.
  int _minimax(List<String> board, int depth, bool isMaximizing) {
    String? result = _whoWon(board);
    if (result != null) {
      if (result == 'X') return 10 - depth;
      if (result == 'O') return depth - 10;
      return 0;
    }

    if (!board.contains(' ')) {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == ' ') {
          board[i] = 'X';
          int score = _minimax(board, depth + 1, false);
          board[i] = ' ';
          bestScore = score > bestScore ? score : bestScore;
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == ' ') {
          board[i] = 'O';
          int score = _minimax(board, depth + 1, true);
          board[i] = ' ';
          bestScore = score < bestScore ? score : bestScore;
        }
      }
      return bestScore;
    }
  }

  String? _whoWon(List<String> b) {
    // check rows
    for (int i = 0; i < 3; i++) {
      if (b[i * 3] != ' ' &&
          b[i * 3] == b[i * 3 + 1] &&
          b[i * 3] == b[i * 3 + 2]) {
        return b[i * 3];
      }
    }
    // check columns
    for (int i = 0; i < 3; i++) {
      if (b[i] != ' ' && b[i] == b[i + 3] && b[i] == b[i + 6]) {
        return b[i];
      }
    }
    // check diagonals
    if (b[0] != ' ' && b[0] == b[4] && b[0] == b[8]) {
      return b[0];
    }
    if (b[2] != ' ' && b[2] == b[4] && b[2] == b[6]) {
      return b[2];
    }
    return null;
  }

  String? _checkGameOver() {
    String? winner = _whoWon(displayXO);
    if (winner != null) {
      _showDialog("$winner wins!");
      return winner;
    }
    if (!displayXO.contains(' ')) {
      _showDialog("It's a Draw!");
      return "draw";
    }
    return null;
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetGame();
                },
                child: const Text("Play Again"),
              ),
            ],
          ),
    );
  }

  void _resetGame() {
    displayXO = List.filled(boardSize * boardSize, ' ');
    xTurn = true;
    setState(() {});
  }

  void _showRules() {
    showDialog(
      context: context,
      builder:
          (context) => Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 320,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Classic Tic-Tac-Toe Rules",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          "• Players take turns placing their symbol (X or O) on an empty cell.",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "• The first player to get three of their marks in a row (vertically, horizontally, or diagonally) wins the game.",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "• If all spaces are filled and nobody has three in a row, the game ends in a draw.",
                          style: TextStyle(fontSize: 17),
                        ),
                        Spacer(),
                        Center(
                          child: Text(
                            "Try to get 3 in a row!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 59, 123, 175),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
