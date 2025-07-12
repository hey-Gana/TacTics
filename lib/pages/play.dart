import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/pages/anti.dart';
import 'package:gobblets_gobblers_game/pages/classic.dart';
import 'package:gobblets_gobblers_game/pages/gobbletgobblers.dart';
import 'package:gobblets_gobblers_game/pages/xolock.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ClassicPage(),
                    ),
                  );
                },
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Classical Tic-Tac-Toe",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Xolock()),
                  );
                },
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Tic-Tac-Lock", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AntiPage()),
                  );
                },
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Anti Version of Tic-Tac-Toe",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Gobbletgobblers(),
                    ),
                  );
                },
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Gobblet Gobblers",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
