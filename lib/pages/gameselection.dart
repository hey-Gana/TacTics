import 'package:flutter/material.dart';

// Import all your game pages
import 'classic.dart';
import 'classicai.dart';
import 'xolock.dart';
import 'xolockai.dart';
import 'anti.dart';
import 'antiai.dart';

enum GameVariation { classic, ticTacLock, antiTicTacToe }

enum Opponent { twoPlayer, vsComputer }

class GameSelectionPage extends StatefulWidget {
  const GameSelectionPage({Key? key}) : super(key: key);

  @override
  _GameSelectionPageState createState() => _GameSelectionPageState();
}

class _GameSelectionPageState extends State<GameSelectionPage> {
  GameVariation? _selectedVariation;
  Opponent? _selectedOpponent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Select Game Mode")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 40.0),
              const Text(
                "- Select Game Mode - ",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.0),
              // Game variation selector
              const Text("Choose Game Variation:"),
              DropdownButton<GameVariation>(
                value: _selectedVariation,
                hint: const Text("Select variation"),
                items:
                    GameVariation.values.map((variation) {
                      return DropdownMenuItem(
                        value: variation,
                        child: Center(
                          child: Text(variationToString(variation)),
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() => _selectedVariation = value);
                },
              ),

              const SizedBox(height: 20),

              // Opponent selector
              const Text("Choose Opponent:"),
              DropdownButton<Opponent>(
                value: _selectedOpponent,
                hint: const Text("Select opponent"),
                items:
                    Opponent.values.map((opponent) {
                      return DropdownMenuItem(
                        value: opponent,
                        child: Center(child: Text(opponentToString(opponent))),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() => _selectedOpponent = value);
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed:
                    (_selectedVariation != null && _selectedOpponent != null)
                        ? () {
                          final Widget page = getPage(
                            _selectedVariation!,
                            _selectedOpponent!,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => page),
                          );
                        }
                        : null,
                child: const Text("Start Game"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String variationToString(GameVariation v) {
    switch (v) {
      case GameVariation.classic:
        return "Classic Tic-Tac-Toe";
      case GameVariation.ticTacLock:
        return "Tic-Tac-Lock";
      case GameVariation.antiTicTacToe:
        return "Anti Tic-Tac-Toe";
    }
  }

  String opponentToString(Opponent o) {
    switch (o) {
      case Opponent.twoPlayer:
        return "2 Player";
      case Opponent.vsComputer:
        return "Vs Computer";
    }
  }

  Widget getPage(GameVariation variation, Opponent opponent) {
    switch (variation) {
      case GameVariation.classic:
        if (opponent == Opponent.twoPlayer) {
          return const ClassicPage();
        } else {
          return const Classicai();
        }
      case GameVariation.ticTacLock:
        if (opponent == Opponent.twoPlayer) {
          return const Xolock();
        } else {
          return const Xolockai();
        }
      case GameVariation.antiTicTacToe:
        if (opponent == Opponent.twoPlayer) {
          return const AntiPage();
        } else {
          return const Antiai();
        }
    }
  }
}
