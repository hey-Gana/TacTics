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
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            ExpansionTile(
              title: Center(child: Text("Classic Tic-Tac-Toe")),
              collapsedBackgroundColor: const Color.fromARGB(255, 30, 63, 120),
              children:
                  classicTTT.map((point) {
                    return ListTile(
                      leading: Icon(Icons.circle, size: 8),
                      title: Text(point),
                      visualDensity: VisualDensity.comfortable,
                    );
                  }).toList(),
            ),
            SizedBox(height: 20.0),
            ExpansionTile(
              title: Center(child: Text("Tic-Tac-Lock")),
              collapsedBackgroundColor: const Color.fromARGB(255, 30, 63, 120),
              children:
                  tttLock.map((point) {
                    return ListTile(
                      leading: Icon(Icons.circle, size: 8),
                      title: Text(point),
                      visualDensity: VisualDensity.comfortable,
                    );
                  }).toList(),
            ),
            SizedBox(height: 20.0),
            ExpansionTile(
              title: Center(child: Text("Gobblet Gobblers")),
              collapsedBackgroundColor: const Color.fromARGB(255, 30, 63, 120),
              children:
                  gobbletgobblerTTT.map((point) {
                    return ListTile(
                      leading: Icon(Icons.circle, size: 8),
                      title: Text(point),
                      visualDensity: VisualDensity.comfortable,
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
