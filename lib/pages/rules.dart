//This is the rules page - contains different sections for the variations of the tic-tac-toe games.
import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/Data/rules_data.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  bool tileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ExpansionTile(
            title: Center(child: Text("Classic Tic-Tac-Toe")),
            children:
                classicTTT.map((point) {
                  return ListTile(
                    leading: Icon(Icons.circle, size: 8),
                    title: Text(point),
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
          ),
          ExpansionTile(
            title: Center(child: Text("Sliding Tic-Tac-Toe")),
            children:
                slidingTTT.map((point) {
                  return ListTile(
                    leading: Icon(Icons.circle, size: 8),
                    title: Text(point),

                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
          ),
          ExpansionTile(
            title: Center(child: Text("Gobblet Gobblers")),
            children:
                gobbletgobblerTTT.map((point) {
                  return ListTile(
                    leading: Icon(Icons.circle, size: 8),
                    title: Text(point),

                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
