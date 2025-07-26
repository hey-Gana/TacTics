import 'package:flutter/material.dart';

class Antiai extends StatefulWidget {
  const Antiai({Key? key}) : super(key: key);

  @override
  State<Antiai> createState() => _AntiaiState();
}

class _AntiaiState extends State<Antiai> {
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
        title: const Center(child: Text("Anti Tic-Tac-Toe")),
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

    var result = _checkGameOver();

    if (result == null) {
      Future.delayed(const Duration(milliseconds: 400), () {
        _computerMove();
      });
    }
  }

  void _computerMove() async {
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < displayXO.length; i++) {
      if (displayXO[i] == ' ') {
        displayXO[i] = 'O';
        int score = _minimax(displayXO, false);
        displayXO[i] = ' ';
        if (score > bestScore) {
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

  /// Return score
  /// +10: the O-player FORCES the X-player to create 3-in-a-row (so AI wins)
  /// -10: the X-player FORCES the O-player to create 3-in-a-row (so Player wins)
  ///  0: draw
  int _minimax(List<String> board, bool isMaximizing) {
    String? result = _whoLost(board);

    // If someone has already created a line, that player LOSES, the other player is winner
    if (result != null) {
      if (result == 'X') return 10;
      if (result == 'O') return -10;
      return 0;
    }

    if (!board.contains(' ')) {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == ' ') {
          board[i] = 'O';
          int score = _minimax(board, false);
          board[i] = ' ';
          bestScore = score > bestScore ? score : bestScore;
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == ' ') {
          board[i] = 'X';
          int score = _minimax(board, true);
          board[i] = ' ';
          bestScore = score < bestScore ? score : bestScore;
        }
      }
      return bestScore;
    }
  }

  // Logic: If someone creates a line, return their symbol (they LOSE!)
  // Return null if no one has lost yet
  String? _whoLost(List<String> b) {
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
    String? lost = _whoLost(displayXO);
    if (lost != null) {
      String winner = lost == "X" ? "O (AI)" : "X (You)";
      _showDialog("$winner wins! $lost created a line and loses.");
      return winner;
    }
    if (!displayXO.contains(' ')) {
      _showDialog("Draw! No one lost.");
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
                          "Anti Tic-Tac-Toe Rules",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          "• On your turn, pick an empty cell.",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "• Do NOT make three in a row!",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "• If you do, you lose. If both avoid it, it's a draw.",
                          style: TextStyle(fontSize: 17),
                        ),
                        Spacer(),
                        Center(
                          child: Text(
                            "Do NOT get 3 in a row!",
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
