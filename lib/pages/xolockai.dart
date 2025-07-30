import 'package:flutter/material.dart';

class Xolockai extends StatefulWidget {
  const Xolockai({super.key});

  @override
  State<Xolockai> createState() => _XolockaiState();
}

class _XolockaiState extends State<Xolockai> {
  final int boardSize = 3; //Board size
  late List<String> displayXO; //Array of positions
  bool xTurn = true; //First player is X

  List<int> xMoves = []; //keeps track of X's moves
  List<int> oMoves = []; // Keeps track of O's moves

  //Temporary index to hold the first position for 3+th turns
  int? tempLockedIndex;

  //Initialize state - fresh board
  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  //Assigns empty list for displayXO and empties xMoves and oMoves & assigns temporary lock index to Null
  void _initializeBoard() {
    displayXO = List.filled(boardSize * boardSize, ' ');
    xMoves.clear();
    oMoves.clear();
    tempLockedIndex = null;
  }

  // Lock the first tile after 3 moves
  void _updateLockedTile() {
    // locking for current player, called after move is made
    if (xTurn && xMoves.length == 3) {
      tempLockedIndex = xMoves.first;
    } else if (!xTurn && oMoves.length == 3) {
      tempLockedIndex = oMoves.first;
    } else {
      tempLockedIndex = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Tic-Tac-Lock")),
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
                  'Turn: ${xTurn ? "X (You)" : "O (Computer)"}',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
              Expanded(
                flex: 5,
                //Creating grid for tictaclock
                child: GridView.builder(
                  itemCount: boardSize * boardSize,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: boardSize,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final isLocked = index == tempLockedIndex;
                    return GestureDetector(
                      onTap:
                          //if it is xturn and cell is empty, fill it with X
                          xTurn &&
                                  displayXO[index] == ' ' &&
                                  //if tempLockedIndex is null
                                  (tempLockedIndex == null ||
                                      index != tempLockedIndex)
                              ? () => _tapped(index)
                              : null,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: const Color.fromARGB(255, 19, 26, 34),
                          ),
                          color:
                              isLocked
                                  ? Colors.grey[700]
                                  : Color.fromARGB(255, 37, 60, 99),
                        ),
                        child: Center(
                          child: Text(
                            displayXO[index] == ' ' ? '' : displayXO[index],
                            style: TextStyle(
                              fontSize: 64,
                              color: isLocked ? Colors.grey[300] : Colors.white,
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
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // Tap function -
  void _tapped(int index) {
    //if it is not X's turn, return
    if (!xTurn || displayXO[index] != ' ' || (tempLockedIndex == index)) return;

    setState(() {
      // If player already placed 3, remove oldest
      if (xMoves.length == 3) {
        int removed = xMoves.removeAt(0);
        _removePiece(removed);
      }
      //if it is X's turn, set index to X
      displayXO[index] = 'X';
      //add the index to xmoves list
      xMoves.add(index);
      //updated the locked tiles
      _updateLockedTile();
      //flip it to O's turn
      xTurn = false;
    });
    // Check for win
    final result = _checkGameOver();

    if (result == null) {
      // Let computer play after delay
      Future.delayed(const Duration(milliseconds: 1000), () {
        _computerMove();
      });
    }
  }

  // AI's move for O
  //X is maximizer and O is minimizer
  void _computerMove() {
    //feeds maximum score for O ~ worst case scenario
    int bestScore = 1000;
    int bestMove = -1;

    //for the array of board, try 'O' in the place and calculate _minimax().
    //Choose the minimizing score board for computer's turn
    for (int i = 0; i < displayXO.length; i++) {
      //if the position is empty
      if (displayXO[i] == ' ' &&
          (tempLockedIndex == null || i != tempLockedIndex)) {
        //put 'O' in the position
        displayXO[i] = 'O';
        //check score using minimax algorithm
        int score = _minimax(displayXO, true);
        //undo the move
        displayXO[i] = ' ';
        //picks the minimum score for best move for 'O'
        if (score < bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    //Once move is made, set state to the best move
    setState(() {
      if (oMoves.length == 3) {
        //remove the first element
        int removed = oMoves.removeAt(0);
        _removePiece(removed);
      }

      displayXO[bestMove] = 'O';
      oMoves.add(bestMove);
      xTurn = true;
      _updateLockedTile();
    });
    //check if it is the winning move for 'O'
    _checkGameOver();
  }

  // X tries to maximize, O tries to minimize.
  //Adverserial search - recurrsive to simulate all board possibilities and assigns points for it.
  int _minimax(List<String> board, bool isMaximizing) {
    String? result = _whoWon(board);
    if (result != null) {
      if (result == 'X') return 10; // better to win early
      if (result == 'O') return -10; //better to lose late
      return 0; //draw
    }
    //if board is full, returns 0
    if (!board.contains(' ')) {
      return 0;
    }
    // X's turn
    if (isMaximizing) {
      //starts with the worst case by having the least score
      int bestScore = -1000;
      for (int i = 0; i < board.length; i++) {
        // if space is blank:
        if (board[i] == ' ') {
          //Place X in the blank
          board[i] = 'X';
          //recursively calling minimax for 'O'
          int score = _minimax(board, false);
          //undoing the move
          board[i] = ' ';
          //Maximizing score for X
          if (score > bestScore) bestScore = score;
        }
      }
      //returns the maximum score of each board simulation
      return bestScore;
    }
    //O's turn
    else {
      //starts with the worst case by having the maximum score
      int bestScore = 1000;
      for (int i = 0; i < board.length; i++) {
        // if space is blank:
        if (board[i] == ' ') {
          //Place O in the blank
          board[i] = 'O';
          //recursively calling minimax for 'X'
          int score = _minimax(board, true);
          //undoing the move
          board[i] = ' ';
          //Minimizing score for O
          if (score < bestScore) bestScore = score;
        }
      }
      //returns the minimum score of each board simulation
      return bestScore;
    }
  }

  // Removes piece from given spot
  void _removePiece(int index) {
    setState(() {
      displayXO[index] = ' ';
    });
  }

  //Check's winner
  String? _whoWon(List<String> b) {
    // check rows - if it is not empty and if they are all equal, return the character in the index
    for (int i = 0; i < 3; i++) {
      if (b[i * 3] != ' ' &&
          b[i * 3] == b[i * 3 + 1] &&
          b[i * 3] == b[i * 3 + 2]) {
        return b[i * 3];
      }
    }
    // check columns - if it is not empty and if they are all equal, return the character in the index
    for (int i = 0; i < 3; i++) {
      if (b[i] != ' ' && b[i] == b[i + 3] && b[i] == b[i + 6]) {
        return b[i];
      }
    }
    // check diagonals - if it is not empty and if they are all equal, return the character in the index
    if (b[0] != ' ' && b[0] == b[4] && b[0] == b[8]) {
      return b[0];
    }
    // check anti diagonals - if it is not empty and if they are all equal, return the character in the index
    if (b[2] != ' ' && b[2] == b[4] && b[2] == b[6]) {
      return b[2];
    }
    // if nothing is matching, return null
    return null;
  }

  //Displays result
  String? _checkGameOver() {
    String? winner = _whoWon(displayXO);
    if (winner != null) {
      _showDialog("$winner wins!");
      return winner;
    }
    //Even if _whoWon() return null, display shouldn't contain " "
    if (!displayXO.contains(' ')) {
      _showDialog("It's a Draw!");
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

  //Reset the board - assign empty array
  void _resetGame() {
    setState(() {
      _initializeBoard();
      xTurn = true;
      _updateLockedTile();
    });
  }

  //rules dialog box
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
                  height: 280,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Tic-Tac-Lock Rules",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 14),
                            Text(
                              "• Take turns placing X or O on empty, unlocked cells.",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "• Each player can have at most 3 marks on the board.",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "• After 3 marks, the oldest mark is locked (grayed out).",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "• On your 4th move, your oldest mark is removed before placing a new one.",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "• First to line up 3 wins. There is NO draw",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: Text(
                                "Try and make 3 in a row!",
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
            ),
          ),
    );
  }
}
