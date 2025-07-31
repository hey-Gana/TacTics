import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/pages/rules.dart';

class Xolock extends StatefulWidget {
  const Xolock({super.key});

  @override
  State<Xolock> createState() => _XolockState();
}

class _XolockState extends State<Xolock> {
  final int boardSize = 3;
  late List<String> displayXO;
  late List<int> rows; //Rows Counters list
  late List<int> cols; //Columns Counters List
  int diag = 0;
  int antiDiag = 0;
  bool xTurn = true; //First person to play is 'X'

  List<int> xMoves = []; //Keeps record of indexes which X has moved
  List<int> oMoves = []; //Keeps record of indexes which O has moved

  int? tempLockedIndex; //temporary index to store locked tile value on 4th turn

  //Initializing list for values inside the grid and the grid
  @override
  void initState() {
    super.initState();
    _initializeBoard();
    _updateLockedTile();
  }

  void _initializeBoard() {
    //initializes empty board
    displayXO = List.filled(boardSize * boardSize, ' ');
    //initializing counters to 0
    rows = List.filled(boardSize, 0);
    cols = List.filled(boardSize, 0);
    diag = 0;
    antiDiag = 0;
    //empty list of xmoves and omoves
    xMoves.clear();
    oMoves.clear();
    //temp index is null
    tempLockedIndex = null;
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
                  'Turn: ${xTurn ? "X" : "O"}',
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
                  itemBuilder: (BuildContext context, int index) {
                    final isLocked = index == tempLockedIndex;
                    return GestureDetector(
                      onTap: () {
                        //Only when the tile is not locked and empty, it will be tapped
                        if (!isLocked && displayXO[index] == ' ') {
                          _tapped(index);
                        }
                      },
                      child: Container(
                        // margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: const Color.fromARGB(255, 19, 26, 34),
                          ),
                          color:
                              //if locked, it will be greyed out ; else it will be blue
                              isLocked
                                  ? Colors.grey[700]
                                  : Color.fromARGB(255, 37, 60, 99),
                        ),
                        child: Center(
                          //Inside the tile
                          child: Text(
                            displayXO[index] == ' ' ? '' : displayXO[index],
                            style: TextStyle(
                              fontSize: 64,
                              //if locked, element is greyed out, else it is white
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

  //Function to lock the tile with index of 1st tile of the player
  void _updateLockedTile() {
    if (xTurn && xMoves.length == 3) {
      tempLockedIndex = xMoves.first; //stores first value in the list
    } else if (!xTurn && oMoves.length == 3) {
      tempLockedIndex = oMoves.first; //stores first value in the list
    } else {
      tempLockedIndex = null;
    }
  }

  void _tapped(int index) {
    setState(() {
      _updateLockedTile(); // Lock oldest tile before playing

      if (xTurn && xMoves.length == 3) {
        int removed = xMoves.removeAt(0); //popping element from the 0th index
        //call removePiece to remove the popped element
        _removePiece(removed, 1);
      } else if (!xTurn && oMoves.length == 3) {
        int removed = oMoves.removeAt(0); //popping element from the 0th index
        //call removePiece to remove the popped element
        _removePiece(removed, -1);
      }

      displayXO[index] = xTurn ? 'X' : 'O';
      (xTurn ? xMoves : oMoves).add(index);
      _updateCounters(index, xTurn ? 1 : -1);

      _checkWinner(index);

      xTurn = !xTurn;
      _updateLockedTile(); //reassigns temp index to null
    });
  }

  //4th turn for player - remove piece
  void _removePiece(int index, int value) {
    displayXO[index] = ' '; //reassigning it to blank again
    int row = index ~/ boardSize;
    int col = index % boardSize;
    //decreases the counter to ensure winner checker is done properly
    rows[row] -= value;
    cols[col] -= value;
    if (row == col) diag -= value;
    if (row + col == boardSize - 1) antiDiag -= value;
  }

  //Counters increament
  void _updateCounters(int index, int value) {
    int row = index ~/ boardSize;
    int col = index % boardSize;
    rows[row] += value;
    cols[col] += value;
    if (row == col) diag += value;
    if (row + col == boardSize - 1) antiDiag += value;
  }

  //Check winner
  void _checkWinner(int index) {
    int row = index ~/ boardSize;
    int col = index % boardSize;

    if (rows[row].abs() == boardSize ||
        cols[col].abs() == boardSize ||
        diag.abs() == boardSize ||
        antiDiag.abs() == boardSize) {
      _showWinDialog(displayXO[index]);
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("$winner Wins!"),
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
    setState(() {
      _initializeBoard();
      xTurn = true;
      _updateLockedTile();
    });
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
