import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/pages/rules.dart';

class Gobbletgobblers extends StatefulWidget {
  const Gobbletgobblers({super.key});

  @override
  State<Gobbletgobblers> createState() => _GobbletgobblersState();
}

//Players
enum Player { X, O }

//sizes of pieces
enum SizeType { s, m, l }

//defining Piece class - Model of the pieces
class Piece {
  final Player owner;
  final SizeType size;
  Piece(this.owner, this.size); //constructor to initialize
}

//List of pieces for each player
List<Piece> pXPieces = [
  Piece(Player.X, SizeType.s),
  Piece(Player.X, SizeType.s),
  Piece(Player.X, SizeType.s),
  Piece(Player.X, SizeType.m),
  Piece(Player.X, SizeType.m),
  Piece(Player.X, SizeType.l),
];

List<Piece> pOPieces = [
  Piece(Player.O, SizeType.s),
  Piece(Player.O, SizeType.s),
  Piece(Player.O, SizeType.s),
  Piece(Player.O, SizeType.m),
  Piece(Player.O, SizeType.m),
  Piece(Player.O, SizeType.l),
];

//build of the pieces
Widget buildPieceIcon(Piece piece) {
  double size;
  switch (piece.size) {
    case SizeType.s:
      size = 35;
      break;
    case SizeType.m:
      size = 60;
      break;
    case SizeType.l:
      size = 75;
      break;
  }

  return Icon(
    piece.owner == Player.X ? Icons.details_sharp : Icons.trip_origin_sharp,
    //color: piece.owner == Player.X ? Colors.red : Colors.blue,
    size: size,
  );
}

Widget buildPlayerPieces(List<Piece> pieces) {
  return Center(
    child: Wrap(
      spacing: 8,
      alignment: WrapAlignment.center,
      children: pieces.map(buildPieceIcon).toList(),
    ),
  );
}

class _GobbletgobblersState extends State<Gobbletgobblers> {
  //Game setups
  final int boardSize = 3;

  late List<int> rows; //Rows Counters list
  late List<int> cols; //Columns counters list
  //diag and anti-diag counter
  int diag = 0;
  int antiDiag = 0;
  bool xturn = false;

  Player currentPlayer = Player.X; //First player is X
  //Creating a list of lists for the board
  // List<List<List<Piece>>> boardSize*boardSize ;
  //track Pieces left by X and O
  List<Piece> playerXPieces = [];
  List<Piece> playerOPieces = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Gobblet Gobblers")),
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
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Turn: ${xturn ? "X" : "O"}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(child: buildPlayerPieces(pOPieces)),
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
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 5,
                          color: const Color.fromARGB(255, 19, 26, 34),
                        ),
                        color: const Color.fromARGB(255, 37, 60, 99),
                      ),
                      child: Center(child: Text(" ")),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(child: buildPlayerPieces(pXPieces)),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 40,
                width: 100,
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.restart_alt_rounded),
                ),
              ),
            ),
            SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}
