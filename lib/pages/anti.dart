//Need to change to suit Anti Tic Tac Rules
import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/pages/rules.dart';

class AntiPage extends StatefulWidget {
  const AntiPage({super.key});

  @override
  State<AntiPage> createState() => _AntiPageState();
}

class _AntiPageState extends State<AntiPage> {
  final int boardSize = 3;
  late List<String> displayXO;
  late List<int> rows; //Rows Counters list
  late List<int> cols; //Columns counters list
  int diag = 0;
  int antiDiag = 0;
  bool xturn = true; //First person to play as 'X'

  //List for values inside the grid
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
        title: Center(child: const Text("Anti Tic-Tac-Toe")),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 60,
                        ), // distance from top
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 400,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: RulesPage(),
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            },
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
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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

    //if any of the values are equal to board size, then declare as winner
    bool loser =
        rows[row].abs() == boardSize ||
        cols[col].abs() == boardSize ||
        diag.abs() == boardSize ||
        antiDiag.abs() == boardSize;

    if (loser) {
      if (displayXO[index] == "X") {
        _showWinDialog("O");
      } else {
        _showWinDialog("X");
      }
      return;
    }
    if (!displayXO.contains(" ")) {
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
}
