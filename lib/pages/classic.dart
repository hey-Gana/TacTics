import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/pages/rules.dart';

class ClassicPage extends StatefulWidget {
  const ClassicPage({super.key});

  @override
  State<ClassicPage> createState() => _ClassicPageState();
}

class _ClassicPageState extends State<ClassicPage> {
  final int boardSize = 3;
  late List<String> displayXO;
  late List<int> rows; //Rows Counters list
  late List<int> cols; //Columns counters list
  int diag = 0;
  int antiDiag = 0;
  bool xturn = true; //First person to play as 'X'

  //Initializing list for values inside the grid and the grid
  @override
  void initState() {
    super.initState();
    displayXO = List.filled(boardSize * boardSize, ' ');
    rows = List.filled(boardSize, 0);
    cols = List.filled(boardSize, 0);
    diag = 0;
    antiDiag = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Classic Tic-Tac-Toe")),
        actions: [
          IconButton(
            onPressed: _showRules,
            icon: Icon(Icons.model_training_rounded),
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
                  'Turn: ${xturn ? "X" : "O"}',
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
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: const Color.fromARGB(255, 19, 26, 34),
                          ),
                          color: const Color.fromARGB(255, 37, 60, 99),
                        ),
                        child: Center(
                          //inside the tile
                          child: Text(
                            displayXO[index],
                            style: TextStyle(fontSize: 64),
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
                      child: Icon(Icons.restart_alt_rounded),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100.0),
            ],
          ),
        ),
      ),
    );
  }

  //Function to switch between X and O
  //Only if tile is empty, value will be accepted
  void _tapped(int index) {
    setState(() {
      if (xturn && displayXO[index] == ' ') {
        displayXO[index] = "X";
      } else {
        displayXO[index] = "O";
      }
      _checkWinner(index);
      xturn = !xturn;
    });
  }

  void _checkWinner(int index) {
    //Converting index into 2D values of i,j ; i=row; j=col;
    int row = index ~/ 3;
    int col = index % 3;

    //If index has X, 1 is added else 1 is subtracted in the index of the displayXO array
    int add = displayXO[index] == 'X' ? 1 : -1;

    //assigning the added value into rows array - row counter
    rows[row] += add;
    //assigning the added value into cols array - col counter
    cols[col] += add;
    //Checking for diagnals - diag counter
    if (row == col) diag += add;
    //checking for anti-diagnals - anti diag counter
    if (row + col == boardSize - 1) antiDiag += add;

    //if any of the ABSOLUTE values are equal to board size, then declare as winner the value present in the index
    //winner becomes true if boardsize is matched by any of the counters
    bool winner =
        rows[row].abs() == boardSize ||
        cols[col].abs() == boardSize ||
        diag.abs() == boardSize ||
        antiDiag.abs() == boardSize;

    if (winner) {
      _showWinDialog(displayXO[index]); //whichever index has won
      return;
    }
    if (!displayXO.contains(" ")) {
      //if all the boxes are filled -  it is draw
      _showDrawDialog();
    }
  }

  //Alert Dialog Box for displaying winner
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

  //Alert Dialog box for draw
  void _showDrawDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("It's a Draw!"),
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

  //Function to reset the game after clicking on play again
  void _resetGame() {
    setState(() {
      displayXO = List.filled(boardSize * boardSize, ' ');
      rows = List.filled(boardSize, 0);
      cols = List.filled(boardSize, 0);
      diag = 0;
      antiDiag = 0;
      xturn = true;
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
