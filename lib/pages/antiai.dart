import 'package:flutter/material.dart';

class Antiai extends StatefulWidget {
  const Antiai({Key? key}) : super(key: key);

  @override
  State<Antiai> createState() => _AntiaiState();
}

class _AntiaiState extends State<Antiai> {
  final int boardSize = 3; //board size
  late List<String> displayXO; // Array of positions on board
  bool xTurn = true; // X plays first turn

  @override
  //Initial state -fresh board
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
                  //if it is X's turn or Ai's turn
                  'Turn: ${xTurn ? "X (You)" : "O (Computer)"}',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Expanded(
                flex: 5,
                //Create the grid for anti-TTT
                child: GridView.builder(
                  itemCount: boardSize * boardSize,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: boardSize,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap:
                          //if it is X's turn and cell is empty, fill it with X
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

  //Tap function
  void _tapped(int index) {
    //if it is not X's turn, return
    if (!xTurn || displayXO[index] != ' ') return;

    //if it is X's turn, set index to 'X' and flip to O's turn
    setState(() {
      displayXO[index] = 'X';
      xTurn = false;
    });

    //Check if the move is a winning move by X
    var result = _checkGameOver();

    //After X's turn, let computer play with a delay of 1 second
    if (result == null) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        //call computerMove()
        _computerMove();
      });
    }
  }

  //X is minimizer and O is maximizer for Anti- Tic tac toe
  void _computerMove() async {
    //feeds minimum score for O ~ worst case scenario
    int bestScore = -1000;
    int bestMove = -1;
    //for the array of board, try 'O' in the place and calculate _minimax().
    //Choose the maximizing score board for computer's turn
    for (int i = 0; i < displayXO.length; i++) {
      //if the position is empty
      if (displayXO[i] == ' ') {
        //put 'O' in the position
        displayXO[i] = 'O';
        //check score using minimax algorithm
        int score = _minimax(displayXO, false);
        //undo the move
        displayXO[i] = ' ';
        //picks the maximum score for best move for 'O'
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    //Once move is made, set state to the best move
    if (bestMove != -1) {
      setState(() {
        displayXO[bestMove] = 'O';
        //set it to X's turn
        xTurn = true;
      });
      //Check if it is the winning move for 'O'
      _checkGameOver();
    }
  }

  /// Return score
  /// +10: the O-player FORCES the X-player to create 3-in-a-row (so AI wins)
  /// -10: the X-player FORCES the O-player to create 3-in-a-row (so Player wins)
  ///  0: draw
  // X tries to minimize, O tries to maximize.
  //Adverserial search - recurrsive to simulate all board possibilities and assigns points for it.
  int _minimax(List<String> board, bool isMaximizing) {
    String? result = _whoLost(board);

    // If someone has already created a line, that player LOSES, the other player is winner
    if (result != null) {
      if (result == 'X') return 10; // better to win early
      if (result == 'O') return -10; //better to lose late
      return 0;
    }
    //if board is full, returns 0
    if (!board.contains(' ')) {
      return 0;
    }
    // O's turn
    if (isMaximizing) {
      //starts with the worst case by having the least score
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == ' ') {
          // if space is blank:
          //Place O in the blank
          board[i] = 'O';
          //recursively calling minimax for 'X'
          int score = _minimax(board, false);
          //undoing the move
          board[i] = ' ';
          //Maximizing score for O
          bestScore = score > bestScore ? score : bestScore;
        }
      }
      return bestScore;
    }
    //X's turn
    else {
      //starts with the worst case by having the maximum score
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        // if space is blank:
        if (board[i] == ' ') {
          //Place X in the blank
          board[i] = 'X';
          //recursively calling minimax for 'O'
          int score = _minimax(board, true);
          //undoing the move
          board[i] = ' ';
          //Minimizing score for X
          bestScore = score < bestScore ? score : bestScore;
        }
      }
      //returns the maximum score of each board simulation
      return bestScore;
    }
  }

  // Check's loser : if they get 3 in a line(r,c or dia)
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

  //Displays result
  String? _checkGameOver() {
    String? lost = _whoLost(displayXO);
    if (lost != null) {
      String winner = lost == "X" ? "O (AI)" : "X (You)";
      _showDialog("$winner wins! $lost created a line and loses.");
      return winner;
    }
    //Even if _whoWon() return null, display shouldn't contain " "
    if (!displayXO.contains(' ')) {
      _showDialog("Draw! No one lost.");
      return "draw";
    }
    return null;
  }

  //After game ends - show alert dialog box
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

  //reset the board
  void _resetGame() {
    //make an empty array
    displayXO = List.filled(boardSize * boardSize, ' ');
    //assign X turn as true
    xTurn = true;
    //sets that as the state
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
