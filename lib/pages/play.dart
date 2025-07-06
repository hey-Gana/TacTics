import 'package:flutter/material.dart';
import 'package:gobblets_gobblers_game/pages/classic.dart';

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
                  // Navigate to the classic page
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClassicPage(),
                      ),
                    );
                  });
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Classic Tic-Tac-Toe",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  //print("Lock");
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Tic-Tac-Lock", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: FloatingActionButton.extended(
                onPressed: () {
                  //print("GG");
                },
                label: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
